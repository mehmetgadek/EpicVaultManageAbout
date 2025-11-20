
import SwiftUI

@available(iOS 14.0, *)
struct GamingDashboardView: View {
    
    @EnvironmentObject var dataManager: GameDataManager
    @State private var animateBackground = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.0, blue: 0.2), Color(red: 0.3, green: 0.0, blue: 0.4), Color.black]),
                           startPoint: animateBackground ? .topLeading : .bottomTrailing,
                           endPoint: animateBackground ? .bottomTrailing : .topLeading)
            .ignoresSafeArea()
            .blur(radius: 80)
            .onAppear {
                withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: true)) {
                    animateBackground.toggle()
                }
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    
                    Text("» EpicVault «")
                        .font(.system(size: 30, weight: .heavy, design: .monospaced))
                        .foregroundColor(.white)
                        .shadow(color: Color.pink, radius: 10)
                        .padding(.top, 10)
                    
                    Text("» GAMING UNIVERSE «")
                        .font(.system(size: 20, weight: .heavy, design: .monospaced))
                        .foregroundColor(.white)
                        .shadow(color: Color.pink, radius: 10)
                    
                    GameDashboardCardView(
                        title: "Grand Theft Auto V",
                        subtitle: "Heists • Freedom • Chaos",
                        imageName: "car.fill",
                        color: Color.orange,
                        gradient: [Color(red: 0.9, green: 0.4, blue: 0.1), Color(red: 0.7, green: 0.2, blue: 0.05)],
                        count: dataManager.gtaGames.count
                    ) {
                        GrandTheftAutoVListView()
                            .environmentObject(dataManager)
                    }
                    
                    GameDashboardCardView(
                        title: "Assassin’s Creed: Valhalla",
                        subtitle: "Honor • Raids • Exploration",
                        imageName: "figure.walk",
                        color: Color(.systemTeal),
                        gradient: [Color(red: 0.1, green: 0.6, blue: 0.5), Color(red: 0.05, green: 0.4, blue: 0.3)],
                        count: dataManager.valhallaGames.count
                    ) {
                        AssassinsCreedValhallaListView()
                            .environmentObject(dataManager)
                    }
                    
                    GameDashboardCardView(
                        title: "Red Dead Redemption 2",
                        subtitle: "Wild West • Freedom • Legacy",
                        imageName: "hare.fill",
                        color: Color.red,
                        gradient: [Color(red: 0.5, green: 0.1, blue: 0.05), Color(red: 0.3, green: 0.05, blue: 0.02)],
                        count: dataManager.rdr2Games.count
                    ) {
                        RDR2ListView()
                            .environmentObject(dataManager)
                    }
                    
                    GameDashboardCardView(
                        title: "Zelda: Breath of the Wild",
                        subtitle: "Adventure • Courage • Wonder",
                        imageName: "leaf.fill",
                        color: Color(red: 0.0, green: 0.8, blue: 0.8),
                        gradient: [
                            Color(red: 0.1, green: 0.8, blue: 0.8),
                            Color(red: 0.0, green: 0.5, blue: 0.5)
                        ],
                        count: dataManager.zeldaGames.count
                    ) {
                        ZeldaBreathOfTheWildListView()
                            .environmentObject(dataManager)
                    }
                    
                    
                    GameDashboardCardView(
                        title: "God of War: Ragnarök",
                        subtitle: "Myth • Rage • Redemption",
                        imageName: "flame.fill",
                        color: Color.purple,
                        gradient: [Color(red: 0.6, green: 0.1, blue: 0.7), Color(red: 0.4, green: 0.05, blue: 0.5)],
                        count: dataManager.gowGames.count
                    ) {
                        GodOfWarRagnarokListView()
                            .environmentObject(dataManager)
                    }
                }.padding(.bottom, 50)
            }
        }.navigationTitle("")
        .navigationBarHidden(true)
    }
}

@available(iOS 14.0, *)
struct GameDashboardCardView<Destination: View>: View {
    let title: String
    let subtitle: String
    let imageName: String
    let color: Color
    let gradient: [Color]
    let count: Int
    let destination: Destination
    
    @State private var isPressing: Bool = false
    
    init(title: String, subtitle: String, imageName: String, color: Color, gradient: [Color], count: Int, @ViewBuilder destination: () -> Destination) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.color = color
        self.gradient = gradient
        self.count = count
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: gradient),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .shadow(color: color.opacity(0.8), radius: 15, x: 0, y: 0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: imageName)
                            .font(.system(size: 40, weight: .thin))
                            .foregroundColor(.white)
                            .shadow(color: color.opacity(0.8), radius: 5)
                        
                        Spacer()
                        
                        Text("\(count)")
                            .font(.system(.headline, design: .monospaced))
                            .padding(10)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white.opacity(0.4), lineWidth: 1))
                            .foregroundColor(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(title)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 2)
                        
                        Text(subtitle)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding(25)
            }
            .frame(height: 180)
            .padding(.horizontal, 20)
            .scaleEffect(isPressing ? 0.95 : 1.0)
            .opacity(isPressing ? 0.8 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPressing)
            
        }.buttonStyle(PressableButtonStyle(isPressing: $isPressing))
    }
}

@available(iOS 14.0, *)
struct PressableButtonStyle: ButtonStyle {
    @Binding var isPressing: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { newValue in
                isPressing = newValue
            }
    }
}
