
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
    
    @AppStorage("小数点2桁") var 🚩小数点2桁: Bool = false
    
    @State private var 体温: [Int] = [3]
    
    
    @State private var 🚩InputDone: Bool = false
    
    @State private var 🚩Success: Bool = false
    
    
    var body: some View {
        VStack {
            HStack {
                Link(destination: URL(string: "x-apple-health://")!) {
                    Image(systemName: "app")
                        .imageScale(.large)
                        .overlay {
                            Image(systemName: "heart")
                                .imageScale(.small)
                        }
                }
                .font(.title)
                .tint(.primary)
                
                SettingButton()
                
                Button {
                    print("placeholder")
                } label: {
                    Image(systemName: "text.justify.left")
                }
                .font(.title)
                .tint(.primary)
                .popover(isPresented: .constant(false)) {
                    Text("placeholder")
                }
                
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal, 20)
            
            
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
                    if 🚩小数点2桁 {
                        Text("0").opacity(0)
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .frame(height: 4)
                                    .opacity(体温.count < 3 ? 0 : 1)
                            }
                    } else {
                        EmptyView()
                    }
                }
                
                Text(🛠Unit.rawValue)
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
                            🏥HealthStore.save(🄳ataTemp) { 🆗, 👿 in
                                if 🆗 {
                                    print(".save/.bodyTemp: Success")
                                    self.🚩Success = true
                                } else {
                                    print("👿:", 👿.debugDescription)
                                }
                            }
                            🚩InputDone = true
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .symbolVariant(体温.count > 2 ? .fill : .none)
                                .scaleEffect(体温.count > 2 ? 1.15 : 1)
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
                                .fontWeight(体温.count==1 && 体温.first==3 ? .regular:nil)
                                .fontWeight(体温.count >= 3 && !🚩小数点2桁 ? .regular:nil)
                        }
                        .tint(.primary)
                        .disabled(体温.count == 0)
                        .disabled(体温.count == 4)
                    } else if 🪧 == 12 {
                        Button {
                            体温.removeLast()
                        } label: {
                            Text("⌫")
                                .fontWeight(体温.count <= 1 ? .regular:nil)
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
                                .fontWeight(体温.count == 1 && 体温.first==3 && !(4<🪧 && 🪧<=9) ? .regular:nil)
                                .fontWeight(体温.count >= 3 && !🚩小数点2桁 ? .regular:nil)
                        }
                        .tint(.primary)
                        .disabled(体温.count==0 && !(🪧==3 || 🪧==4))
                        .disabled(体温.count == 1 && 体温.first==4 && 🪧 != 1)
                        .disabled(体温.count == 4)
                    }
                }
                .font(.system(size: 48, weight: .heavy, design: .rounded))
            }
            .padding()
            .padding(.vertical, 12)
        }
        .fullScreenCover(isPresented: $🚩InputDone) {
            ZStack {
                🚩Success ? Color.pink : Color.gray
                
                Button {
                    🚩InputDone = false
                } label: {
                    VStack(spacing: 16) {
                        Spacer()
                        
                        Image(systemName: 🚩Success ? "heart" : "heart.slash")
                        
                        Text(🚩Success ? "OK!" : "Error!?")
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        
                        Spacer()
                    }
                    .font(.system(size: 128).weight(.black))
                    .foregroundColor(.white)
                }
                .accessibilityLabel("🌏Dismiss")
            }
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
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


struct SettingButton: View {
    
    @State private var 🚩Menu: Bool = false
    
    @AppStorage("Unit") var 🛠Unit: 🄴numUnit = .℃
    
    @AppStorage("小数点2桁") var 🚩小数点2桁: Bool = false
    
    @AppStorage("自動完了") var 🚩自動完了: Bool = false
    
    @AppStorage("ヘルスケアアプリ自動起動") var 🚩ヘルスケアアプリ自動起動: Bool = false
    
    var body: some View {
        Button {
            🚩Menu = true
        } label: {
            Image(systemName: "gearshape")
                .font(.title)
        }
        .tint(.primary)
        .popover(isPresented: $🚩Menu) {
            NavigationView {
                List {
                    Section {
                        Picker(selection: $🛠Unit) {
                            ForEach(🄴numUnit.allCases, id: \.self) { 🏷 in
                                Text(🏷.rawValue)
                            }
                        } label: {
                            Label("℃  /  ℉", systemImage: "ruler")
                        }
                    }
                    
                    
                    Section {
                        Toggle(isOn: $🚩小数点2桁) {
                            HStack {
                                Image(systemName: "character.cursor.ibeam")
                                    .foregroundColor(.accentColor)
                                
                                Text("36.1\(🛠Unit.rawValue)")
                                    .padding(.leading, 8)
                                
                                Image(systemName: "arrow.right")
                                    .imageScale(.small)
                                
                                Text("36.12︭\(🛠Unit.rawValue)")
                                    .fontWeight(.semibold)
                            }
                        }
                    } footer: {
                        Text("小数点2桁まで入力する")
                    }
                    
                    
                    Section{
                        Toggle("最後まで数字を入力したら自動で完了する", isOn: $🚩自動完了)
                        
                        Toggle("ヘルスケアアプリ自動起動", isOn: $🚩ヘルスケアアプリ自動起動)
                        
                        Toggle("基礎体温として記録する", isOn: .constant(false))
                    }
                    
                    
                    Section {
                        Label("App Document", systemImage: "doc")
                    }
                }
                .navigationTitle("TapTemperature")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            🚩Menu = false
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.secondary)
                                .grayscale(1.0)
                                .padding(8)
                        }
                        .accessibilityLabel("🌏Dismiss")
                    }
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
