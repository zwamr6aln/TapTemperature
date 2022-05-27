
import SwiftUI
import HealthKit


class 📱Model: ObservableObject {
    
    @AppStorage("Unit") var 💾Unit: 🄴numUnit = .℃
    
    @AppStorage("BasalTemp") var 🚩BasalTemp: Bool = false
    
    @AppStorage("2ndDecimalPlace") var 🚩2ndDecimalPlace: Bool = false
    
    @AppStorage("AutoComplete") var 🚩AutoComplete: Bool = false
    
    
    @Published var 🧩Temp: [Int] = []
    
    func 🧩Reset() {
        switch 💾Unit {
            case .℃: 🧩Temp = [3]
            case .℉: 🧩Temp = []
        }
    }
    
    var 🌡Temp: Double {
        var 🌡 = Double(🧩Temp[0].description
                        + 🧩Temp[1].description
                        + "."
                        + 🧩Temp[2].description)!
        
        if 🧩Temp.indices.contains(3) {
            🌡 = Double(🌡.description + 🧩Temp[3].description)!
        }
        
        return 🌡
    }
    
    func ⓐppend(_ 🔢: Int) {
        🧩Temp.append(🔢)
        
        if 🚩AutoComplete {
            if 🧩Temp.count == (🚩2ndDecimalPlace ? 4 : 3) {
                🚀Done()
            }
        }
    }
    
    func 🚀Done() {
        🏥HealthStore.save(🅂ampleTemp) { 🙆, 🙅 in
            if 🙆 {
                print(".save: Success")
                DispatchQueue.main.async {
                    self.🚩Success = true
                }
            } else {
                print("🙅:", 🙅.debugDescription)
                DispatchQueue.main.async {
                    self.🚩Success = false
                }
            }
        }
        🚩InputDone = true
    }
    
    
    @Published var 🛏Is: Bool = true
    
    @Published var 🚩InputDone: Bool = false
    
    @Published var 🚩Success: Bool = false
    
    
    let 🏥HealthStore = HKHealthStore()
    
    var 🅄nit: HKUnit {
        switch 💾Unit {
            case .℃: return .degreeCelsius()
            case .℉: return .degreeFahrenheit()
        }
    }
    
    var 🅀uantityTemp: HKQuantity {
        HKQuantity(unit: 🅄nit, doubleValue: 🌡Temp)
    }
    
    var 🅃ype: HKQuantityType {
        if 🚩BasalTemp {
            return HKQuantityType(.basalBodyTemperature)
        } else {
            return HKQuantityType(.bodyTemperature)
        }
    }
    
    var 🅂ampleTemp: HKQuantitySample {
        HKQuantitySample(type: 🅃ype,
                         quantity: 🅀uantityTemp,
                         start: .now,
                         end: .now)
    }
    
    func 🏥RequestAuthorization(_ ⓣype: HKQuantityType) {
        🏥HealthStore.requestAuthorization(toShare: [ⓣype], read: nil) { 🆗, 👿 in
            if 🆗 {
                print(".requestAuthorization: Success")
            } else {
                print("👿:", 👿.debugDescription)
            }
        }
    }
}
