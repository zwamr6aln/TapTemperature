
import SwiftUI


@main
struct TapTemperatureApp: App {
    
    let 📱 = 📱Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
        }
    }
}
