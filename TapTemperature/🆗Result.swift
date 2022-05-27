
import SwiftUI


struct 🆗Result: View {
    @EnvironmentObject var 📱:📱Model
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(📱.🚩Success ? .pink : .gray)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    if 📱.🚩Success {
                        Button {
                            📱.🗑Cancel()
                        } label: {
                            Image(systemName: "arrow.uturn.backward.circle")
                                .font(.title)
                                .imageScale(.large)
                                .foregroundColor(.primary)
                        }
                        
                        if 📱.🚩Canceled {
                            Text("Cenceled")
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                    
                    if 📱.🚩Success == false {
                        Image(systemName: "arrow.right")
                            .imageScale(.small)
                            .font(.largeTitle)
                    }
                    
                    💟JumpButton()
                }
                .opacity(0.75)
                .padding(.top)
                .padding(.horizontal, 20)
                
                Button {
                    📱.🚩InputDone = false
                } label: {
                    VStack(spacing: 12) {
                        Spacer()
                        
                        Image(systemName: 📱.🚩Success ? "checkmark" : "exclamationmark.triangle")
                            .font(.system(size: 110).weight(.semibold))
                            .minimumScaleFactor(0.1)
                        
                        Text(📱.🚩Success ? "DONE!" : "🌏Error!?")
                            .font(.system(size: 128).weight(.black))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .padding(.horizontal)
                        
                        if 📱.🚩Success {
                            Text("Registration for \"Health\" app")
                                .bold()
                                .opacity(0.8)
                        } else {
                            Text("🌏Please check permission on \"Health\" app")
                                .font(.body.weight(.semibold))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        HStack {
                            if 📱.🚩BasalTemp && 📱.🛏BasalIs {
                                Image(systemName: "bed.double")
                                    .font(.body.bold())
                            }
                            
                            if 📱.🚩Success {
                                Text(📱.🌡Temp.description + " " + 📱.💾Unit.rawValue)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(48)
                        .opacity(0.8)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .accessibilityLabel("🌏Dismiss")
                .opacity(📱.🚩Canceled ? 0.25 : 1)
            }
        }
        .preferredColorScheme(.dark)
        .onChange(of: 📱.🚩InputDone) { 🚩 in
            if 🚩 == false {
                📱.🚩Canceled = false
            }
        }
        .animation(.default, value: 📱.🚩Canceled)
    }
}




struct 🆗Result_Previews: PreviewProvider {
    static var previews: some View {
        🆗Result()
            .previewLayout(.fixed(width: 200, height: 400))
    }
}
