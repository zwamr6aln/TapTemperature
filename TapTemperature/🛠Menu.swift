
import SwiftUI
import HealthKit


struct 🛠MenuButton: View { // ⚙️
    
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


enum 🄴numUnit: String, CaseIterable {
    case ℃
    case ℉
}


struct 🛠Menu: View {
    
    @AppStorage("Unit") var 🛠Unit: 🄴numUnit = .℃
    
    @AppStorage("🛏") var 🚩BasalTemp: Bool = false
    
    @AppStorage("小数点2桁") var 🚩小数点2桁: Bool = false
    
    @AppStorage("AutoComplete") var 🚩AutoComplete: Bool = false
    
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
                    
                    Toggle(isOn: $🚩BasalTemp) {
                        Label("Basal temperature", systemImage: "bed.double")
                    }
                } header: {
                    Text("Option")
                }
                
                
                Section {
                    Toggle(isOn: $🚩AutoComplete) {
                        Label("Auto complete", systemImage: "circle.slash.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                    
                    Toggle(isOn: $🚩小数点2桁) {
                        Label("36.1\(🛠Unit.rawValue)  →  36.12︭\(🛠Unit.rawValue)",
                              systemImage: "character.cursor.ibeam")
                    }
                    .onChange(of: 🚩小数点2桁) { 🚩 in
                        if 🚩 == true {
                            🔚.callAsFunction()
                        }
                    }
                }
                
                
                Link (destination: URL(string: "x-apple-health://")!) {
                    HStack {
                        Label("🌏Open \"Health\" app", systemImage: "heart")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.forward.app")
                    }
                    .font(.body.weight(.medium))
                }
                
                
                Section {
                    Label("App Document", systemImage: "doc")
                        .foregroundStyle(.secondary)
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
