
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
    
    @State private var 体温: [Int] = [3]
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(alignment: .firstTextBaseline) {
                if 体温.indices.contains(0) {
                    Text(体温[0].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                        }
                }
                
                if 体温.indices.contains(1) {
                    Text(体温[1].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                                .opacity(体温.count < 1 ? 0 : 1)
                        }
                }
                
                Text(".")
                
                if 体温.indices.contains(2) {
                    Text(体温[2].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                                .opacity(体温.count < 2 ? 0 : 1)
                        }
                }
                
                if 体温.indices.contains(3) {
                    Text(体温[3].description)
                } else {
                    EmptyView()
                }
                
                Text(🛠Unit.rawValue)
                    .font(.system(size: 54, weight: .bold))
                    .minimumScaleFactor(0.1)
                    .scaledToFit()
            }
            .font(.system(size: 81, weight: .bold))
            .monospacedDigit()
            .padding(32)
            
            Spacer()
            
            Divider()
            
            let 列 = Array(repeating: GridItem(.flexible()), count: 3)
            LazyVGrid(columns: 列, spacing: 24) {
                ForEach(1..<13) { 🪧 in
                    if 🪧 == 10 {
                        Button {
                            🏥HealthStore.save(🄳ataTemp) { 🆗, 👿 in
                                if 🆗 {
                                    print(".save/.bodyTemp: Success")
                                } else {
                                    print("👿:", 👿.debugDescription)
                                }
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .symbolVariant(体温.count > 2 ? .fill : .none)
                        }
                        .tint(.pink)
                        .disabled(体温.count < 3)
                    } else if 🪧 == 11 {
                        Button {
                            if 体温.count < 4 {
                                体温.append(0)
                            }
                        } label: {
                            Text("0")
                                .opacity(体温.count >= 3 ? 0.4 : 1)
                        }
                        .tint(.primary)
                        .disabled(4 == 体温.count)
                    } else if 🪧 == 12 {
                        Button {
                            体温.removeLast()
                        } label: {
                            Text("⌫")
                                .scaleEffect(0.8)
                        }
                        .tint(.primary)
                        .disabled(体温.isEmpty)
                    } else {
                        Button {
                            if 体温.count < 4 {
                                体温.append(🪧)
                            }
                        } label: {
                            Text(🪧.description)
                                .fontWeight(体温.count == 1 && 体温.first==3 && (5<🪧 && 🪧<9) ? .heavy:nil)
                                .fontWeight(体温.count==0 && (🪧==3 || 🪧==4) ? .heavy:nil)
                                .opacity(体温.count >= 3 ? 0.4 : 1)
                        }
                        .tint(.primary)
                        .disabled(4 == 体温.count)
                    }
                }
                .font(.system(size: 48, design: .rounded))
            }
            .padding()
            .padding(.vertical, 12)
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
