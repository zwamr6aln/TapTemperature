
import SwiftUI


struct KeyboardView: View {
    
    let 🄺ey = ["1","2","3","4","5","6","7","8","9","✓","0","⌫"]
    
    let 列 = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        LazyVGrid(columns: 列) {
            ForEach(1..<13) { a in
                if 6 <= a && a <= 8 {
                    Text(a.description)
                } else if a == 10 {
                    Image(systemName: "checkmark.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .pink)
                } else {
                    Text(🄺ey[a-1])
                        .opacity(0.3)
                }
            }
            .font(.largeTitle.weight(.black))
            .foregroundColor(.primary)
            .padding(8)
        }
        .padding()
    }
}




struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
