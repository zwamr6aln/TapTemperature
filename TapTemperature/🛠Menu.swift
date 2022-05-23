
import SwiftUI
import HealthKit


struct 🛠MenuButton: View {
    
    @State private var 🚩Menu: Bool = false
    
    var body: some View {
        Button {
            🚩Menu = true
        } label: {
            Image(systemName: "gearshape")
                .font(.title)
        }
        .tint(.primary)
        .popover(isPresented: $🚩Menu) {
            🛠Menu()
        }
    }
}


struct 🛠Menu: View {
    
    @AppStorage("Unit") var 🛠Unit: 🄴numUnit = .℃
    
    @AppStorage("小数点2桁") var 🚩小数点2桁: Bool = false
    
    @AppStorage("自動完了") var 🚩自動完了: Bool = false
    
    @Environment(\.dismiss) var 🔚: DismissAction
    
    var body: some View {
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
                    
                    Toggle(isOn: .constant(false)) {
                        Label("基礎体温", systemImage: "bed.double")
                    }
                } header: {
                    Text("Option")
                }
                
                
                Section {
                    Toggle(isOn: $🚩自動完了) {
                        Label("自動完了", systemImage: "circle.slash.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                    
                    Toggle(isOn: $🚩小数点2桁) {
                        Label("36.1\(🛠Unit.rawValue) → 36.12︭\(🛠Unit.rawValue)",
                              systemImage: "character.cursor.ibeam")
                    }
                } footer: {
                    Text("小数点2桁まで入力する")
                }
                
                
                Section {
                    Label("App Document", systemImage: "doc")
                }
            }
            .navigationTitle("TapTemperature")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        🔚.callAsFunction()
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




struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        🛠Menu()
    }
}
