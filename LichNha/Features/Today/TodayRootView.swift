import SwiftUI
import CalendarCore
import ContentCore
import EffectCore

struct TodayRootView: View {
    @Bindable var session: AppSession
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.lichNhaDimFlashingLights) private var dimFlashingLights
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dynamicTypeSize) private var typeSize
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOver
    @State private var director = EffectDirector()
    @State private var audio = AmbientAudioCoordinator()
    @State private var toolsExpanded = LaunchConfiguration.isUITesting

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                WallPlasterView()
                if session.calendarModel.day != nil {
                    EffectHostView(
                        director: director,
                        daySeed: daySeed,
                        region: session.preferences.inspirationRegion
                    )
                }
                VStack(spacing: 0) {
                    TodayChromeHeader { session.openSettings() }
                    Color.clear
                        .frame(height: showsTools ? 4 : 10)
                        .contentShape(Rectangle())
                        .onTapGesture { revealTools() }
                    if let day = session.calendarModel.day {
                        calendarBloc(day: day, size: proxy.size)
                    } else {
                        Text(session.calendarModel.loadError ?? "KhÃ´ng tÃ­nh Ä‘Æ°á»£c ngÃ y hÃ´m nay")
                            .foregroundStyle(DesignTokens.chromeInk)
                            .padding()
                    }
                    if let notice = session.catalogNotice {
                        Text(notice)
                            .font(.footnote)
                            .foregroundStyle(DesignTokens.inkSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                    }
                    if showsTools {
                        toolCluster
                            .padding(.top, 12)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    } else {
                        HomeActionDock(
                            onPrevious: goPrevious,
                            onDetail: openDetail,
                            onExpand: revealTools,
                            onReplay: replayScene,
                            onNext: goNext
                        )
                        .padding(.top, 12)
                        .transition(.opacity.combined(with: .scale(scale: 0.97)))
                    }
                    Spacer(minLength: showsTools ? 4 : 12)
                        .contentShape(Rectangle())
                        .onTapGesture { revealTools() }
                    AmbientKeepAwakeBar(
                        ambientOn: session.preferences.isAmbientOn,
                        keepAwake: session.preferences.keepScreenAwake,
                        onAmbient: { session.setAmbientEnabled($0) },
                        onKeepAwake: { value in
                            session.updatePreferences { $0.keepScreenAwake = value }
                        }
                    )
                    .padding(.horizontal, 54)
                    .padding(.bottom, 8)
                }
                .padding(.top, 6)
                .safeAreaPadding(.top)
                .safeAreaPadding(.bottom)
                .modifier(TodayScrollIfNeeded(enabled: typeSize >= .accessibility2))
            }
        }
        .animation(reduceMotion ? nil : .easeOut(duration: DesignTokens.motionFast), value: showsTools)
        .onAppear {
            session.calendarModel.refresh()
            session.syncFromCalendarModel()
            audio.settings = session.audioSettings
            audio.start()
            resolveScene()
            director.noteCalendarTextVisible()
            if session.pendingReplay {
                session.pendingReplay = false
                replayScene()
            }
        }
        .onDisappear { audio.stop() }
        .onChange(of: dayKey) { _, _ in
            resolveScene()
            director.noteCalendarTextVisible()
        }
        .onChange(of: session.preferences.ambient) { _, _ in
            audio.settings = session.audioSettings
            audio.apply()
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .background {
                director.stopForBackground()
                audio.stop()
            } else if phase == .active {
                audio.start()
                director.resumeFromBackground()
            }
        }
    }

    private var showsTools: Bool {
        toolsExpanded || LaunchConfiguration.isUITesting || voiceOver || typeSize >= .accessibility2
    }

    private func revealTools() {
        guard !showsTools else { return }
        director.settleForInteraction()
        toolsExpanded = true
    }

    @ViewBuilder
    private func calendarBloc(day: CalendarDay, size: CGSize) -> some View {
        let width = size.width * DesignTokens.blocWidthRatio
        // R0: object silhouette ~14.5:20.5; a11y slightly taller for Dynamic Type
        let aspect: CGFloat = typeSize >= .accessibility2 ? (14.5 / 18.0) : (14.5 / 20.5)

        ZStack(alignment: .top) {
            PaperStackView(peeled: DailyRitualState.hasPeeled(on: dayKey)) {
                PaperSurface {
                    TodayFrontView(
                        day: day,
                        occurrences: session.catalog?.occurrences(on: day) ?? [],
                        personalTitles: session.personalEvents(on: day.civilDate).map(\.title),
                        sceneCueID: director.resolved.heroCueID
                    )
                }
            }
            .padding(.top, DesignTokens.headerOverlap)
            BlocHeaderView(
                title: "THÃNG \(day.civilDate.month)",
                action: openMonth,
                identifier: "month-button",
                fill: DesignTokens.khanh,
                motionActive: director.phase == .intro
            )
        }
        .overlay(alignment: .topLeading) {
            if director.resolved.heroCueID == "cue-quoc-khanh" {
                HStack(alignment: .bottom, spacing: 3) {
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [DesignTokens.bronzeLight, DesignTokens.bronzeDeep],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 2, height: 36)
                    VietnamFlagMesh(hoist: 16)
                        .offset(y: -8)
                }
                .offset(x: 44, y: -12)
                .allowsHitTesting(false)
                .accessibilityHidden(true)
            }
        }
        .overlay(alignment: .topTrailing) {
            FamilyClipButton(action: openEvents)
                .offset(x: 8, y: DesignTokens.headerHeight - 2)
        }
        .frame(width: width)
        .aspectRatio(aspect, contentMode: .fit)
        .lichNhaPagePeel(
            reduceMotion: reduceMotion,
            onNext: {
                director.settleForInteraction()
                DailyRitualState.markPeeled(on: dayKey)
                session.calendarModel.goToNextDay()
                session.syncFromCalendarModel()
            },
            onPrevious: {
                director.settleForInteraction()
                session.calendarModel.goToPreviousDay()
                session.syncFromCalendarModel()
            }
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in director.settleForInteraction() }
        )
        .accessibilityActions {
            Button("NgÃ y sau") {
                session.calendarModel.goToNextDay()
                session.syncFromCalendarModel()
            }
            Button("NgÃ y trÆ°á»›c") {
                session.calendarModel.goToPreviousDay()
                session.syncFromCalendarModel()
            }
            Button("HÃ´m nay") {
                session.calendarModel.goToToday()
                session.syncFromCalendarModel()
            }
            Button("Xem thÃ¡ng", action: openMonth)
            Button("Xem chi tiáº¿t", action: openDetail)
            Button("PhÃ¡t láº¡i cáº£nh ngÃ y") { replayScene() }
            Button("CÃ i Ä‘áº·t") { session.openSettings() }
            Button("NgÃ y gia Ä‘Ã¬nh", action: openEvents)
            Button(showsTools ? "áº¨n thao tÃ¡c" : "Hiá»‡n thao tÃ¡c") {
                toolsExpanded.toggle()
            }
        }
    }

    @ViewBuilder
    private var toolCluster: some View {
        let stacked = typeSize >= .accessibility2
        Group {
            if stacked {
                VStack(spacing: DesignTokens.spaceSM) {
                    DayNavigationControls(
                        showsToday: !session.calendarModel.isViewingToday,
                        onPrevious: goPrevious,
                        onToday: goToday,
                        onNext: goNext
                    )
                    TodayActionRow(
                        onDetail: openDetail,
                        onReplay: replayScene,
                        returnToMonth: session.canReturnToMonth ? { session.returnToMonth() } : nil
                    )
                }
            } else {
                HStack(spacing: 6) {
                    DayNavigationControls(
                        showsToday: !session.calendarModel.isViewingToday,
                        onPrevious: goPrevious,
                        onToday: goToday,
                        onNext: goNext
                    )
                    TodayActionRow(
                        onDetail: openDetail,
                        onReplay: replayScene,
                        returnToMonth: session.canReturnToMonth ? { session.returnToMonth() } : nil
                    )
                }
                .padding(5)
                .background(DesignTokens.wood.opacity(0.15), in: Capsule())
                .overlay(Capsule().stroke(DesignTokens.wood.opacity(0.18), lineWidth: 0.7))
            }
        }
        .padding(.horizontal, stacked ? 8 : 18)
    }

    private func goPrevious() {
        director.settleForInteraction()
        session.calendarModel.goToPreviousDay()
        session.syncFromCalendarModel()
    }

    private func goNext() {
        director.settleForInteraction()
        DailyRitualState.markPeeled(on: dayKey)
        session.calendarModel.goToNextDay()
        session.syncFromCalendarModel()
    }

    private func goToday() {
        director.settleForInteraction()
        session.calendarModel.goToToday()
        session.syncFromCalendarModel()
    }

    private var dayKey: String {
        "\(session.selectedDate.year)-\(session.selectedDate.month)-\(session.selectedDate.day)"
    }

    private var daySeed: UInt64 {
        OrdinaryDaySeed.value(
            year: session.selectedDate.year,
            month: session.selectedDate.month,
            day: session.selectedDate.day
        )
    }

    private func replayScene() {
        director.requestReplay()
        resolveScene()
        director.noteCalendarTextVisible()
    }

    private func openMonth() {
        director.settleForInteraction()
        session.openMonth()
    }

    private func openDetail() {
        director.settleForInteraction()
        session.openDayBack()
    }

    private func openEvents() {
        director.settleForInteraction()
        session.openEvents()
    }

    private func resolveScene() {
        guard let day = session.calendarModel.day else { return }
        let capability = CapabilityPolicy.snapshot(
            reduceMotion: reduceMotion,
            dimFlashingLights: dimFlashingLights
        )
        let level = AccessibilityEffectPolicy.resolvedLevel(
            preference: session.preferences.motion,
            capability: capability
        )
        let occurrenceIDs = session.catalog?.occurrences(on: day).map(\.id) ?? []
        let cueID = EffectResolver.selectedCue(
            from: EffectResolverInput(
                occurrenceIDs: occurrenceIDs,
                solarTermIndex: day.solarTerm?.index,
                cues: session.effectCatalog?.cues ?? []
            )
        )?.id ?? "none"
        let introSeen = DailyRitualState.hasSeenEffectIntro(on: dayKey, cueID: cueID)
        let input = EffectResolverInput(
            occurrenceIDs: occurrenceIDs,
            solarTermIndex: day.solarTerm?.index,
            cues: session.effectCatalog?.cues ?? [],
            assets: session.effectCatalog?.assets ?? [],
            effectLevel: level,
            reduceMotion: capability.reduceMotion,
            dimFlashingLights: capability.dimFlashingLights,
            lowPower: capability.lowPower,
            thermalSevere: capability.thermalSevere,
            introSeenToday: introSeen,
            replayRequested: director.replayRequested
        )
        let scene = EffectResolver.resolve(input)
        director.apply(scene, seed: daySeed)
        if let hero = scene.heroCueID, scene.introPlays {
            DailyRitualState.markEffectIntro(on: dayKey, cueID: hero)
        }
    }
}

private struct TodayScrollIfNeeded: ViewModifier {
    var enabled: Bool

    func body(content: Content) -> some View {
        if enabled {
            ScrollView {
                content
            }
            .defaultScrollAnchor(.top)
            .scrollBounceBehavior(.basedOnSize)
        } else {
            content
        }
    }
}

