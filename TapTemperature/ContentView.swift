
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
                        📱.🛏Is.ⓣoggle()
                    } label: {
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Image(systemName: "bed.double")
                                .overlay {
                                    if 📱.🛏Is == .disable {
                                        Image(systemName: "xmark")
                                            .scaleEffect(1.2)
                                    }
                                }
                                .font(.title)
                            
                            if 📱.🛏Is == .bodyTempTogether {
                                Text("&")
                                    .font(.title3)
                            }
                        }
                        .tint(.primary)
                        .foregroundStyle(📱.🛏Is == .disable ? .quaternary : .primary)
                    }
                }
                
                Spacer()
                
                💟JumpButton()
            }
            .padding(.top)
            .padding(.horizontal, 20)
            
            
            Spacer()
            
            
            HStack(alignment: .firstTextBaseline) {
                if 📱.🧩Temp.indices.contains(0) {
                    Text(📱.🧩Temp[0].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                        }
                }
                
                if 📱.🧩Temp.indices.contains(1) {
                    Text(📱.🧩Temp[1].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                                .opacity(📱.🧩Temp.count < 1 ? 0 : 1)
                        }
                }
                
                Text(".")
                
                if 📱.🧩Temp.indices.contains(2) {
                    Text(📱.🧩Temp[2].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                                .opacity(📱.🧩Temp.count < 2 ? 0 : 1)
                        }
                }
                
                if 📱.🧩Temp.indices.contains(3) {
                    Text(📱.🧩Temp[3].description)
                } else {
                    if 📱.🚩2ndDecimalPlace {
                        Text("0").opacity(0)
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .frame(height: 4)
                                    .opacity(📱.🧩Temp.count < 3 ? 0 : 1)
                            }
                    } else {
                        EmptyView()
                    }
                }
                
                Text(📱.🛠Unit.rawValue)
                    .font(.system(size: 54, weight: .bold))
                    .minimumScaleFactor(0.1)
                    .scaledToFit()
            }
            .font(.system(size: 81, weight: .bold))
            .monospacedDigit()
            .padding(.horizontal, 32)
            .padding(.bottom)
            
            
            Spacer()
            
            Divider()
            
            
            let 列 = Array(repeating: GridItem(.flexible()), count: 3)
            LazyVGrid(columns: 列, spacing: 32) {
                ForEach(1..<13) { 🪧 in
                    if 🪧 == 10 {
                        Button {
                            📱.🚀Done()
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .symbolVariant(📱.🧩Temp.count > 2 ? .fill : .none)
                                .scaleEffect(📱.🧩Temp.count > 2 ? 1.15 : 1)
                        }
                        .tint(.pink)
                        .disabled(📱.🧩Temp.count < 3)
                    } else if 🪧 == 11 {
                        Button {
                            📱.ⓐppend(0)
                        } label: {
                            Text("0")
                                .fontWeight(📱.🧩Temp.count==1 && 📱.🧩Temp.first==3 ? .regular:nil)
                                .fontWeight(📱.🧩Temp.count >= 3 && (📱.🚩2ndDecimalPlace == false) ? .regular:nil)
                        }
                        .tint(.primary)
                        .disabled(📱.🧩Temp.isEmpty)
                        .disabled(📱.🧩Temp.count == 4)
                    } else if 🪧 == 12 {
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
                            📱.ⓐppend(🪧)
                        } label: {
                            Text(🪧.description)
                                .fontWeight(📱.🧩Temp.count == 1 && 📱.🧩Temp.first==3 && !(4<🪧 && 🪧<=9) ? .regular:nil)
                                .fontWeight(📱.🧩Temp.count >= 3 && (📱.🚩2ndDecimalPlace == false) ? .regular:nil)
                        }
                        .tint(.primary)
                        .disabled(📱.🧩Temp.isEmpty && !(🪧==3 || 🪧==4))
                        .disabled(📱.🧩Temp.count == 1 && 📱.🧩Temp.first==4 && 🪧 != 1)
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
