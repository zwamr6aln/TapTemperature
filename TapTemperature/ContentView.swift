
import SwiftUI
import HealthKit


struct ContentView: View {
    @EnvironmentObject var 📱:📱Model
    
    @Environment(\.scenePhase) private var 🔛: ScenePhase
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                🛠MenuButton()
                
                if 📱.🚩BasalTemp {
                    Button {
                        📱.🛏Is.toggle()
                    } label: {
                        Image(systemName: "bed.double")
                            .foregroundStyle(📱.🛏Is ? .primary : .quaternary)
                            .overlay {
                                if 📱.🛏Is == false {
                                    Image(systemName: "xmark")
                                        .scaleEffect(1.2)
                                }
                            }
                            .font(.title)
                            .tint(.primary)
                    }
                }
                
                Spacer()
                
                💟JumpButton()
            }
            .padding(.top)
            .padding(.horizontal, 20)
            
            
            Spacer()
            
            
            🪧Label()
                .padding(.horizontal, 32)
                .padding(.bottom)
            
            
            Spacer()
            
            Divider()
            
            
            let ꠲ = Array(repeating: GridItem(.flexible()), count: 3)
            LazyVGrid(columns: ꠲, spacing: 32) {
                ForEach(1..<13) { 🔢 in
                    if 🔢 == 10 {
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
                    } else if 🔢 == 11 {
                        Button {
                            📱.ⓐppend(0)
                        } label: {
                            Text("0")
                                .fontWeight(📱.🧩Temp.count==1 && 📱.🧩Temp.first==3 ? .regular:nil)
                                .fontWeight(📱.🧩Temp.count >= 3 && !(📱.🚩2ndDecimalPlace) ? .regular:nil)
                        }
                        .tint(.primary)
                        .disabled(📱.🧩Temp.isEmpty)
                        .disabled(📱.🧩Temp.count == 4)
                    } else if 🔢 == 12 {
                        Button {
                            📱.🧩Temp.removeLast()
                        } label: {
                            Text("⌫")
                                .fontWeight(📱.🧩Temp.count <= 1 ? .regular:nil)
                                .scaleEffect(0.8)
                        }
                        .tint(.primary)
                        .disabled(📱.🧩Temp.isEmpty)
                    } else {
                        Button {
                            📱.ⓐppend(🔢)
                        } label: {
                            Text(🔢.description)
                                .fontWeight(📱.🧩Temp.count == 1 && 📱.🧩Temp.first==3 && !(4<🔢 && 🔢<=9) ? .regular:nil)
                                .fontWeight(📱.🧩Temp.count >= 3 && !(📱.🚩2ndDecimalPlace) ? .regular:nil)
                        }
                        .tint(.primary)
                        .disabled(📱.🧩Temp.isEmpty && !(🔢==3 || 🔢==4))
                        .disabled(📱.🧩Temp.count == 1 && 📱.🧩Temp.first==4 && 🔢 != 1)
                        .disabled(📱.🧩Temp.count == 4)
                    }
                }
                .font(.system(size: 48, weight: .heavy, design: .rounded))
            }
            .padding()
            .padding(.vertical, 12)
        }
        .fullScreenCover(isPresented: $📱.🚩InputDone) {
            🆗Result()
                .onChange(of: 🔛) { 🄽ow in
                    if 🄽ow == .background {
                        📱.🚩InputDone = false
                        📱.🧩Temp = [3]
                    }
                }
        }
        .onAppear {
            let 🅃ype: Set<HKSampleType> = [HKQuantityType(.bodyTemperature)]
            📱.🏥HealthStore.requestAuthorization(toShare: 🅃ype, read: nil) { 🆗, 👿 in
                if 🆗 {
                    print("requestAuthorization/bodyTemp: Success")
                } else {
                    print("👿:", 👿.debugDescription)
                }
            }
        }
    }
}


struct 💟JumpButton: View {
    var body: some View {
        Link(destination: URL(string: "x-apple-health://")!) {
            Image(systemName: "app")
                .imageScale(.large)
                .overlay {
                    Image(systemName: "heart")
                        .imageScale(.small)
                }
        }
        .font(.title)
        .foregroundStyle(.primary)
        .accessibilityLabel("🌏Open \"Health\" app")
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
