
import SwiftUI


struct 👆Keypad: View {
    @EnvironmentObject var 📱:📱Model
    
    var body: some View {
        let ꠲ = Array(repeating: GridItem(.flexible()), count: 3)
        LazyVGrid(columns: ꠲, spacing: 32) {
            ForEach(1..<13) { 🔢 in
                
                let 🄵ixWeight: Bool = {
                    switch 📱.🛠Unit {
                        case .℃:
                            if 📱.🧩Temp.count == 1 {
                                if 📱.🧩Temp.first == 3 {
                                    if 🔢 < 5 || 🔢 == 11 {
                                        return true
                                    }
                                }
                            }
                            
                            if 📱.🧩Temp.count >= 3 {
                                if 📱.🚩2ndDecimalPlace == false {
                                    return true
                                }
                            }
                            
                            return false
                        case .℉:
                            return false
                    }
                }()
                
                let 🄳isable: Bool = {
                    switch 📱.🛠Unit {
                        case .℃:
                            if 📱.🧩Temp.isEmpty {
                                if 🔢 != 3 && 🔢 != 4 {
                                    return true
                                }
                            }
                            
                            if 📱.🧩Temp.count == 1 {
                                if 📱.🧩Temp.first == 4 {
                                    if 🔢 != 1 && 🔢 != 11 {
                                        return true
                                    }
                                }
                            }
                            
                            if 📱.🧩Temp.count == 4 {
                                return true
                            }
                            return false
                        case .℉:
                            return false
                    }
                }()
                
                
                switch 🔢 {
                    case 1..<10:
                        Button {
                            📱.ⓐppend(🔢)
                        } label: {
                            Text(🔢.description)
                                .fontWeight(🄵ixWeight ? .regular : nil)
                        }
                        .tint(.primary)
                        .disabled(🄳isable)
                    case 10:
                        Button {
                            📱.🚀Done()
                        } label: {
                            let 🔘: String = {
                                if 📱.🚩AutoComplete == false {
                                    return "checkmark.circle"
                                }
                                
                                if 📱.🚩2ndDecimalPlace {
                                    switch 📱.🧩Temp.count {
                                        case 0: return "4.circle"
                                        case 1: return "3.circle"
                                        case 2: return "2.circle"
                                        case 3: return "1.circle"
                                        default: return "checkmark.circle"
                                    }
                                } else {
                                    switch 📱.🧩Temp.count {
                                        case 0: return "3.circle"
                                        case 1: return "2.circle"
                                        case 2: return "1.circle"
                                        default: return "checkmark.circle"
                                    }
                                }
                            }()
                            
                            Image(systemName: 🔘)
                                .symbolVariant(📱.🧩Temp.count > 2 ? .fill : .none)
                                .scaleEffect(📱.🧩Temp.count > 2 ? 1.15 : 1)
                                .font(.system(size: 48, weight: .regular))
                        }
                        .tint(.pink)
                        .disabled(📱.🧩Temp.count < 3)
                    case 11:
                        Button {
                            📱.ⓐppend(0)
                        } label: {
                            Text("0")
                                .fontWeight(🄵ixWeight ? .regular : nil)
                        }
                        .tint(.primary)
                        .disabled(🄳isable)
                    case 12:
                        Button {
                            📱.🧩Temp.removeLast()
                        } label: {
                            Text("⌫")
                                .fontWeight(.regular)
                                .scaleEffect(0.8)
                        }
                        .tint(.primary)
                        .disabled(📱.🧩Temp.isEmpty)
                    default:
                        Text("🐛")
                }
            }
            .font(.system(size: 48, weight: .heavy, design: .rounded))
        }
        .padding()
        .padding(.vertical, 12)
    }
}




struct 👆Keypad_Previews: PreviewProvider {
    static var previews: some View {
        👆Keypad()
    }
}
