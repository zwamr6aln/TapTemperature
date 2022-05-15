
import SwiftUI


struct KeyboardView: View {
    
    let 🄺ey = [1,2,3,4,5,6,7,8,9,-1,0,-2]
    
    let 列 = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        LazyVGrid(columns: 列) {
            ForEach(🄺ey, id: \.self) { 🪧 in
                Button {
                    print(🪧.description)
                } label: {
                    Text(🪧.description)
                        .font(.largeTitle.bold())
                        .padding(4)
                }
            }
        }
    }
}




struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
