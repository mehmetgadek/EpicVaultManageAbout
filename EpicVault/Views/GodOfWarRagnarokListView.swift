
import SwiftUI
import PhotosUI

@available(iOS 14.0, *)
struct GodOfWarRagnarokAddSectionHeaderView: View {
    let title: String
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.red)
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.black.opacity(0.6))
        .cornerRadius(10)
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokAddFieldView: View {
    @Binding var text: String
    let placeholder: String
    let iconName: String
    let keyboardType: UIKeyboardType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.gray)
                TextField("", text: $text)
                    .foregroundColor(.white)
                    .keyboardType(keyboardType)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                Text(placeholder)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .offset(y: 0)
                    .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
                    .padding(.horizontal, 10),
                alignment: .topLeading
            )
        }
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokAddToggleView: View {
    let label: String
    @Binding var isOn: Bool
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.red)
            Text(label)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .red))
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokAddStepperView: View {
    let label: String
    @Binding var value: Int
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.red)
            Text("\(label): **\(value)**")
                .foregroundColor(.white)
            Spacer()
            Stepper("", value: $value, in: 0...100)
                .labelsHidden()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataManager: GameDataManager
    
    @State private var name: String = "God of War: Ragnarök"
    @State private var mainCharacter: String = "Kratos"
    @State private var companionCharacter: String = "Atreus"
    @State private var realmsVisited: String = "Midgard, Asgard, Vanaheim"
    @State private var weaponTypes: String = "Leviathan Axe, Blades of Chaos"
    @State private var shieldTypes: String = "Guardian Shield, Dauntless Shield"
    @State private var armorSets: String = "Spartan Rage, Berserker Armor"
    @State private var skillTreeAbilities: String = "Frost Strike, Wrath of the Frost"
    @State private var enemiesFaced: String = "Draugr, Odin’s Ravens"
    @State private var bossesDefeated: String = "Thor, Odin"
    @State private var sideQuests: Int = 40
    @State private var collectibles: String = "Artifacts, Lore Scrolls"
    @State private var puzzles: String = "Rune Locks, Light Bridges"
    @State private var explorationAreas: String = "Frozen Lake, Dwarven Mines"
    @State private var cameraStyle: String = "One-shot cinematic"
    @State private var combatSystem: String = "Action Combo"
    @State private var specialMoves: String = "Spartan Rage, Runic Attacks"
    @State private var magicRunes: String = "Frost, Fire, Wind"
    @State private var craftingUpgrades: Bool = true
    @State private var dialogueChoices: Bool = false
    @State private var cinematicMoments: Bool = true
    @State private var fastTravelPoints: Int = 25
    @State private var worldScale: String = "Large"
    @State private var healthUpgrades: Int = 10
    @State private var rageMode: Bool = true
    @State private var mythologicalCreatures: String = "Fenrir, Jörmungandr"
    
    @State private var inputImage: UIImage? = nil
    @State private var showImagePicker = false
    
    @State private var showingAlert = false
    @State private var alertMessage = ""


    private func validateAndSave() {
        var errors: [String] = []
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Name is required.") }
        if mainCharacter.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Main Character is required.") }
        if companionCharacter.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Companion Character is required.") }
        if realmsVisited.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Realms Visited is required.") }
        if weaponTypes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Weapon Types is required.") }
        if shieldTypes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Shield Types is required.") }
        if armorSets.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Armor Sets is required.") }
        if skillTreeAbilities.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Skill Tree Abilities is required.") }
        if enemiesFaced.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Enemies Faced is required.") }
        if bossesDefeated.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Bosses Defeated is required.") }
        if collectibles.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Collectibles is required.") }
        if puzzles.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Puzzles is required.") }
        if explorationAreas.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Exploration Areas is required.") }
        if cameraStyle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Camera Style is required.") }
        if combatSystem.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Combat System is required.") }
        if specialMoves.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Special Moves is required.") }
        if magicRunes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Magic Runes is required.") }
        if worldScale.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("World Scale is required.") }
        if mythologicalCreatures.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Mythological Creatures is required.") }
        if sideQuests < 0 { errors.append("Side Quests must be non-negative.") }
        if fastTravelPoints < 0 { errors.append("Fast Travel Points must be non-negative.") }
        if healthUpgrades < 0 { errors.append("Health Upgrades must be non-negative.") }
        if errors.isEmpty {
            
            guard let imageData = inputImage?.pngData() else {
                errors.append("Could not convert image to data.")
                alertMessage = "Validation Errors: \n" + errors.joined(separator: "\n")
                showingAlert = true
                return
            }
            
            let newGame = GodOfWarRagnarok(
                name: name, mainCharacter: mainCharacter, companionCharacter: companionCharacter,
                realmsVisited: realmsVisited.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                weaponTypes: weaponTypes.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                shieldTypes: shieldTypes.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                armorSets: armorSets.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                skillTreeAbilities: skillTreeAbilities.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                enemiesFaced: enemiesFaced.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                bossesDefeated: bossesDefeated.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                sideQuests: sideQuests,
                collectibles: collectibles.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                puzzles: puzzles.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                explorationAreas: explorationAreas.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                cameraStyle: cameraStyle, combatSystem: combatSystem,
                specialMoves: specialMoves.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                magicRunes: magicRunes.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                craftingUpgrades: craftingUpgrades, dialogueChoices: dialogueChoices,
                cinematicMoments: cinematicMoments, fastTravelPoints: fastTravelPoints,
                worldScale: worldScale, healthUpgrades: healthUpgrades, rageMode: rageMode,
                mythologicalCreatures: mythologicalCreatures.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                image: imageData
            )
            dataManager.addGOW(newGame)
            alertMessage = "✅ Success!\nGod of War: Ragnarök data saved."
            self.presentationMode.wrappedValue.dismiss()
        } else {
            alertMessage = "❌ Validation Errors:\n" + errors.joined(separator: "\n")
        }
        showingAlert = true
    }
    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                VStack {
                    if let image = inputImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .cornerRadius(12)
                            .onTapGesture { showImagePicker = true }
                    }
                    Button(action: { showImagePicker = true }) {
                        Label("Select Image", systemImage: "photo.on.rectangle.angled")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.8))
                            .cornerRadius(10)
                    }
                }
                .padding(.vertical, 10)
                
                VStack(spacing: 25) {
                    GodOfWarRagnarokAddSectionHeaderView(title: "⚔️ Core Game Info", iconName: "star.fill")
                    GodOfWarRagnarokAddFieldView(text: $name, placeholder: "Game Title", iconName: "gamecontroller.fill", keyboardType: .default)
                    HStack(spacing: 15) {
                        GodOfWarRagnarokAddFieldView(text: $mainCharacter, placeholder: "Main Character", iconName: "person.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $companionCharacter, placeholder: "Companion", iconName: "figure.walk", keyboardType: .default)
                    }
                    
                    
                    GodOfWarRagnarokAddFieldView(text: $realmsVisited, placeholder: "Realms Visited (comma-separated)", iconName: "map.fill", keyboardType: .default)
                    GodOfWarRagnarokAddSectionHeaderView(title: "🛡️ Combat & Gear", iconName: "hammer.fill")
                    
                    VStack(spacing: 15) {
                        GodOfWarRagnarokAddFieldView(text: $weaponTypes, placeholder: "Weapon Types", iconName: "hammer.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $shieldTypes, placeholder: "Shield Types", iconName: "shield.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $armorSets, placeholder: "Armor Sets", iconName: "tshirt.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $skillTreeAbilities, placeholder: "Skill Tree Abilities", iconName: "wand.and.stars", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $combatSystem, placeholder: "Combat System", iconName: "bolt.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $specialMoves, placeholder: "Special Moves", iconName: "sparkles", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $magicRunes, placeholder: "Magic Runes", iconName: "circle.grid.2x2.fill", keyboardType: .default)
                    }
                    
                    GodOfWarRagnarokAddSectionHeaderView(title: "👹 Foes & Battles", iconName: "theatermask.and.frown.fill")
                    
                    VStack(spacing: 15) {
                        GodOfWarRagnarokAddFieldView(text: $enemiesFaced, placeholder: "Enemies Faced", iconName: "person.3.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $bossesDefeated, placeholder: "Bosses Defeated", iconName: "flame.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $mythologicalCreatures, placeholder: "Mythological Creatures", iconName: "pawprint.fill", keyboardType: .default)
                    }
                    
                    GodOfWarRagnarokAddSectionHeaderView(title: "⚙️ Game Systems & Stats", iconName: "gearshape.2.fill")
                    
                    VStack(spacing: 15) {
                        GodOfWarRagnarokAddFieldView(text: $cameraStyle, placeholder: "Camera Style", iconName: "video.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $worldScale, placeholder: "World Scale", iconName: "globe", keyboardType: .default)
                        GodOfWarRagnarokAddToggleView(label: "Crafting Upgrades", isOn: $craftingUpgrades, iconName: "hammer.circle.fill")
                        GodOfWarRagnarokAddToggleView(label: "Dialogue Choices", isOn: $dialogueChoices, iconName: "bubble.left.and.bubble.right.fill")
                        GodOfWarRagnarokAddToggleView(label: "Cinematic Moments", isOn: $cinematicMoments, iconName: "film.fill")
                        GodOfWarRagnarokAddToggleView(label: "Rage Mode", isOn: $rageMode, iconName: "hare.fill")
                        GodOfWarRagnarokAddStepperView(label: "Side Quests", value: $sideQuests, iconName: "figure.walk")
                        GodOfWarRagnarokAddStepperView(label: "Fast Travel Points", value: $fastTravelPoints, iconName: "tram.fill")
                        GodOfWarRagnarokAddStepperView(label: "Health Upgrades", value: $healthUpgrades, iconName: "heart.circle.fill")
                        GodOfWarRagnarokAddFieldView(text: $collectibles, placeholder: "Collectibles", iconName: "cube.box.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $puzzles, placeholder: "Puzzles", iconName: "puzzlepiece.fill", keyboardType: .default)
                        GodOfWarRagnarokAddFieldView(text: $explorationAreas, placeholder: "Exploration Areas", iconName: "safari.fill", keyboardType: .default)
                    }
                    
                    Button(action: validateAndSave) {
                        Text("Save God of War Data")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(15)
                            .shadow(color: .red, radius: 10)
                    }
                    .padding(.top, 20)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertMessage.contains("Success") ? "Operation Status" : "Validation Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }.padding()
                    .sheet(isPresented: $showImagePicker) {
                        GrandTheftAutoVImagePicker(image: $inputImage)
                    }
            }
        }
        .navigationTitle("New Ragnarök Entry")
    }
}


@available(iOS 14.0, *)
struct GodOfWarRagnarokSearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .opacity(searchText.isEmpty ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: searchText.isEmpty)
            
            TextField("Search by Title or Character...", text: $searchText)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 5)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 5)
                .transition(.scale)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
        .shadow(color: .red.opacity(0.5), radius: 5)
        .animation(.easeInOut(duration: 0.3), value: searchText.isEmpty)
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokListRowView: View {
    let game: GodOfWarRagnarok
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            if let uiImage = UIImage(data: game.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.red.opacity(0.7), radius: 5)
            } else {
                Image("regnorok")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.red.opacity(0.7), radius: 5)
            }
            
            HStack {
                Text(game.name)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer()
                
            }
            .padding(.bottom, 5)
            
            Divider().background(Color.red.opacity(0.5))
            
            HStack(spacing: 15) {
                InfoBlock(label: "Main", value: game.mainCharacter, icon: "person.fill")
                Spacer()
                InfoBlock(label: "Companion", value: game.companionCharacter, icon: "figure.walk")
                Spacer()
                InfoBlock(label: "World Scale", value: game.worldScale, icon: "globe")
            }
            
            HStack{
                InfoBlock(label: "Weapon 1", value: game.weaponTypes.first ?? "N/A", icon: "axe.fill")
                Spacer()
                InfoBlock(label: "Shield 1", value: game.shieldTypes.first ?? "N/A", icon: "shield.fill")
            }
            
            HStack{
                InfoBlock(label: "Combat", value: game.combatSystem, icon: "bolt.fill")
                Spacer()
                InfoBlock(label: "Camera", value: game.cameraStyle, icon: "video.fill")
            }
            
            HStack{
                InfoBlock(label: "Side Quests", value: "\(game.sideQuests)", icon: "list.bullet")
                Spacer()
                InfoBlock(label: "Bosses", value: "\(game.bossesDefeated.count)", icon: "flame.fill")
            }
            HStack{
                InfoBlock(label: "Runes", value: game.magicRunes.first ?? "N/A", icon: "circle.grid.2x2.fill")
                Spacer()
                InfoBlock(label: "Rage Mode", value: game.rageMode ? "Yes" : "No", icon: "hare.fill")
            }
            HStack{
                InfoBlock(label: "Realms", value: "\(game.realmsVisited.count)", icon: "map.fill")
                Spacer()
                InfoBlock(label: "Upgrades", value: game.craftingUpgrades ? "Yes" : "No", icon: "hammer.circle.fill")
            }
            
            .padding(.vertical, 5)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("**Key Foes:** \(game.enemiesFaced.prefix(2).joined(separator: ", ")) and others...")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("**Puzzles:** \(game.puzzles.prefix(1).first ?? "None") | **Collectibles:** \(game.collectibles.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                .shadow(color: .red.opacity(0.7), radius: 8, x: 0, y: 5)
        )
    }
    
    struct InfoBlock: View {
        let label: String
        let value: String
        let icon: String
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(.red)
                        .font(.caption)
                    Text(label)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
        }
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokNoDataView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.red)
            
            Text("No Ragnarök Entries Found!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Use the '+' button to add new game data. Kratos is waiting!")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(40)
        .background(Color.black.opacity(0.7))
        .cornerRadius(20)
        .shadow(color: .red.opacity(0.8), radius: 15)
        .padding(.horizontal, 30)
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokListView: View {
    @EnvironmentObject var dataManager: GameDataManager
    @State private var searchText = ""
    
    var filteredGames: [GodOfWarRagnarok] {
        if searchText.isEmpty {
            return dataManager.gowGames
        } else {
            return dataManager.gowGames.filter { game in
                game.name.localizedCaseInsensitiveContains(searchText) ||
                game.mainCharacter.localizedCaseInsensitiveContains(searchText) ||
                game.companionCharacter.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        if let index = offsets.first {
            let gameToDelete = filteredGames[index]
            dataManager.deleteGOW(gameToDelete)
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("God of War: Ragnarök Box")
                    .font(.system(size: 25))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                
                GodOfWarRagnarokSearchBarView(searchText: $searchText)
                
                if filteredGames.isEmpty {
                    Spacer()
                    GodOfWarRagnarokNoDataView()
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(filteredGames, id: \.id) { game in
                            ZStack {
                                NavigationLink(destination: GodOfWarRagnarokDetailView(game: game)) {
                                    GodOfWarRagnarokListRowView(game: game)
                                        .listRowBackground(Color.black)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
        }
        .navigationBarItems(
            trailing: NavigationLink(destination: GodOfWarRagnarokAddView().environmentObject(dataManager)) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
        )
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokDetailFieldRow: View {
    let label: String
    let value: String
    let iconName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.yellow)
                    .font(.caption)
                Text(label)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
            Text(value)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(.white)
        }
        .padding(.vertical, 5)
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokDetailSectionHeader: View {
    let title: String
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.red)
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.vertical, 8)
    }
}

@available(iOS 14.0, *)
struct GodOfWarRagnarokDetailView: View {
    let game: GodOfWarRagnarok
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.05).edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack {
                        
                        if let uiImage = UIImage(data: game.image) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .cornerRadius(8)
                                .clipped()
                                .shadow(color: Color.red.opacity(0.7), radius: 5)
                        } else {
                            Image("regnorok")
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .frame(height: 280)
                                .cornerRadius(8)
                                .clipped()
                                .shadow(color: Color.red.opacity(0.7), radius: 5)
                        }
                        Text(game.name)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        HStack(spacing: 15) {
                            DetailPill(label: game.mainCharacter, icon: "person.circle.fill", color: .red)
                            DetailPill(label: game.companionCharacter, icon: "figure.walk", color: .yellow)
                            DetailPill(label: game.worldScale, icon: "globe", color: .blue)
                        }
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        GodOfWarRagnarokDetailSectionHeader(title: "Main Campaign & Exploration", iconName: "map.fill")
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 15) {
                            GodOfWarRagnarokDetailFieldRow(label: "Realms Visited", value: game.realmsVisited.joined(separator: ", "), iconName: "star.lefthalf.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Side Quests Count", value: "\(game.sideQuests)", iconName: "figure.walk")
                            GodOfWarRagnarokDetailFieldRow(label: "Fast Travel Points", value: "\(game.fastTravelPoints)", iconName: "location.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Exploration Areas", value: game.explorationAreas.joined(separator: ", "), iconName: "safari.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Puzzles", value: game.puzzles.joined(separator: ", "), iconName: "puzzlepiece.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Collectibles", value: game.collectibles.joined(separator: ", "), iconName: "treasurebox.fill")
                        }
                    }
                    .padding()
                    .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        GodOfWarRagnarokDetailSectionHeader(title: "Combat & Arsenal", iconName: "hammer.fill")
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 15) {
                            GodOfWarRagnarokDetailFieldRow(label: "Weapon Types", value: game.weaponTypes.joined(separator: ", "), iconName: "axe.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Shield Types", value: game.shieldTypes.joined(separator: ", "), iconName: "shield.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Armor Sets", value: game.armorSets.joined(separator: ", "), iconName: "tshirt.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Skill Abilities", value: game.skillTreeAbilities.joined(separator: ", "), iconName: "wand.and.stars")
                            GodOfWarRagnarokDetailFieldRow(label: "Combat System", value: game.combatSystem, iconName: "bolt.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Special Moves", value: game.specialMoves.joined(separator: ", "), iconName: "sparkles")
                            GodOfWarRagnarokDetailFieldRow(label: "Magic Runes", value: game.magicRunes.joined(separator: ", "), iconName: "circle.grid.2x2.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Camera Style", value: game.cameraStyle, iconName: "video.fill")
                        }
                    }
                    .padding()
                    .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        GodOfWarRagnarokDetailSectionHeader(title: "Foes & Creatures", iconName: "theatermask.and.frown.fill")
                        
                        GodOfWarRagnarokDetailFieldRow(label: "Enemies Faced", value: game.enemiesFaced.joined(separator: " | "), iconName: "person.3.fill")
                        Divider().background(Color.gray.opacity(0.5))
                        GodOfWarRagnarokDetailFieldRow(label: "Bosses Defeated", value: game.bossesDefeated.joined(separator: " | "), iconName: "flame.fill")
                        Divider().background(Color.gray.opacity(0.5))
                        GodOfWarRagnarokDetailFieldRow(label: "Mythological Creatures", value: game.mythologicalCreatures.joined(separator: " | "), iconName: "pawprint.fill")
                    }
                    .padding()
                    .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        GodOfWarRagnarokDetailSectionHeader(title: "System Status", iconName: "gearshape.2.fill")
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 15) {
                            ToggleStat(label: "Crafting Upgrades", isOn: game.craftingUpgrades, icon: "hammer.circle.fill")
                            ToggleStat(label: "Dialogue Choices", isOn: game.dialogueChoices, icon: "bubble.left.and.bubble.right.fill")
                            ToggleStat(label: "Cinematic Moments", isOn: game.cinematicMoments, icon: "film.fill")
                            ToggleStat(label: "Rage Mode", isOn: game.rageMode, icon: "hare.fill")
                            GodOfWarRagnarokDetailFieldRow(label: "Health Upgrades", value: "\(game.healthUpgrades)", iconName: "heart.circle.fill")
                        }
                    }
                    .padding()
                    .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                }
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    struct DetailPill: View {
        let label: String
        let icon: String
        let color: Color
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                Text(label)
                    .fontWeight(.medium)
            }
            .font(.caption)
            .padding(8)
            .background(color.opacity(0.2))
            .foregroundColor(color)
            .cornerRadius(10)
        }
    }
    
    struct ToggleStat: View {
        let label: String
        let isOn: Bool
        let icon: String
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(isOn ? .red : .gray)
                Text(label)
                    .foregroundColor(isOn ? .white : .gray)
                Spacer()
                Text(isOn ? "Yes" : "No")
                    .fontWeight(.bold)
                    .foregroundColor(isOn ? .red : .gray)
            }
            .padding(.vertical, 5)
        }
    }
}
