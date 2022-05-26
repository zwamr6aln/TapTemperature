
import SwiftUI


struct 🪧Label: View {
    @EnvironmentObject var 📱:📱Model
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if 📱.🧩Temp.indices.contains(0) {
                Text(📱.🧩Temp[0].description)
            }  else {
                Text("0").opacity(0)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(height: 4)
                    }
            }
            
            if 📱.🧩Temp.indices.contains(1) {
                Text(📱.🧩Temp[1].description)
            }  else {
                Text("0").opacity(0)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(height: 4)
                            .opacity(📱.🧩Temp.count < 1 ? 0 : 1)
                    }
            }
            
            Text(".")
            
            if 📱.🧩Temp.indices.contains(2) {
                Text(📱.🧩Temp[2].description)
            }  else {
                Text("0").opacity(0)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(height: 4)
                            .opacity(📱.🧩Temp.count < 2 ? 0 : 1)
                    }
            }
            
            if 📱.🧩Temp.indices.contains(3) {
                Text(📱.🧩Temp[3].description)
            } else {
                if 📱.🚩2ndDecimalPlace {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                                .opacity(📱.🧩Temp.count < 3 ? 0 : 1)
                        }
                } else {
                    EmptyView()
                }
            }
            
            Text(📱.🛠Unit.rawValue)
                .font(.system(size: 54, weight: .bold))
                .minimumScaleFactor(0.1)
                .scaledToFit()
        }
        .font(.system(size: 81, weight: .bold))
        .monospacedDigit()
    }
}




struct Label_Previews: PreviewProvider {
    static var previews: some View {
        🪧Label()
    }
}
