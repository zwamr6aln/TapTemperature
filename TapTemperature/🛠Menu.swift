
import SwiftUI
import HealthKit


struct 🛠MenuButton: View {
    
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


struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        🛠MenuButton()
    }
}
