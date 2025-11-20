
import SwiftUI
import UIKit

@available(iOS 14.0, *)
struct AssassinsCreedValhallaImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImageData: Data
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: AssassinsCreedValhallaImagePicker
        
        init(_ parent: AssassinsCreedValhallaImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                self.parent.selectedImageData = uiImage.pngData() ?? Data()
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaAddFieldView: View {
    @Binding var text: String
    var title: String
    var icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color.yellow)
                .padding(.horizontal, 8)
                .background(Color.black.opacity(0.7))
                .cornerRadius(4)
                .offset(y: 0)

            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                TextField("", text: $text)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .background(Color.black.opacity(0.3))
            )
        }
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaAddSectionHeaderView: View {
    var title: String
    var icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.red)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.top, 20)
        .padding(.bottom, 5)
        .padding(.leading)
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaAddToggleView: View {
    @Binding var isOn: Bool
    var label: String
    var icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.red)
            Text(label)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .yellow))
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaSearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            TextField("Search Valhalla Entries...", text: $searchText)
                .padding(7)
                .padding(.horizontal, isEditing ? 30 : 25)
                .background(Color(white: 0.8).opacity(0.8))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                        .foregroundColor(.yellow)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal)
        .animation(.default, value: isEditing)
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaStatsRow: View {
    var icon1: String
    var label1: String
    var value1: String
    var icon2: String
    var label2: String
    var value2: String
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: icon1)
                    .foregroundColor(.red)
                Text(label1 + ":")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(value1)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Group {
                Image(systemName: icon2)
                    .foregroundColor(.red)
                Text(label2 + ":")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(value2)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
        }
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaListRowView: View {
    var game: AssassinsCreedValhalla

    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                
                if let uiImage = UIImage(data: game.image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .cornerRadius(8)
                        .clipped()
                        .shadow(color: Color.red.opacity(0.7), radius: 5)
                } else {
                    Image("valalah")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .cornerRadius(8)
                        .clipped()
                        .shadow(color: Color.red.opacity(0.7), radius: 5)
                }
                
                HStack {
                    Text(game.name)
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(.yellow)
                    Spacer()
                    Text(game.clanName)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                
                
                VStack(spacing: 5) {
                    AssassinsCreedValhallaStatsRow(
                        icon1: "person.circle.fill",
                        label1: "Character",
                        value1: game.playableCharacter,
                        icon2: "map.fill",
                        label2: "Regions",
                        value2: "\(game.openWorldRegions.count)"
                    )
                    
                    AssassinsCreedValhallaStatsRow(
                        icon1: "hammer.fill",
                        label1: "Raids",
                        value1: "\(game.raidsAvailable)",
                        icon2: "shield.lefthalf.filled",
                        label2: "Style",
                        value2: game.combatStyle
                    )
                    
                    AssassinsCreedValhallaStatsRow(
                        icon1: "sparkles",
                        label1: "Abilities",
                        value1: "\(game.skillTreeAbilities.count)",
                        icon2: "clock.fill",
                        label2: "Hidden Blades",
                        value2: game.hiddenBlades ? "Yes" : "No"
                    )
                }
                .padding(.leading, 5)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.init(red: 0.1, green: 0.1, blue: 0.15))
                .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 5)
        )
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaNoDataView: View {
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.red)
            Text("Eivor's Journal is Empty")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)
            Text("No records match your search or have been added yet. Time for a new saga!")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(40)
        .background(Color.black.opacity(0.5))
        .cornerRadius(20)
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaDetailFieldRow: View {
    var label: String
    var value: String
    var icon: String

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .foregroundColor(.red)
                .frame(width: 20)
            
            Text(label + ":")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.white)
        }
        .padding(.vertical, 8)
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaDetailHeader: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.yellow)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Views

@available(iOS 14.0, *)
struct AssassinsCreedValhallaAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataManager: GameDataManager

    @State private var name: String = ""
    @State private var playableCharacter: String = ""
    @State private var genderChoiceAvailable: Bool = true
    @State private var clanName: String = ""
    @State private var mainStoryChapters: String = ""
    @State private var openWorldRegions: String = ""
    @State private var settlementCustomization: Bool = true
    @State private var raidsAvailable: String = ""
    @State private var enemyTypes: String = ""
    @State private var skillTreeAbilities: String = ""
    @State private var stealthMechanics: String = ""
    @State private var combatStyle: String = ""
    @State private var weaponTypes: String = ""
    @State private var armorSets: String = ""
    @State private var mountsAvailable: String = ""
    @State private var companions: String = ""
    @State private var mythologicalRealms: String = ""
    @State private var dialogueChoices: Bool = true
    @State private var historicalFigures: String = ""
    @State private var explorationFocus: String = ""
    @State private var collectibles: String = ""
    @State private var miniGames: String = ""
    @State private var synchronizationPoints: String = ""
    @State private var weatherSystem: Bool = true
    @State private var dayNightCycle: Bool = true
    @State private var hiddenBlades: Bool = true
    
    @State private var image: Data = Data()
    @State private var showingImagePicker = false
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            Color.init(red: 0.15, green: 0.15, blue: 0.2)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 15) {
                    
                    Text("New Valhalla Saga")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.yellow)
                        .padding(.top, 20)

                    AssassinsCreedValhallaAddSectionHeaderView(title: "Cover Image", icon: "photo.fill")
                    
                    Button(action: { showingImagePicker = true }) {
                        VStack {
                            if let uiImage = UIImage(data: image) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                                    .cornerRadius(10)
                            } else {
                                Image(systemName: "photo.badge.plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 70)
                                    .foregroundColor(.yellow)
                                Text("Upload Saga Cover")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        AssassinsCreedValhallaImagePicker(selectedImageData: $image)
                    }

                    AssassinsCreedValhallaAddSectionHeaderView(title: "Core Saga Details", icon: "book.closed.fill")
                    
                    AssassinsCreedValhallaAddFieldView(text: $name, title: "Game Title", icon: "gamecontroller.fill")
                    AssassinsCreedValhallaAddFieldView(text: $playableCharacter, title: "Playable Character", icon: "person.fill")
                    AssassinsCreedValhallaAddToggleView(isOn: $genderChoiceAvailable, label: "Gender Choice Available", icon: "person.2.fill")
                    AssassinsCreedValhallaAddFieldView(text: $clanName, title: "Clan Name", icon: "shield.righthalf.filled")

                    AssassinsCreedValhallaAddSectionHeaderView(title: "World & Progression", icon: "map.fill")
                    
                    AssassinsCreedValhallaAddFieldView(text: $mainStoryChapters, title: "Main Story Chapters", icon: "list.number")
                        .keyboardType(.numberPad)
                    AssassinsCreedValhallaAddFieldView(text: $openWorldRegions, title: "Open World Regions (Comma-separated)", icon: "globe")
                    AssassinsCreedValhallaAddFieldView(text: $raidsAvailable, title: "Raids Available", icon: "figure.walk.motion")
                        .keyboardType(.numberPad)
                    AssassinsCreedValhallaAddFieldView(text: $synchronizationPoints, title: "Synchronization Points", icon: "square.grid.3x3.fill")
                        .keyboardType(.numberPad)
                    AssassinsCreedValhallaAddToggleView(isOn: $settlementCustomization, label: "Settlement Customization", icon: "house.fill")
                    AssassinsCreedValhallaAddFieldView(text: $explorationFocus, title: "Exploration Focus (e.g., High)", icon: "scope")


                    AssassinsCreedValhallaAddSectionHeaderView(title: "Combat & Gear", icon: "hammer.fill")
                    
                    AssassinsCreedValhallaAddFieldView(text: $combatStyle, title: "Combat Style", icon: "figure.strengthtraining.functional")
                    AssassinsCreedValhallaAddFieldView(text: $weaponTypes, title: "Weapon Types (Comma-separated)", icon: "goforward.10")
                    AssassinsCreedValhallaAddFieldView(text: $armorSets, title: "Armor Sets (Comma-separated)", icon: "tshirt.fill")
                    AssassinsCreedValhallaAddFieldView(text: $skillTreeAbilities, title: "Skill Tree Abilities (Comma-separated)", icon: "sparkles")
                    AssassinsCreedValhallaAddFieldView(text: $stealthMechanics, title: "Stealth Mechanics Summary", icon: "eye.slash.fill")
                    AssassinsCreedValhallaAddToggleView(isOn: $hiddenBlades, label: "Hidden Blades Available", icon: "scissors")


                    AssassinsCreedValhallaAddSectionHeaderView(title: "Lore & Supporting Cast", icon: "person.3.fill")

                    AssassinsCreedValhallaAddFieldView(text: $companions, title: "Companions (Comma-separated)", icon: "figure.walk")
                    AssassinsCreedValhallaAddFieldView(text: $historicalFigures, title: "Historical Figures (Comma-separated)", icon: "person.text.rectangle.fill")
                    AssassinsCreedValhallaAddFieldView(text: $mythologicalRealms, title: "Mythological Realms (Comma-separated)", icon: "mountain.2.fill")
                    AssassinsCreedValhallaAddFieldView(text: $enemyTypes, title: "Enemy Types (Comma-separated)", icon: "figure.martial.arts")
                    AssassinsCreedValhallaAddToggleView(isOn: $dialogueChoices, label: "Dialogue Choices Impact", icon: "text.bubble.fill")

                    AssassinsCreedValhallaAddSectionHeaderView(title: "Environment & Side Content", icon: "sun.max.fill")
                    
                    AssassinsCreedValhallaAddFieldView(text: $mountsAvailable, title: "Mounts Available (Comma-separated)", icon: "pawprint.fill")
                    AssassinsCreedValhallaAddFieldView(text: $collectibles, title: "Collectibles (Comma-separated)", icon: "diamond.fill")
                    AssassinsCreedValhallaAddFieldView(text: $miniGames, title: "Mini Games (Comma-separated)", icon: "dice.fill")
                    AssassinsCreedValhallaAddToggleView(isOn: $weatherSystem, label: "Dynamic Weather System", icon: "cloud.rain.fill")
                    AssassinsCreedValhallaAddToggleView(isOn: $dayNightCycle, label: "Day/Night Cycle", icon: "moon.stars.fill")

                    Button(action: saveGame) {
                        Text("Save New Saga Entry")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .padding(.top, 20)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .navigationBarTitle("Add Valhalla Record", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage.contains("Success") ? "Saga Saved!" : "Saga Incomplete"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                if alertMessage.contains("Success") {
                    presentationMode.wrappedValue.dismiss()
                }
            }))
        }
    }

    func saveGame() {
        var errors: [String] = []

        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Game Title is missing.") }
        if playableCharacter.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Playable Character is missing.") }
        if clanName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Clan Name is missing.") }
        
        if mainStoryChapters.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || Int(mainStoryChapters) == nil { errors.append("Main Story Chapters must be a number.") }
        if openWorldRegions.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Open World Regions are missing.") }
        if raidsAvailable.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || Int(raidsAvailable) == nil { errors.append("Raids Available must be a number.") }
        if synchronizationPoints.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || Int(synchronizationPoints) == nil { errors.append("Synchronization Points must be a number.") }
        if explorationFocus.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Exploration Focus is missing.") }
        if combatStyle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Combat Style is missing.") }
        if stealthMechanics.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Stealth Mechanics is missing.") }
        if weaponTypes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Weapon Types are missing.") }
        if armorSets.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Armor Sets are missing.") }
        if skillTreeAbilities.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Skill Tree Abilities are missing.") }
        if mountsAvailable.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Mounts Available are missing.") }
        if companions.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Companions are missing.") }
        if mythologicalRealms.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Mythological Realms are missing.") }
        if historicalFigures.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Historical Figures are missing.") }
        if collectibles.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Collectibles are missing.") }
        if miniGames.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Mini Games are missing.") }
        if enemyTypes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Enemy Types are missing.") }

        if image.isEmpty {
            if let defaultData = UIImage(systemName: "gamecontroller")?.pngData() {
                image = defaultData
            }
        }
        
        if errors.isEmpty {
            let newGame = AssassinsCreedValhalla(
                name: name,
                playableCharacter: playableCharacter,
                genderChoiceAvailable: genderChoiceAvailable,
                clanName: clanName,
                mainStoryChapters: Int(mainStoryChapters) ?? 0,
                openWorldRegions: openWorldRegions.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                settlementCustomization: settlementCustomization,
                raidsAvailable: Int(raidsAvailable) ?? 0,
                enemyTypes: enemyTypes.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                skillTreeAbilities: skillTreeAbilities.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                stealthMechanics: stealthMechanics,
                combatStyle: combatStyle,
                weaponTypes: weaponTypes.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                armorSets: armorSets.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                mountsAvailable: mountsAvailable.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                companions: companions.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                mythologicalRealms: mythologicalRealms.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                dialogueChoices: dialogueChoices,
                historicalFigures: historicalFigures.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                explorationFocus: explorationFocus,
                collectibles: collectibles.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                miniGames: miniGames.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                synchronizationPoints: Int(synchronizationPoints) ?? 0,
                weatherSystem: weatherSystem,
                dayNightCycle: dayNightCycle,
                hiddenBlades: hiddenBlades,
                image: image
            )
            
            dataManager.addValhalla(newGame)
            alertMessage = "Success! The new Valhalla entry has been saved to the database."
            showingAlert = true
            
        } else {
            alertMessage = "Please correct the following issues:\n\n" + errors.joined(separator: "\n")
            showingAlert = true
        }
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaListView: View {
    @EnvironmentObject var dataManager: GameDataManager
    @State private var searchText = ""

    var filteredGames: [AssassinsCreedValhalla] {
        if searchText.isEmpty {
            return dataManager.valhallaGames
        } else {
            return dataManager.valhallaGames.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.playableCharacter.localizedCaseInsensitiveContains(searchText) ||
                $0.clanName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        ZStack {
            Color.init(red: 0.15, green: 0.15, blue: 0.2)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                AssassinsCreedValhallaSearchBarView(searchText: $searchText)
                    .padding(.vertical, 8)
                
                if filteredGames.isEmpty {
                    AssassinsCreedValhallaNoDataView()
                        .padding(.top, 50)
                    Spacer()
                } else {
                    List {
                        ForEach(filteredGames) { game in
                            ZStack {
                                NavigationLink(destination: AssassinsCreedValhallaDetailView(game: game)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                AssassinsCreedValhallaListRowView(game: game)
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                            
                        }
                        .onDelete(perform: deleteGame)
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .navigationTitle("Valhalla")
        .navigationBarItems(trailing:
                                NavigationLink(destination: AssassinsCreedValhallaAddView().environmentObject(dataManager)) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.yellow)
                .font(.title)
        }
        )
        
    }

    func deleteGame(at offsets: IndexSet) {
        for index in offsets {
            let gameToDelete = filteredGames[index]
            dataManager.deleteValhalla(gameToDelete)
        }
    }
}

@available(iOS 14.0, *)
struct AssassinsCreedValhallaDetailView: View {
    var game: AssassinsCreedValhalla

    var body: some View {
        ZStack {
            Color.init(red: 0.1, green: 0.1, blue: 0.15)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    if let uiImage = UIImage(data: game.image) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            .clipped()
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.clear, Color.init(red: 0.1, green: 0.1, blue: 0.15).opacity(0.8)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    } else {
                        Image("valalah")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 280)
                            .cornerRadius(8)
                            .clipped()
                            .shadow(color: Color.red.opacity(0.7), radius: 5)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(game.name)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.yellow)
                        Text("Saga of \(game.playableCharacter) (\(game.clanName))")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    
                    AssassinsCreedValhallaDetailHeader(title: "⚔️ Core Saga Stats")
                        .padding(.horizontal)

                    VStack(spacing: 10) {
                        VStack(spacing: 15) {
                            AssassinsCreedValhallaDetailFieldRow(label: "Playable Character", value: game.playableCharacter, icon: "person.fill")
                            AssassinsCreedValhallaDetailFieldRow(label: "Gender Choice", value: game.genderChoiceAvailable ? "Yes" : "No", icon: "person.2.fill")
                            AssassinsCreedValhallaDetailFieldRow(label: "Clan Name", value: game.clanName, icon: "shield.righthalf.filled")
                            AssassinsCreedValhallaDetailFieldRow(label: "Combat Style", value: game.combatStyle, icon: "figure.strengthtraining.functional")
                            AssassinsCreedValhallaDetailFieldRow(label: "Exploration Focus", value: game.explorationFocus, icon: "scope")
                            AssassinsCreedValhallaDetailFieldRow(label: "Dialogue Choices", value: game.dialogueChoices ? "Impactful" : "Limited", icon: "text.bubble.fill")
                            AssassinsCreedValhallaDetailFieldRow(label: "Settlement Customization", value: game.settlementCustomization ? "Yes" : "No", icon: "house.fill")
                            AssassinsCreedValhallaDetailFieldRow(label: "Hidden Blades", value: game.hiddenBlades ? "Classic" : "No", icon: "scissors")
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(spacing: 15) {
                            AssassinsCreedValhallaDetailFieldRow(label: "Story Chapters", value: "\(game.mainStoryChapters)", icon: "book.fill")
                            AssassinsCreedValhallaDetailFieldRow(label: "Raids Available", value: "\(game.raidsAvailable)", icon: "figure.walk.motion")
                            AssassinsCreedValhallaDetailFieldRow(label: "Sync Points", value: "\(game.synchronizationPoints)", icon: "square.grid.3x3.fill")
                            AssassinsCreedValhallaDetailFieldRow(label: "Stealth Mechanics", value: game.stealthMechanics, icon: "eye.slash.fill")
                            AssassinsCreedValhallaDetailFieldRow(label: "Weather System", value: game.weatherSystem ? "Dynamic" : "No", icon: "cloud.rain.fill")
                            AssassinsCreedValhallaDetailFieldRow(label: "Day/Night Cycle", value: game.dayNightCycle ? "Active" : "No", icon: "moon.stars.fill")
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(15)
                    .padding(.horizontal)

                    AssassinsCreedValhallaDetailHeader(title: "🗺️ World & Content")
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        AssassinsCreedValhallaDetailFieldRow(label: "Open World Regions", value: game.openWorldRegions.joined(separator: ", "), icon: "globe.europe.africa.fill")
                        AssassinsCreedValhallaDetailFieldRow(label: "Mythological Realms", value: game.mythologicalRealms.joined(separator: ", "), icon: "mountain.2.fill")
                        AssassinsCreedValhallaDetailFieldRow(label: "Companions", value: game.companions.joined(separator: ", "), icon: "person.3.fill")
                        AssassinsCreedValhallaDetailFieldRow(label: "Historical Figures", value: game.historicalFigures.joined(separator: ", "), icon: "person.text.rectangle.fill")
                        AssassinsCreedValhallaDetailFieldRow(label: "Mini Games", value: game.miniGames.joined(separator: ", "), icon: "dice.fill")
                        AssassinsCreedValhallaDetailFieldRow(label: "Collectibles", value: game.collectibles.joined(separator: ", "), icon: "diamond.fill")
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(15)
                    .padding(.horizontal)


                    AssassinsCreedValhallaDetailHeader(title: "🛡️ Gear & Foes")
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        AssassinsCreedValhallaDetailFieldRow(label: "Weapon Types", value: game.weaponTypes.joined(separator: ", "), icon: "goforward.10")
                        AssassinsCreedValhallaDetailFieldRow(label: "Armor Sets", value: game.armorSets.joined(separator: ", "), icon: "tshirt.fill")
                        AssassinsCreedValhallaDetailFieldRow(label: "Mounts Available", value: game.mountsAvailable.joined(separator: ", "), icon: "pawprint.fill")
                        AssassinsCreedValhallaDetailFieldRow(label: "Skill Tree Abilities", value: game.skillTreeAbilities.joined(separator: ", "), icon: "sparkles")
                        AssassinsCreedValhallaDetailFieldRow(label: "Enemy Types", value: game.enemyTypes.joined(separator: ", "), icon: "figure.martial.arts")
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                }
            }
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
