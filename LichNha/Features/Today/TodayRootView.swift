import SwiftUI
import CalendarCore
import ContentCore
import EffectCore

struct TodayRootView: View {
    @Bindable var session: AppSession
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.lichNhaDimFlashingLights) private var dimFlashingLights
    @Environment(\.scenePhase) private var scenePhase
    @State private var director = EffectDirector()
    @State private var audio = AmbientAudioCoordinator()

    var body: some View {
        CalendarMountView(
            backdrop: {
                if session.calendarModel.day != nil {
                    EffectHostView(
                        director: director,
                        daySeed: daySeed,
                        region: session.preferences.inspirationRegion
                    )
                }
            }
        ) {
            VStack(spacing: DesignTokens.spaceMD) {
                if let day = session.calendarModel.day {
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
                    }
                } else {
                    Text(session.calendarModel.loadError ?? "Không tính được ngày hôm nay")
                        .padding()
                }
                if let notice = session.catalogNotice {
                    Text(notice)
                        .font(.footnote)
                        .foregroundStyle(DesignTokens.inkSecondary)
                }
                DayNavigationControls(
                    onPrevious: {
                        session.calendarModel.goToPreviousDay()
                        session.syncFromCalendarModel()
                    },
                    onNext: {
                        DailyRitualState.markPeeled(on: dayKey)
                        session.calendarModel.goToNextDay()
                        session.syncFromCalendarModel()
                    }
                )
                HStack {
                    Button("Xem tháng") { session.openMonth() }
                        .lichNhaHitTarget()
                        .accessibilityIdentifier("month-button")
                    Button("Xem chi tiết") { session.openDayBack() }
                        .lichNhaHitTarget()
                        .accessibilityIdentifier("detail-button")
                }
                .buttonStyle(.bordered)
                .tint(DesignTokens.wood)
                Button("Ngày gia đình") { session.openEvents() }
                    .lichNhaHitTarget()
                    .buttonStyle(.bordered)
                    .tint(DesignTokens.wood)
                    .accessibilityIdentifier("events-button")
                Button("Phát lại cảnh ngày") { replayScene() }
                    .lichNhaHitTarget()
                    .buttonStyle(.bordered)
                    .tint(DesignTokens.wood)
                    .accessibilityIdentifier("replay-scene")
                Button("Cài đặt") { session.openSettings() }
                    .lichNhaHitTarget()
                    .buttonStyle(.bordered)
                    .tint(DesignTokens.wood)
                    .accessibilityIdentifier("settings-button")
                if session.canReturnToMonth {
                    Button("Quay lại tháng") { session.returnToMonth() }
                        .lichNhaHitTarget()
                        .accessibilityIdentifier("back-to-month")
                }
                TodayButton(
                    isHidden: session.calendarModel.isViewingToday,
                    action: {
                        session.calendarModel.goToToday()
                        session.syncFromCalendarModel()
                    }
                )
            }
        }
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
