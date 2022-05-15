
import SwiftUI
import HealthKit


enum 🄴numUnit: String, CaseIterable {
    case ℃
    case ℉
}


struct ContentView: View {
    
    let 🏥HealthStore = HKHealthStore()
    
    var 🅄nit: HKUnit {
        switch 🛠Unit {
        case .℃: return .degreeCelsius()
        case .℉: return .kelvin()
        }
    }
    
    var 🅀uantityTemp: HKQuantity {
        HKQuantity(unit: 🅄nit, doubleValue: 📝Temp)
    }
    
    var 🄳ataTemp: HKQuantitySample {
        HKQuantitySample(type: HKQuantityType(.bodyTemperature),
                         quantity: 🅀uantityTemp,
                         start: .now,
                         end: .now)
    }
    
    @AppStorage("Temp") var 📝Temp = 36.0
    
    @AppStorage("Unit") var 🛠Unit: 🄴numUnit = .℃
    
    var body: some View {
        Text(📝Temp.description + "℃")
            .padding()
            .onAppear {
                let 🅃ype: Set<HKSampleType> = [HKQuantityType(.bodyTemperature)]
                🏥HealthStore.requestAuthorization(toShare: 🅃ype, read: nil) { 🆗, 👿 in
                    if 🆗 {
                        print("requestAuthorization/bodyTemp: Success")
                    } else {
                        print("👿:", 👿.debugDescription)
                    }
                }
            }
        
        KeyboardView()
        
        Button {
            🏥HealthStore.save(🄳ataTemp) { 🆗, 👿 in
                if 🆗 {
                    print(".save/.bodyTemp: Success")
                } else {
                    print("👿:", 👿.debugDescription)
                }
            }
        } label: {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 120))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .pink)
                .padding()
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
