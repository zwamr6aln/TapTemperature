
import SwiftUI
import HealthKit


class 📱Model: ObservableObject {
    
    @AppStorage("Unit") var 💾Unit: 📏EnumUnit = .℃
    
    @AppStorage("BasalTemp") var 🚩BasalTemp: Bool = false
    
    @AppStorage("2ndDecimalPlace") var 🚩2DecimalPlace: Bool = false
    
    @AppStorage("AutoComplete") var 🚩AutoComplete: Bool = false
    
    
    @Published var 🧩Temp: [Int] = []
    
    
    @Published var 🛏BasalIs: Bool = true
    
    @Published var 🚩InputDone: Bool = false
    
    @Published var 🚩Success: Bool = false
    
    @Published var 🚩Canceled: Bool = false
    
    
    @AppStorage("history") var 🄷istoryTemp: String = ""
    
    @AppStorage("historyBasal") var 🄷istoryBasalTemp: String = ""
    
    
    func 🧩Reset() {
        switch 💾Unit {
            case .℃: 🧩Temp = [3]
            case .℉: 🧩Temp = []
        }
    }
    
    var 🌡Temp: Double {
        if 🧩Temp.count < 3 { return 0.0 }
        
        var 🌡 = Double(🧩Temp[0].description
                        + 🧩Temp[1].description
                        + "."
                        + 🧩Temp[2].description)!
        
        if 🧩Temp.indices.contains(3) {
            🌡 = Double(🌡.description + 🧩Temp[3].description)!
        }
        
        return 🌡
    }
    
    func 🧩Append(_ 🔢: Int) {
        🧩Temp.append(🔢)
        
        if 🚩AutoComplete {
            if 🧩Temp.count == (🚩2DecimalPlace ? 4 : 3) {
                🚀Done()
            }
        }
    }
    
    func 🚀Done() {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if 🚩BasalTemp && self.🛏BasalIs {
            🄷istoryBasalTemp += Date.now.formatted(date: .numeric, time: .shortened) + ", "
        } else {
            🄷istoryTemp += Date.now.formatted(date: .numeric, time: .shortened) + ", "
        }
        
        if 🚩BasalTemp && self.🛏BasalIs {
            if 🏥HealthStore.authorizationStatus(for: HKQuantityType(.basalBodyTemperature)) == .sharingDenied {
                🚩Success = false
                🚩InputDone = true
                self.🄷istoryBasalTemp += ".authorization 👿?!\n"
                return
            }
        } else {
            if 🏥HealthStore.authorizationStatus(for: HKQuantityType(.bodyTemperature)) == .sharingDenied {
                🚩Success = false
                🚩InputDone = true
                self.🄷istoryTemp += ".authorization 👿?!\n"
                return
            }
        }
        
        📃Object = 🅂ample
        
        if let 📃 = 📃Object {
            🏥HealthStore.save(📃) { 🙆, 🙅 in
                if 🙆 {
                    print(".save: Success")
                    
                    DispatchQueue.main.async {
                        if self.🚩BasalTemp && self.🛏BasalIs {
                            self.🄷istoryBasalTemp += self.🌡Temp.description + " " + self.💾Unit.rawValue + "\n"
                        } else {
                            self.🄷istoryTemp += self.🌡Temp.description + " " + self.💾Unit.rawValue + "\n"
                        }
                        
                        self.🚩Success = true
                        self.🚩InputDone = true
                    }
                } else {
                    print("🙅:", 🙅.debugDescription)
                    
                    DispatchQueue.main.async {
                        if self.🚩BasalTemp && self.🛏BasalIs {
                            self.🄷istoryBasalTemp += ".save 👿?!\n"
                        } else {
                            self.🄷istoryTemp += ".save 👿?!\n"
                        }
                        
                        self.🚩Success = false
                        self.🚩InputDone = true
                    }
                }
            }
        } else {
            if 🚩BasalTemp && 🛏BasalIs {
                🄷istoryBasalTemp += "sample→object 👿?!\n"
            } else {
                🄷istoryTemp += "sample→object 👿?!\n"
            }
            
            🚩Success = false
            🚩InputDone = true
        }
    }
    
    var 📃Object: HKQuantitySample?
    
    func 🗑Cancel() {
        if let 📃 = 📃Object {
            🏥HealthStore.delete(📃) { 🙆, 🙅 in
                if 🙆 {
                    print(".delete: Success")
                    DispatchQueue.main.async {
                        self.🚩Canceled = true
                    }
                } else {
                    print("🙅:", 🙅.debugDescription)
                }
            }
        }
    }
    
    
    let 🏥HealthStore = HKHealthStore()
    
    var 🅄nit: HKUnit {
        switch 💾Unit {
            case .℃: return .degreeCelsius()
            case .℉: return .degreeFahrenheit()
        }
    }
    
    var 🅀uantity: HKQuantity {
        HKQuantity(unit: 🅄nit, doubleValue: 🌡Temp)
    }
    
    var 🅃ype: HKQuantityType {
        if 🚩BasalTemp && 🛏BasalIs {
            return HKQuantityType(.basalBodyTemperature)
        } else {
            return HKQuantityType(.bodyTemperature)
        }
    }
    
    var 🅂ample: HKQuantitySample {
        HKQuantitySample(type: 🅃ype,
                         quantity: 🅀uantity,
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
