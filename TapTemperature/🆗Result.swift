
import SwiftUI


struct 🆗Result: View {
    
    @Binding var 🚩Success: Bool
    
    @AppStorage("Unit") var 🛠Unit: 🄴numUnit = .℃
    
    @AppStorage("Temp") var 💾Temp = 36.0
    
    @AppStorage("AutoComplete") var 🚩AutoComplete: Bool = false
    
    @Environment(\.dismiss) var 🔙: DismissAction
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(🚩Success ? .pink : .gray)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    if 🚩Success == false {
                        Image(systemName: "arrow.right")
                            .imageScale(.small)
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    }
                    
                    💟JumpButton()
                        .opacity(0.66)
                }
                .overlay {
                    if 🚩Success && 🚩AutoComplete {
                        Text(💾Temp.description + " " + 🛠Unit.rawValue)
                            .font(.title.weight(.medium))
                            .monospacedDigit()
                            .opacity(0.66)
                    }
                }
                .padding(.top)
                .padding(.horizontal, 20)
                
                Button {
                    🔙.callAsFunction()
                } label: {
                    VStack(spacing: 12) {
                        Image(systemName: 🚩Success ? "app.badge.checkmark" : "exclamationmark.triangle")
                            .font(.system(size: 110).weight(.semibold))
                            .minimumScaleFactor(0.1)
                        
                        Text(🚩Success ? "OK!" : "🌏Error!?")
                            .font(.system(size: 128).weight(.black))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        
                        if 🚩Success == false {
                            Text("🌏Please check permission on \"Health\" app")
                                .font(.body.weight(.semibold))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                            .frame(height: 50)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .accessibilityLabel("🌏Dismiss")
            }
        }
        .preferredColorScheme(.dark)
    }
    
    init(_ 🚩Success: Binding<Bool>) {
        self._🚩Success = 🚩Success
    }
}




struct 🆗Result_Previews: PreviewProvider {
    static var previews: some View {
        🆗Result(.constant(true))
            .previewLayout(.fixed(width: 200, height: 400))
        
        🆗Result(.constant(false))
            .previewLayout(.fixed(width: 200, height: 400))
    }
}
