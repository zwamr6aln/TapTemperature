
import SwiftUI
import HealthKit


struct ContentView: View {
    
    let 🏥HealthStore = HKHealthStore()
    
    var 🅀uantityTemp: HKQuantity {
        HKQuantity(unit: .kelvin(), doubleValue: Double(📝Temp)/10)
    }
    
    var 🄳ataTemp: HKQuantitySample {
        HKQuantitySample(type: HKQuantityType(.bodyTemperature),
                         quantity: 🅀uantityTemp,
                         start: .now,
                         end: .now)
    }
    
    @AppStorage("Temp") var 📝Temp = 36.0
    
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
