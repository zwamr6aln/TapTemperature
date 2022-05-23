
import SwiftUI


struct Result: View {
    
    @Binding var 🚩InputDone: Bool
    
    @Binding var 🚩Success: Bool
    
    var body: some View {
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
}




struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result(🚩InputDone: .constant(false), 🚩Success: .constant(true))
    }
}
