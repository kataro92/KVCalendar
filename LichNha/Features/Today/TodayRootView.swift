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
                    Spacer(minLength: showsTools ? 8 : 28)
                        .contentShape(Rectangle())
                        .onTapGesture { revealTools() }
                    if let day = session.calendarModel.day {
                        calendarBloc(day: day, size: proxy.size)
                    } else {
                        Text(session.calendarModel.loadError ?? "Không tính được ngày hôm nay")
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
                            .padding(.top, DesignTokens.spaceMD)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                    Spacer(minLength: showsTools ? 8 : 44)
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
                    .padding(.horizontal, 18)
                    .padding(.bottom, 10)
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
        toolsExpanded = true
    }

    @ViewBuilder
    private func calendarBloc(day: CalendarDay, size: CGSize) -> some View {
        let width = size.width * DesignTokens.blocWidthRatio
        let height = min(max(size.height * 0.47, 310), 410)
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
                title: nil,
                action: { session.openMonth() },
                identifier: "month-button",
                fill: DesignTokens.khanh
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
                .offset(x: 52, y: -18)
                .allowsHitTesting(false)
                .accessibilityHidden(true)
            }
        }
        .overlay(alignment: .topTrailing) {
            if showsTools {
                FamilyClipButton { session.openEvents() }
                    .offset(x: 8, y: DesignTokens.headerHeight - 2)
            }
        }
        .frame(width: width, height: height)
        .lichNhaPagePeel(
            reduceMotion: reduceMotion,
            onNext: {
                DailyRitualState.markPeeled(on: dayKey)
                session.calendarModel.goToNextDay()
                session.syncFromCalendarModel()
            },
            onPrevious: {
                session.calendarModel.goToPreviousDay()
                session.syncFromCalendarModel()
            }
        )
        .accessibilityActions {
            Button("Ngày sau") {
                session.calendarModel.goToNextDay()
                session.syncFromCalendarModel()
            }
            Button("Ngày trước") {
                session.calendarModel.goToPreviousDay()
                session.syncFromCalendarModel()
            }
            Button("Hôm nay") {
                session.calendarModel.goToToday()
                session.syncFromCalendarModel()
            }
            Button("Xem tháng") { session.openMonth() }
            Button("Xem chi tiết") { session.openDayBack() }
            Button("Phát lại cảnh ngày") { replayScene() }
            Button("Cài đặt") { session.openSettings() }
            Button("Ngày gia đình") { session.openEvents() }
            Button(showsTools ? "Ẩn thao tác" : "Hiện thao tác") {
                toolsExpanded.toggle()
            }
        }
    }

    @ViewBuilder
    private var toolCluster: some View {
        let stacked = typeSize >= .accessibility2
        VStack(spacing: DesignTokens.spaceSM) {
            DayNavigationControls(
                showsToday: !session.calendarModel.isViewingToday,
                onPrevious: goPrevious,
                onToday: goToday,
                onNext: goNext
            )
            TodayActionRow(
                onDetail: { session.openDayBack() },
                onReplay: replayScene,
                returnToMonth: session.canReturnToMonth ? { session.returnToMonth() } : nil
            )
        }
        .padding(.horizontal, stacked ? 8 : 16)
    }

    private func goPrevious() {
        session.calendarModel.goToPreviousDay()
        session.syncFromCalendarModel()
    }

    private func goNext() {
        DailyRitualState.markPeeled(on: dayKey)
        session.calendarModel.goToNextDay()
        session.syncFromCalendarModel()
    }

    private func goToday() {
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
            .scrollBounceBehavior(.basedOnSize)
        } else {
            content
        }
    }
}
