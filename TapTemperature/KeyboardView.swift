
import SwiftUI


struct KeyboardView: View {
    
    let 🄺ey = ["1","2","3","4","5","6","7","8","9","✓","0","⌫"]
    
    let 列 = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        LazyVGrid(columns: 列, spacing: 24) {
            ForEach(1..<13) { 🪧 in
                if 6 <= 🪧 && 🪧 <= 8 {
                    Text(🪧.description)
                } else if 🪧 == 10 {
                    Image(systemName: "checkmark.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .pink)
                } else {
                    Text(🄺ey[🪧-1])
                        .opacity(0.2)
                }
            }
            .foregroundColor(.primary)
            .font(.system(size: 48,
                          weight: .medium,
                          design: .rounded))
        }
        .padding()
    }
}




struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
