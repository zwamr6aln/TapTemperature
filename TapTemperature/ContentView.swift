
import SwiftUI
import HealthKit


struct ContentView: View {
    @EnvironmentObject var 📱:📱Model
    
    @Environment(\.scenePhase) private var 🔛: ScenePhase
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                🛠MenuButton()
                
                if 📱.🚩BasalTemp {
                    Button {
                        📱.🛏BasalIs.toggle()
                    } label: {
                        Image(systemName: "bed.double")
                            .foregroundStyle(📱.🛏BasalIs ? .primary : .quaternary)
                            .overlay {
                                if 📱.🛏BasalIs == false {
                                    Image(systemName: "xmark")
                                        .scaleEffect(1.2)
                                }
                            }
                            .font(.title)
                            .tint(.primary)
                    }
                }
                
                Spacer()
                
                💟JumpButton()
            }
            .padding(.top)
            .padding(.horizontal, 20)
            
            Spacer()
            
            🪧Label()
                .padding(.horizontal)
                .padding(.trailing)
                .padding(.bottom)
            
            Spacer()
            
            Divider()
            
            👆Keypad()
        }
        .fullScreenCover(isPresented: $📱.🚩InputDone) {
            🆗Result()
        }
        .onAppear {
            📱.🏥RequestAuthorization(HKQuantityType(.bodyTemperature))
            
            📱.🧩Reset()
        }
    }
}


struct 💟JumpButton: View {
    var body: some View {
        Link(destination: URL(string: "x-apple-health://")!) {
            Image(systemName: "app")
                .imageScale(.large)
                .overlay {
                    Image(systemName: "heart")
                        .imageScale(.small)
                }
        }
        .font(.title)
        .foregroundStyle(.primary)
        .accessibilityLabel("🌏Open \"Health\" app")
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
