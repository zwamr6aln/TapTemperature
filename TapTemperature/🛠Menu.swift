
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
    @EnvironmentObject var 📱:📱Model
    
    @Environment(\.dismiss) var 🔚: DismissAction
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker(selection: $📱.💾Unit) {
                        ForEach(🄴numUnit.allCases, id: \.self) { 🏷 in
                            Text(🏷.rawValue)
                        }
                    } label: {
                        Label("℃  /  ℉", systemImage: "ruler")
                    }
                    .onChange(of: 📱.💾Unit) { _ in
                        📱.🧩Reset()
                    }
                    
                    Toggle(isOn: $📱.🚩BasalTemp) {
                        Label("Basal body temperature", systemImage: "bed.double")
                    }
                } header: {
                    Text("Option")
                }
                
                
                Section {
                    Toggle(isOn: $📱.🚩AutoComplete) {
                        Label("Auto complete", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
                    }
                    
                    Toggle(isOn: $📱.🚩2ndDecimalPlace) {
                        Label("36.1\(📱.💾Unit.rawValue)  →  36.12︭\(📱.💾Unit.rawValue)",
                              systemImage: "character.cursor.ibeam")
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
