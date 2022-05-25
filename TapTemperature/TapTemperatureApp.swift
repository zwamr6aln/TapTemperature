
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

// TODO: Implement basal temp
// TODO: Implement unit ℉
// TODO: Implement auto complete
//
// TODO: Implement local history
// TODO: Implement document view
// TODO: Add localization
// TODO: Add README.md
