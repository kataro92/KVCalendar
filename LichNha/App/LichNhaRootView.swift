import SwiftUI
import ContentCore

struct LichNhaRootView: View {
    @State private var session: AppSession
    @Environment(\.scenePhase) private var scenePhase

    init(session: AppSession = AppSession()) {
        _session = State(initialValue: session)
    }

    var body: some View {
        Group {
            switch session.surface {
            case .todayFront:
                TodayRootView(session: session)
            case .dayBack:
                DayBackView(session: session)
            case .month:
                MonthSheetView(session: session)
            case .events:
                EventListView(session: session)
            case .eventEditor:
                EventEditorView(session: session)
            case .paperDrawer:
                PaperDrawerView(session: session)
            }
        }
        .sheet(item: Binding(
            get: { session.presentedSourceID.map { SourceSheetItem(id: $0) } },
            set: { session.presentedSourceID = $0?.id }
        )) { item in
            if let source = session.catalog?.source(id: item.id) {
                SourceDetailView(source: source) {
                    session.presentedSourceID = nil
                }
            } else {
                VStack(spacing: 12) {
                    Text("Không tìm thấy nguồn \(item.id).")
                    Button("Đóng") { session.presentedSourceID = nil }
                }
                .padding()
            }
        }
        .onAppear {
            let cache = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("ContentPacksCache", isDirectory: true)
            session.loadCatalog(cache: cache)
            let effectCache = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("EffectPacksCache", isDirectory: true)
            session.loadEffects(cache: effectCache)
            session.reloadPersonalEvents()
            if let url = LaunchConfiguration.openURL, let civil = MonthRouter.civil(fromDeepLink: url) {
                session.applyDeepLink(civil: civil)
            }
            session.applyLaunchSurface()
            session.publishWidgetSnapshots()
            session.applyIdleTimer(sceneActive: true)
            Task { try? await session.reminderCoordinator.refresh(reason: .appActive) }
        }
        .onChange(of: scenePhase) { _, phase in
            session.applyIdleTimer(sceneActive: phase == .active)
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSSystemTimeZoneDidChange)) { _ in
            Task { try? await session.reminderCoordinator.refresh(reason: .timeZoneChange) }
        }
        .onOpenURL { url in
            if let civil = MonthRouter.civil(fromDeepLink: url) {
                session.applyDeepLink(civil: civil)
            }
        }
    }
}

private struct SourceSheetItem: Identifiable {
    var id: String
}
