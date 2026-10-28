import SwiftUI

@main
struct NoemaApp: App {
    @StateObject private var store = Store()

    var body: some Scene {
        WindowGroup("Noema") {
            ContentView()
                .environmentObject(store)
                .task { await store.refresh() }
                .frame(minWidth: 960, minHeight: 600)
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 1180, height: 760)
        .commands {
            CommandGroup(after: .newItem) {
                Button("Check Now") { Task { await store.refresh() } }.keyboardShortcut("r")
            }
        }
    }
}
