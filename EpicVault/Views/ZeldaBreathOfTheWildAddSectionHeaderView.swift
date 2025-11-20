
import SwiftUI

@available(iOS 14.0, *)
extension Color {
    static let hexDarkGreen = Color(red: 0.1, green: 0.2, blue: 0.1)
    static let hexVeryDarkGreen = Color(red: 0.05, green: 0.15, blue: 0.05)
    static let hexDarkBlueGrey = Color(red: 0.1, green: 0.15, blue: 0.2)
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildAddSectionHeaderView: View {
    let title: String
    let iconName: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.green)
                .font(.headline)
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color.yellow)
        }
        .padding(.top, 10)
        .padding(.leading, 5)
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildAddFieldView: View {
    let title: String
    let placeholder: String
    let iconName: String
    @Binding var text: String
    var isMultiline: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.yellow)
                .padding(.horizontal, 5)

            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.green)
                    .frame(width: 20)
                
                if isMultiline {
                    TextEditor(text: $text)
                        .frame(height: 80)
                        .background(Color.clear)
                        .foregroundColor(.white)
                } else {
                    TextField(placeholder, text: $text)
                        .foregroundColor(.white)
                }
            }
            .padding(10)
            .background(Color.black.opacity(0.6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.green.opacity(0.7), lineWidth: 1)
            )
        }
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildAddNumericFieldView: View {
    let title: String
    let iconName: String
    @Binding var value: Int
    @State private var textValue: String = ""
    
    init(title: String, iconName: String, value: Binding<Int>) {
        self.title = title
        self.iconName = iconName
        self._value = value
        _textValue = State(initialValue: "\(value.wrappedValue)")
    }

    var body: some View {
        ZeldaBreathOfTheWildAddFieldView(
            title: title,
            placeholder: "Enter value",
            iconName: iconName,
            text: $textValue
        )
        .keyboardType(.numberPad)
        .onChange(of: textValue) { newValue in
            if let intValue = Int(newValue) {
                value = intValue
            }
        }
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildAddToggleView: View {
    let title: String
    let iconName: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.green)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .green))
        }
        .padding(10)
        .background(Color.black.opacity(0.6))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.green.opacity(0.7), lineWidth: 1)
        )
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildSearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            TextField("Search Hyrule...", text: $searchText)
                .padding(10)
                .padding(.leading, isEditing ? 10 : 30)
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.green)
                            .padding(.leading, 8)
                            .opacity(isEditing ? 0 : 1)
                        Spacer()
                    }
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.isEditing = true
                    }
                }
            
            if isEditing {
                Button("Cancel") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.isEditing = false
                        self.searchText = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
                .foregroundColor(.yellow)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .padding(.horizontal)
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildListRowView: View {
    let game: ZeldaBreathOfTheWild
    
    private func arraySummary(_ array: [String], limit: Int = 3) -> String {
        guard !array.isEmpty else { return "None" }
        let subset = array.prefix(limit).joined(separator: ", ")
        return array.count > limit ? "\(subset)..." : subset
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            if let uiImage = UIImage(data: game.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.red.opacity(0.7), radius: 5)
            } else {
                Image("zelda")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 230)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.red.opacity(0.7), radius: 5)
                
            }
            HStack {
                Text(game.name)
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(.yellow)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "figure.walk")
                    .foregroundColor(.green)
                Text(game.explorationFreedom)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Divider().background(Color.green.opacity(0.5))
            
            
            VStack(spacing: 5) {
                VStack(alignment: .leading, spacing: 4) {
                    statRow(icon: "heart.fill", label: "Health", value: "\(game.healthLevels)")
                    statRow(icon: "bolt.circle.fill", label: "Stamina", value: "\(game.staminaLevels)")
                    statRow(icon: "building.2.fill", label: "Shrines", value: "\(game.shrinesCount)")
                    statRow(icon: "leaf.fill", label: "Korok", value: "\(game.korokSeeds)")
                    statRow(icon: "map.fill", label: "Fast Travel", value: "\(game.fastTravelPoints)")
                    statRow(icon: "drop.fill", label: "Weather", value: game.weatherEffects ? "Active" : "Static")
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    statRow(icon: "hammer.fill", label: "Durability", value: game.weaponsDurability ? "On" : "Off")
                    statRow(icon: "wand.and.stars", label: "Weapons", value: arraySummary(game.weaponTypes, limit: 2))
                    statRow(icon: "tshirt.fill", label: "Armor Sets", value: arraySummary(game.armorSets, limit: 2))
                    statRow(icon: "pawprint.fill", label: "Mounts", value: arraySummary(game.mounts, limit: 1))
                    statRow(icon: "cube.fill", label: "Divine Beasts", value: arraySummary(game.divineBeasts, limit: 2))
                    statRow(icon: "flag.fill", label: "Enemy Camps", value: "\(game.enemyCamps)")
                }
            }
            .padding(.vertical, 5)
            
            
            Group {
                Text("Regions: \(arraySummary(game.worldRegions, limit: 4))")
                Text("Enemies: \(arraySummary(game.elementalEnemies, limit: 4))")
            }
            .font(.caption)
            .foregroundColor(.white.opacity(0.7))
            .lineLimit(1)
        }
        .padding()
        .background(
            ZStack {
                
                Color.gray.opacity(0.2)
                
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.green, lineWidth: 3)
            }
        )
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
    }
    
    private func statRow(icon: String, label: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.yellow)
                .font(.caption2)
            Text("\(label):")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.green)
        }
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildNoDataView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 80, height: 70)
                .foregroundColor(.yellow)
            
            Text("Hyrule is Empty!")
                .font(.system(size: 28))
                .fontWeight(.heavy)
                .foregroundColor(.white)
            
            Text("It seems Calamity Ganon took all the data. Tap the '+' to start collecting data on Link's adventure.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildDetailFieldRow: View {
    let label: String
    let value: String
    let iconName: String
    let accentColor: Color

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(accentColor)
                .frame(width: 20)
            
            Text(label)
                .font(.headline)
                .foregroundColor(.yellow)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.vertical, 5)
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildDetailSection: View {
    let title: String
    let iconName: String
    let content: AnyView

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.yellow)
                    .font(.title2)
                Text(title)
                    .font(.system(size: 24))
                    .foregroundColor(.green)
                    .fontWeight(.heavy)
            }
            .padding(.bottom, 5)
            
            content
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.green.opacity(0.8), lineWidth: 1)
                )
        }
        .padding(.vertical, 8)
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataManager: GameDataManager

    @State private var name: String = ""
    @State private var heroName: String = ""
    @State private var worldRegions: String = ""
    @State private var shrinesCount: Int = 0
    @State private var korokSeeds: Int = 0
    @State private var staminaLevels: Int = 0
    @State private var healthLevels: Int = 0
    @State private var weaponsDurability: Bool = true
    @State private var foodRecipes: String = ""
    @State private var craftingSystem: Bool = true
    @State private var fastTravelPoints: Int = 0
    @State private var divineBeasts: String = ""
    @State private var elementalEnemies: String = ""
    @State private var paragliderAvailable: Bool = true
    @State private var armorSets: String = ""
    @State private var weaponTypes: String = ""
    @State private var mounts: String = ""
    @State private var climateZones: String = ""
    @State private var stealthMechanics: String = ""
    @State private var enemyCamps: Int = 0
    @State private var dayNightCycle: Bool = true
    @State private var weatherEffects: Bool = true
    @State private var puzzles: String = ""
    @State private var bossBattles: String = ""
    @State private var explorationFreedom: String = ""
    @State private var worldSize: String = ""
    @State private var image: Data = UIImage(systemName: "gamecontroller")!.pngData()!
    
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private func validateAndSave() {
        var errors: [String] = []
        
        if name.isEmpty { errors.append("Game Title is required.") }
        if heroName.isEmpty { errors.append("Hero Name is required.") }
        if worldRegions.isEmpty { errors.append("World Regions are required.") }
        if explorationFreedom.isEmpty { errors.append("Exploration Freedom is required.") }
        if worldSize.isEmpty { errors.append("World Size is required.") }
        if stealthMechanics.isEmpty { errors.append("Stealth Mechanics is required.") }

        if shrinesCount <= 0 { errors.append("Shrines Count must be greater than 0.") }
        if healthLevels <= 0 { errors.append("Health Levels must be greater than 0.") }
        
        if errors.isEmpty {
            let newGame = ZeldaBreathOfTheWild(
                name: name,
                heroName: heroName,
                worldRegions: worldRegions.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                shrinesCount: shrinesCount,
                korokSeeds: korokSeeds,
                staminaLevels: staminaLevels,
                healthLevels: healthLevels,
                weaponsDurability: weaponsDurability,
                foodRecipes: foodRecipes.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                craftingSystem: craftingSystem,
                fastTravelPoints: fastTravelPoints,
                divineBeasts: divineBeasts.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                elementalEnemies: elementalEnemies.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                paragliderAvailable: paragliderAvailable,
                armorSets: armorSets.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                weaponTypes: weaponTypes.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                mounts: mounts.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                climateZones: climateZones.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                stealthMechanics: stealthMechanics,
                enemyCamps: enemyCamps,
                dayNightCycle: dayNightCycle,
                weatherEffects: weatherEffects,
                puzzles: puzzles.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                bossBattles: bossBattles.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                explorationFreedom: explorationFreedom,
                worldSize: worldSize,
                image: image
            )
            
            dataManager.addZelda(newGame)
            alertMessage = "✅ Success!\n'\(name)' has been added to the Game Box."
            showAlert = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.presentationMode.wrappedValue.dismiss()
            }
        } else {
            alertMessage = "❌ Validation Errors:\n" + errors.joined(separator: "\n")
            showAlert = true
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.hexDarkGreen
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 25) {
                        
                        VStack(spacing: 10) {
                            if let uiImage = inputImage {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 140)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 5)
                            } else {
                                Image(uiImage: UIImage(systemName: "photo.on.rectangle.angled")!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.yellow)
                            }
                            
                            Button(action: { showImagePicker = true }) {
                                Text("Select Game Image")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.top, 10)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            ZeldaBreathOfTheWildAddSectionHeaderView(title: "Hero & Core Info", iconName: "person.circle.fill")
                            
                            ZeldaBreathOfTheWildAddFieldView(title: "Game Title", placeholder: "e.g., Breath of the Wild", iconName: "gamecontroller.fill", text: $name)
                            ZeldaBreathOfTheWildAddFieldView(title: "Hero Name", placeholder: "e.g., Link", iconName: "figure.wave", text: $heroName)
                            ZeldaBreathOfTheWildAddFieldView(title: "Exploration Freedom", placeholder: "e.g., Unlimited, Story-gated", iconName: "map.fill", text: $explorationFreedom)
                            ZeldaBreathOfTheWildAddFieldView(title: "World Size", placeholder: "e.g., Massive, Moderate", iconName: "globe", text: $worldSize)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            ZeldaBreathOfTheWildAddSectionHeaderView(title: "Stats & Progression", iconName: "chart.bar.fill")
                            
                            HStack {
                                ZeldaBreathOfTheWildAddNumericFieldView(title: "Health Levels (Hearts)", iconName: "heart.fill", value: $healthLevels)
                                ZeldaBreathOfTheWildAddNumericFieldView(title: "Stamina Levels", iconName: "bolt.circle.fill", value: $staminaLevels)
                            }
                            HStack {
                                ZeldaBreathOfTheWildAddNumericFieldView(title: "Shrines Count", iconName: "building.2.fill", value: $shrinesCount)
                                ZeldaBreathOfTheWildAddNumericFieldView(title: "Korok Seeds", iconName: "leaf.fill", value: $korokSeeds)
                            }
                            HStack {
                                ZeldaBreathOfTheWildAddNumericFieldView(title: "Fast Travel Points", iconName: "location.north.fill", value: $fastTravelPoints)
                                ZeldaBreathOfTheWildAddNumericFieldView(title: "Enemy Camps", iconName: "flag.fill", value: $enemyCamps)
                            }
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 15) {
                            ZeldaBreathOfTheWildAddSectionHeaderView(title: "World & Gear (Comma Separated)", iconName: "mountain.2.fill")
                            
                            ZeldaBreathOfTheWildAddFieldView(title: "World Regions", placeholder: "e.g., Hyrule Field, Gerudo Desert", iconName: "map", text: $worldRegions)
                            ZeldaBreathOfTheWildAddFieldView(title: "Climate Zones", placeholder: "e.g., Desert, Tundra", iconName: "thermometer", text: $climateZones)
                            ZeldaBreathOfTheWildAddFieldView(title: "Weapon Types", placeholder: "e.g., Sword, Bow, Spear", iconName: "wand.and.stars", text: $weaponTypes)
                            ZeldaBreathOfTheWildAddFieldView(title: "Armor Sets", placeholder: "e.g., Climbing Gear, Stealth Armor", iconName: "tshirt.fill", text: $armorSets)
                            ZeldaBreathOfTheWildAddFieldView(title: "Mounts", placeholder: "e.g., Horse, Bear", iconName: "pawprint.fill", text: $mounts)
                            ZeldaBreathOfTheWildAddFieldView(title: "Food Recipes", placeholder: "e.g., Mushroom Skewer, Spicy Meat", iconName: "fork.knife", text: $foodRecipes)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            ZeldaBreathOfTheWildAddSectionHeaderView(title: "Enemies & Puzzles (Comma Separated)", iconName: "bolt.fill")
                            
                            ZeldaBreathOfTheWildAddFieldView(title: "Stealth Mechanics", placeholder: "e.g., Light-based visibility", iconName: "eye.slash.fill", text: $stealthMechanics)
                            ZeldaBreathOfTheWildAddFieldView(title: "Divine Beasts", placeholder: "e.g., Vah Ruta, Vah Naboris", iconName: "cube.fill", text: $divineBeasts)
                            ZeldaBreathOfTheWildAddFieldView(title: "Elemental Enemies", placeholder: "e.g., Fire Wizzrobe, Ice Moblin", iconName: "flame.fill", text: $elementalEnemies)
                            ZeldaBreathOfTheWildAddFieldView(title: "Puzzles", placeholder: "e.g., Shrine Challenges", iconName: "puzzlepiece.fill", text: $puzzles)
                            ZeldaBreathOfTheWildAddFieldView(title: "Boss Battles", placeholder: "e.g., Calamity Ganon", iconName: "crown.fill", text: $bossBattles)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            ZeldaBreathOfTheWildAddSectionHeaderView(title: "Toggle Features", iconName: "slider.horizontal.3")
                            
                            ZeldaBreathOfTheWildAddToggleView(title: "Weapons Durability", iconName: "hammer.fill", isOn: $weaponsDurability)
                            ZeldaBreathOfTheWildAddToggleView(title: "Crafting System", iconName: "sparkles", isOn: $craftingSystem)
                            ZeldaBreathOfTheWildAddToggleView(title: "Paraglider Available", iconName: "wind", isOn: $paragliderAvailable)
                            ZeldaBreathOfTheWildAddToggleView(title: "Day/Night Cycle", iconName: "moon.stars.fill", isOn: $dayNightCycle)
                            ZeldaBreathOfTheWildAddToggleView(title: "Weather Effects", iconName: "cloud.sun.fill", isOn: $weatherEffects)
                        }
                        .padding(.horizontal)
                        
                        Button(action: validateAndSave) {
                            Text("SAVE HYRULE DATA")
                                .font(.headline)
                                .fontWeight(.black)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .cornerRadius(12)
                                .shadow(color: .green, radius: 5, x: 0, y: 5)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                    }
                    .padding(.top, 20)
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
                }
            }
            .navigationBarTitle("Log New Zelda Game 📜", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") { self.presentationMode.wrappedValue.dismiss() }.foregroundColor(.yellow))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Submission Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        if let imageData = inputImage.jpegData(compressionQuality: 0.8) {
            image = imageData
        }
    }
}

@available(iOS 14.0, *)
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildListView: View {
    @EnvironmentObject var dataManager: GameDataManager
    @State private var showingAddView = false
    @State private var searchText: String = ""
    
    var filteredGames: [ZeldaBreathOfTheWild] {
        if searchText.isEmpty {
            return dataManager.zeldaGames
        } else {
            return dataManager.zeldaGames.filter { game in
                game.name.localizedCaseInsensitiveContains(searchText) ||
                game.heroName.localizedCaseInsensitiveContains(searchText) ||
                game.worldRegions.joined(separator: " ").localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.hexVeryDarkGreen
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZeldaBreathOfTheWildSearchBarView(searchText: $searchText)
                    .padding(.vertical, 5)
                
                if filteredGames.isEmpty {
                    ZeldaBreathOfTheWildNoDataView()
                        .padding(.top, 100)
                } else {
                    List {
                        ForEach(filteredGames) { game in
                            NavigationLink(destination: ZeldaBreathOfTheWildDetailView(game: game)) {
                                ZeldaBreathOfTheWildListRowView(game: game)
                                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                    .background(Color.clear)
                            }
                        }
                        .onDelete(perform: deleteGame)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .navigationBarTitle("Zelda Game Box ⚔️", displayMode: .large)
        .navigationBarItems(trailing:
                                Button(action: {
            self.showingAddView = true
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.title)
                .foregroundColor(.yellow)
        }
        )
        .sheet(isPresented: $showingAddView) {
            ZeldaBreathOfTheWildAddView()
                .environmentObject(dataManager)
        }
    }
    
    private func deleteGame(at offsets: IndexSet) {
        offsets.map { filteredGames[$0] }.forEach(dataManager.deleteZelda)
    }
}

@available(iOS 14.0, *)
struct ZeldaBreathOfTheWildDetailView: View {
    let game: ZeldaBreathOfTheWild
    
    private func listFormatted(_ list: [String]) -> String {
        list.joined(separator: ", ")
    }
    
    var body: some View {
        ZStack {
            Color.hexDarkBlueGrey
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    if let uiImage = UIImage(data: game.image) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(8)
                            .clipped()
                            .shadow(color: Color.red.opacity(0.7), radius: 5)
                    } else {
                        Image("zelda")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 280)
                            .cornerRadius(8)
                            .clipped()
                            .shadow(color: Color.red.opacity(0.7), radius: 5)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(game.name)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.yellow)
                            .lineLimit(2)
                        
                        Text("Hero: \(game.heroName)")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.green)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    Divider().background(Color.green)
                    
                    ZeldaBreathOfTheWildDetailSection(
                        title: "Stats of the Wild",
                        iconName: "chart.bar.fill",
                        content: AnyView(
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(alignment: .top, spacing: 20) {
                                    VStack(alignment: .leading) {
                                        ZeldaBreathOfTheWildDetailFieldRow(label: "Shrines", value: "\(game.shrinesCount)", iconName: "building.2.fill", accentColor: .yellow)
                                        ZeldaBreathOfTheWildDetailFieldRow(label: "Korok Seeds", value: "\(game.korokSeeds)", iconName: "leaf.fill", accentColor: .yellow)
                                        ZeldaBreathOfTheWildDetailFieldRow(label: "Health Levels", value: "\(game.healthLevels)", iconName: "heart.fill", accentColor: .red)
                                        ZeldaBreathOfTheWildDetailFieldRow(label: "Stamina Levels", value: "\(game.staminaLevels)", iconName: "bolt.circle.fill", accentColor: .blue)
                                        ZeldaBreathOfTheWildDetailFieldRow(label: "Fast Travel Pts", value: "\(game.fastTravelPoints)", iconName: "location.north.fill", accentColor: .purple)
                                    }
                                    VStack(alignment: .leading) {
                                        ZeldaBreathOfTheWildDetailFieldRow(label: "Enemy Camps", value: "\(game.enemyCamps)", iconName: "flag.fill", accentColor: .orange)
                                        ZeldaBreathOfTheWildDetailFieldRow(label: "World Size", value: game.worldSize, iconName: "globe", accentColor: .green)
                                        ZeldaBreathOfTheWildDetailFieldRow(label: "Exploration", value: game.explorationFreedom, iconName: "figure.walk", accentColor: .yellow)
                                    }
                                }
                            }
                        )
                    )
                    
                    ZeldaBreathOfTheWildDetailSection(
                        title: "Core Mechanics",
                        iconName: "gearshape.2.fill",
                        content: AnyView(
                            VStack(alignment: .leading, spacing: 10) {
                                ZeldaBreathOfTheWildDetailFieldRow(label: "Weapons Durability", value: game.weaponsDurability ? "YES" : "NO", iconName: "hammer.fill", accentColor: .red)
                                ZeldaBreathOfTheWildDetailFieldRow(label: "Crafting System", value: game.craftingSystem ? "YES" : "NO", iconName: "sparkles", accentColor: .blue)
                                ZeldaBreathOfTheWildDetailFieldRow(label: "Paraglider Available", value: game.paragliderAvailable ? "YES" : "NO", iconName: "wind", accentColor: .green)
                                ZeldaBreathOfTheWildDetailFieldRow(label: "Stealth Mechanics", value: game.stealthMechanics, iconName: "eye.slash.fill", accentColor: .gray)
                            }
                        )
                    )
                    
                    ZeldaBreathOfTheWildDetailSection(
                        title: "Hyrule Environment",
                        iconName: "cloud.sun.fill",
                        content: AnyView(
                            VStack(alignment: .leading, spacing: 10) {
                                ZeldaBreathOfTheWildDetailFieldRow(label: "Day/Night Cycle", value: game.dayNightCycle ? "YES" : "NO", iconName: "moon.stars.fill", accentColor: .yellow)
                                ZeldaBreathOfTheWildDetailFieldRow(label: "Weather Effects", value: game.weatherEffects ? "YES" : "NO", iconName: "cloud.rain.fill", accentColor: .blue)
                                ZeldaBreathOfTheWildDetailFieldRow(label: "Climate Zones", value: listFormatted(game.climateZones), iconName: "thermometer.sun.fill", accentColor: .orange)
                                ZeldaBreathOfTheWildDetailFieldRow(label: "World Regions", value: listFormatted(game.worldRegions), iconName: "map", accentColor: .green)
                            }
                        )
                    )
                    
                    ZeldaBreathOfTheWildDetailSection(
                        title: "Gear & Foes",
                        iconName: "person.3.fill",
                        content: AnyView(
                            HStack{
                                VStack(alignment: .leading, spacing: 15) {
                                    DetailArrayView(title: "Weapon Types", items: game.weaponTypes, icon: "wand.and.stars")
                                    DetailArrayView(title: "Armor Sets", items: game.armorSets, icon: "tshirt.fill")
                                    DetailArrayView(title: "Mounts", items: game.mounts, icon: "pawprint.fill")
                                    DetailArrayView(title: "Divine Beasts", items: game.divineBeasts, icon: "cube.fill")
                                    DetailArrayView(title: "Elemental Enemies", items: game.elementalEnemies, icon: "flame.fill")
                                    DetailArrayView(title: "Boss Battles", items: game.bossBattles, icon: "crown.fill")
                                    DetailArrayView(title: "Puzzles", items: game.puzzles, icon: "puzzlepiece.fill")
                                    DetailArrayView(title: "Food Recipes", items: game.foodRecipes, icon: "fork.knife")
                                }
                                Spacer()
                            }
                        )
                    )
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Link's Adventure Details")
    }
}

@available(iOS 14.0, *)
private struct DetailArrayView: View {
    let title: String
    let items: [String]
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.green)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.yellow)
            }
            
            Text(items.joined(separator: ", "))
                .font(.callout)
                .foregroundColor(.white)
                .padding(.leading, 25)
        }
    }
}
