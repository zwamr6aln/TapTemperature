
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
        case .℉: return .degreeFahrenheit()
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
    
    @State private var 体温: [Int] = [3,6,6]
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(alignment: .firstTextBaseline) {
                if 体温.count >= 1 {
                    Text(体温[0].description)
                } else {
                    Text("3")
                }
                
                if 体温.count >= 2 {
                    Text(体温[1].description)
                } else {
                    Text("_")
                        .scaleEffect(y: 0.5, anchor: .bottom)
                }
                
                Text(".")
                
                if 体温.count >= 3 {
                    Text(体温[2].description)
                } else {
                    Text("_")
                        .opacity(0)
                        .scaleEffect(y: 0.5, anchor: .bottom)
                }
                
                if 体温.count == 4 {
                    Text(体温[3].description)
                } else {
                    EmptyView()
                }
                
                Text("℃")
                    .minimumScaleFactor(0.1)
                    .scaledToFit()
                    .font(.system(size: 54, weight: .bold))
            }
            .font(.system(size: 81, weight: .bold))
            .monospacedDigit()
            .padding(32)
            
            Spacer()
            
            Divider()
            
            KeyboardView()
                .padding(.vertical)
                .onTapGesture {
                    🏥HealthStore.save(🄳ataTemp) { 🆗, 👿 in
                        if 🆗 {
                            print(".save/.bodyTemp: Success")
                        } else {
                            print("👿:", 👿.debugDescription)
                        }
                    }
                }
        }
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
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
