
import SwiftUI
import HealthKit


struct 🛠MenuButton: View { // ⚙️
    
    @State private var 🚩Menu: Bool = false
    
    var body: some View {
        Button {
            🚩Menu = true
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Image(systemName: "gearshape")
                .font(.title)
                .padding(.vertical)
        }
        .tint(.primary)
        .popover(isPresented: $🚩Menu) {
            🛠Menu()
        }
    }
}


struct 🛠Menu: View {
    @EnvironmentObject var 📱:📱Model
    
    @Environment(\.dismiss) var 🔚: DismissAction
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker(selection: $📱.💾Unit) {
                        ForEach(📏EnumUnit.allCases, id: \.self) { 🏷 in
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
                    .onChange(of: 📱.🚩BasalTemp) { _ in
                        📱.🏥RequestAuthorization(HKQuantityType(.basalBodyTemperature))
                    }
                    
                    Toggle(isOn: $📱.🚩2) {
                        let 🪧: String = {
                            switch 📱.💾Unit {
                                case .℃: return "36.1 ℃  →  36.12︭ ℃"
                                case .℉: return "100.1 ℉  →  100.12︭ ℉"
                            }
                        }()
                        
                        Label(🪧, systemImage: "character.cursor.ibeam")
                    }
                    
                    Toggle(isOn: $📱.🚩AutoComplete) {
                        Label("Auto complete", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
                    }
                } header: {
                    Text("Option")
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
                    NavigationLink {
                        🕛HistoryView($📱.🄷istoryTemp)
                    } label: {
                        Label("Body temperature", systemImage: "figure.stand")
                            .foregroundStyle(.primary)
                    }
                    
                    NavigationLink {
                        🕛HistoryView($📱.🄷istoryBasalTemp)
                    } label: {
                        Label("Basal body temperature", systemImage: "bed.double")
                            .foregroundStyle(.primary)
                    }
                } header: {
                    Label("Local history", systemImage: "clock")
                } footer: {
                    Text("🌏\"Local history\" is for the porpose of \"operation check\" / \"temporary backup\"")
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


struct 🕛HistoryView: View {
    @Binding var 🅃ext: String
    
    var body: some View {
        if 🅃ext == "" {
            Image(systemName: "text.append")
                .foregroundStyle(.tertiary)
                .font(.system(size: 64))
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    📄PageView(🅃ext, "History")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    🅃ext = ""
                                } label: {
                                    Image(systemName: "trash")
                                        .tint(.red)
                                }
                            }
                        }
                }
            }
        }
    }
    
    init(_ 🅃ext: Binding<String>) {
        self._🅃ext = 🅃ext
    }
}


struct 📄PageView: View {
    var 📄: String
    
    var 🏷: String
    
    var body: some View {
        Text(📄)
            .navigationBarTitle(🏷)
            .navigationBarTitleDisplayMode(.inline)
            .font(.caption.monospaced())
            .padding()
            .textSelection(.enabled)
    }
    
    init(_ 📄: String, _ 🏷: String) {
        self.📄 = 📄
        self.🏷 = 🏷
    }
}
