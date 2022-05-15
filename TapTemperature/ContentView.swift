
import SwiftUI
import HealthKit


struct ContentView: View {
    
    @AppStorage("BodyTemperature") var BodyTemperature = 36.0
    
    var body: some View {
        Text(BodyTemperature.description + "℃")
            .padding()
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
