
import SwiftUI


struct Result: View {
    
    @Binding var 🚩Success: Bool
    
    @Environment(\.dismiss) var 🔙: DismissAction
    
    var body: some View {
        ZStack {
            🚩Success ? Color.pink : Color.gray
            
            Button {
                🔙.callAsFunction()
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
    
    init(_ 🚩Success: Binding<Bool>) {
        self._🚩Success = 🚩Success
    }
}




struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result(.constant(true))
    }
}
