
import SwiftUI
import PhotosUI

@available(iOS 14.0, *)
struct RDR2FloatingLabelTextField: View {
    @Binding var text: String
    var placeholder: String
    var iconName: String

    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeholder)
                .foregroundColor(text.isEmpty ? Color.gray : Color.orange)
                .offset(y: -25)
                .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
                .padding(.vertical,10)

            HStack {
                Image(systemName: iconName)
                    .foregroundColor(Color(hex: "964B00"))
                TextField("", text: $text)
                    .foregroundColor(.white)
            }
        }
        .padding(.top, 15)
        .padding(.horizontal)
        .padding(.bottom, 8)
        .background(Color.black.opacity(0.5))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(text.isEmpty ? Color(hex: "964B00") : Color.orange, lineWidth: 1)
        )
    }
}

@available(iOS 14.0, *)
struct RDR2AddSectionHeaderView: View {
    var title: String
    var iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.red)
                .font(.headline)
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "964B00").opacity(0.8))
        .cornerRadius(5)
        .padding(.top, 20)
    }
}

@available(iOS 14.0, *)
struct RDR2ToggleFieldView: View {
    var title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isOn ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(isOn ? .green : .red)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .accentColor(.red)
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "964B00"), lineWidth: 1)
        )
    }
}

@available(iOS 14.0, *)
struct RDR2StepperFieldView: View {
    var title: String
    @Binding var value: Int
    
    var body: some View {
        HStack {
            Image(systemName: "number.circle.fill")
                .foregroundColor(.yellow)
            Text("\(title): **\(value)**")
                .foregroundColor(.white)
            Spacer()
            Stepper("", value: $value, in: 0...500)
                .labelsHidden()
                .background(Color.clear)
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "964B00"), lineWidth: 1)
        )
    }
}

@available(iOS 14.0, *)
struct RDR2ImagePickerView: View {
    let imageData: Data
    
    var body: some View {
        if let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: "photo.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
        }
    }
}

@available(iOS 14.0, *)
struct RDR2AddView: View {
    @EnvironmentObject var dataManager: GameDataManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var mainCharacter: String = ""
    @State private var gangName: String = ""
    @State private var horsesAvailable: String = ""
    @State private var huntingAnimals: String = ""
    @State private var openWorldRegions: String = ""
    @State private var weaponVariety: String = ""
    @State private var honorSystem: String = ""
    @State private var bounties: Bool = true
    @State private var trainRobberies: Bool = true
    @State private var sideMissions: Int = 0
    @State private var fishingSystem: Bool = true
    @State private var towns: String = ""
    @State private var wildlifeCount: Int = 0
    @State private var campUpgrades: Bool = true
    @State private var foodItems: String = ""
    @State private var companions: String = ""
    @State private var lawEnforcement: Bool = true
    @State private var moneySystem: String = ""
    @State private var interactionDepth: String = ""
    @State private var craftingSystem: Bool = true
    @State private var horseBonding: Bool = true
    @State private var cinematicMode: Bool = true
    @State private var weatherSystem: Bool = true
    @State private var dynamicEvents: Bool = true
    @State private var huntingMechanics: String = ""
    @State private var inputImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private func arrayString(from text: String) -> [String] {
        text.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
    }
    
    private func validateAndSave() {
        var errors: [String] = []
        if name.trimmingCharacters(in: .whitespaces).isEmpty { errors.append("Name is required.") }
        if mainCharacter.trimmingCharacters(in: .whitespaces).isEmpty { errors.append("Main Character is required.") }
        if gangName.trimmingCharacters(in: .whitespaces).isEmpty { errors.append("Gang Name is required.") }
        if honorSystem.trimmingCharacters(in: .whitespaces).isEmpty { errors.append("Honor System is required.") }
        if moneySystem.trimmingCharacters(in: .whitespaces).isEmpty { errors.append("Money System is required.") }
        if huntingMechanics.trimmingCharacters(in: .whitespaces).isEmpty { errors.append("Hunting Mechanics is required.") }
        if interactionDepth.trimmingCharacters(in: .whitespaces).isEmpty { errors.append("Interaction Depth is required.") }
        if horsesAvailable.trimmingCharacters(in: .whitespaces).isEmpty { errors.append("Horses Available are required.") }
        
        if errors.isEmpty {
            guard let imageData = inputImage?.pngData() else {
                errors.append("Could not convert image to data.")
                alertMessage = "Validation Errors: \n" + errors.joined(separator: "\n")
                showAlert = true
                return
            }
            let newGame = RedDeadRedemption2(
                name: name,
                mainCharacter: mainCharacter,
                gangName: gangName,
                horsesAvailable: arrayString(from: horsesAvailable),
                huntingAnimals: arrayString(from: huntingAnimals),
                openWorldRegions: arrayString(from: openWorldRegions),
                weaponVariety: arrayString(from: weaponVariety),
                honorSystem: honorSystem,
                bounties: bounties,
                trainRobberies: trainRobberies,
                sideMissions: sideMissions,
                fishingSystem: fishingSystem,
                towns: arrayString(from: towns),
                wildlifeCount: wildlifeCount,
                campUpgrades: campUpgrades,
                foodItems: arrayString(from: foodItems),
                companions: arrayString(from: companions),
                lawEnforcement: lawEnforcement,
                moneySystem: moneySystem,
                interactionDepth: interactionDepth,
                craftingSystem: craftingSystem,
                horseBonding: horseBonding,
                cinematicMode: cinematicMode,
                weatherSystem: weatherSystem,
                dynamicEvents: dynamicEvents,
                huntingMechanics: huntingMechanics,
                image: imageData
            )
            dataManager.addRDR2(newGame)
            alertMessage = "✅ Success!\n'\(name)' has been added to your collection."
        } else {
            alertMessage = "❌ Validation Failed:\n" + errors.joined(separator: "\n")
        }
        showAlert = true
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                RDR2AddSectionHeaderView(title: "Media & Core Info", iconName: "person.3.fill")
                    .padding(.horizontal)

                VStack(spacing: 15) {
                    VStack {
                        if let image = inputImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 180)
                                .cornerRadius(12)
                                .onTapGesture { isShowingImagePicker = true }
                        }
                        Button(action: { isShowingImagePicker = true }) {
                            Label("Select Image", systemImage: "photo.on.rectangle.angled")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical, 10)
                    
                    RDR2FloatingLabelTextField(text: $name, placeholder: "Game Name", iconName: "tag.fill")
                    RDR2FloatingLabelTextField(text: $mainCharacter, placeholder: "Main Character", iconName: "person.fill")
                    RDR2FloatingLabelTextField(text: $gangName, placeholder: "Gang Name", iconName: "flag.fill")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                RDR2AddSectionHeaderView(title: "World & Economy", iconName: "map.fill")
                    .padding(.horizontal)

                VStack(spacing: 15) {
                    RDR2FloatingLabelTextField(text: $openWorldRegions, placeholder: "Regions (comma separated)", iconName: "map")
                    RDR2FloatingLabelTextField(text: $towns, placeholder: "Towns (comma separated)", iconName: "house.fill")
                    RDR2FloatingLabelTextField(text: $moneySystem, placeholder: "Money System", iconName: "dollarsign.circle.fill")
                    RDR2FloatingLabelTextField(text: $honorSystem, placeholder: "Honor System", iconName: "goforward.10")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

                RDR2AddSectionHeaderView(title: "Gameplay Mechanics", iconName: "hammer.fill")
                    .padding(.horizontal)

                VStack(spacing: 15) {
                    RDR2FloatingLabelTextField(text: $weaponVariety, placeholder: "Weapons (comma separated)", iconName: "flame.fill")
                    RDR2FloatingLabelTextField(text: $huntingMechanics, placeholder: "Hunting Mechanics", iconName: "scope")
                    RDR2FloatingLabelTextField(text: $interactionDepth, placeholder: "Interaction Depth", iconName: "hand.tap.fill")
                    
                    RDR2ToggleFieldView(title: "Crafting System", isOn: $craftingSystem)
                    RDR2ToggleFieldView(title: "Fishing System", isOn: $fishingSystem)
                    RDR2ToggleFieldView(title: "Horse Bonding", isOn: $horseBonding)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                RDR2AddSectionHeaderView(title: "Animals & Companions", iconName: "pawprint.fill")
                    .padding(.horizontal)

                VStack(spacing: 15) {
                    RDR2FloatingLabelTextField(text: $horsesAvailable, placeholder: "Horses (comma separated)", iconName: "mustache.fill")
                    RDR2FloatingLabelTextField(text: $huntingAnimals, placeholder: "Hunting Animals (comma separated)", iconName: "leaf.fill")
                    RDR2StepperFieldView(title: "Wildlife Count", value: $wildlifeCount)
                    RDR2FloatingLabelTextField(text: $companions, placeholder: "Companions (comma separated)", iconName: "person.2.fill")
                    RDR2FloatingLabelTextField(text: $foodItems, placeholder: "Food Items (comma separated)", iconName: "takeoutbag.and.cup.and.straw.fill")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

                RDR2AddSectionHeaderView(title: "Activities & Environment", iconName: "bag.fill")
                    .padding(.horizontal)

                VStack(spacing: 15) {
                    RDR2StepperFieldView(title: "Side Missions Count", value: $sideMissions)
                    RDR2ToggleFieldView(title: "Bounties Available", isOn: $bounties)
                    RDR2ToggleFieldView(title: "Train Robberies", isOn: $trainRobberies)
                    RDR2ToggleFieldView(title: "Camp Upgrades", isOn: $campUpgrades)
                    RDR2ToggleFieldView(title: "Law Enforcement", isOn: $lawEnforcement)
                    RDR2ToggleFieldView(title: "Cinematic Mode", isOn: $cinematicMode)
                    RDR2ToggleFieldView(title: "Weather System", isOn: $weatherSystem)
                    RDR2ToggleFieldView(title: "Dynamic Events", isOn: $dynamicEvents)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Button(action: validateAndSave) {
                    Text("SAVE OUTLAW RECORD")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(12)
                        .shadow(color: .red, radius: 5)
                }
                .padding(.horizontal)
                .padding(.top, 30)
                .padding(.bottom, 50)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertMessage.contains("✅") ? "Success" : "Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if alertMessage.contains("✅") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
        .sheet(isPresented: $isShowingImagePicker) {
            GrandTheftAutoVImagePicker(image: $inputImage)
        }
    }
}

@available(iOS 14.0, *)
struct RDR2SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.yellow)
            
            TextField("Search Outlaw Records...", text: $searchText)
                .padding(.vertical, 8)
                .foregroundColor(.white)
                .background(Color.clear)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .background(Color(hex: "964B00").opacity(0.5))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.yellow, lineWidth: 1)
        )
        .padding(.horizontal)
        .padding(.top, 5)
        .animation(.default, value: searchText.isEmpty)
    }
}

@available(iOS 14.0, *)
struct RDR2FeaturePill: View {
    var title: String
    var value: String
    var icon: String
    
    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .font(.caption2)
            Text(title)
                .font(.caption2)
                .foregroundColor(.gray)
            Text(value)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 8)
        .background(Color(hex: "964B00").opacity(0.4))
        .cornerRadius(8)
    }
}

@available(iOS 14.0, *)
struct RDR2ListRowView: View {
    var game: RedDeadRedemption2
    
    private func arrayToString(_ array: [String], limit: Int) -> String {
        let firstFew = array.prefix(limit)
        return firstFew.joined(separator: ", ") + (array.count > limit ? "..." : "")
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
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
                    Image("rdr")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 230)
                        .cornerRadius(8)
                        .clipped()
                        .shadow(color: Color.red.opacity(0.7), radius: 5)
                }
                
                Text(game.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                
                HStack {
                    Text("Outlaw: \(game.mainCharacter)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Spacer()
                    Text("Gang: \(game.gangName)")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
                
                Divider().background(Color.gray)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Regions: \(arrayToString(game.openWorldRegions, limit: 2))")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("Weapons: \(arrayToString(game.weaponVariety, limit: 3))")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("Horses: \(arrayToString(game.horsesAvailable, limit: 2))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 10) {
                    RDR2FeaturePill(title: "Honor", value: game.honorSystem.prefix(1).uppercased() + "...", icon: "goforward.10")
                    RDR2FeaturePill(title: "Wildlife", value: "\(game.wildlifeCount)", icon: "pawprint.fill")
                    RDR2FeaturePill(title: "Missions", value: "\(game.sideMissions)", icon: "list.number")
                    RDR2FeaturePill(title: "Bonding", value: game.horseBonding ? "Yes" : "No", icon: "mustache.fill")
                }
                .padding(.top, 5)
            }
        }
        .padding(15)
        .background(Color.black.opacity(0.7))
        .cornerRadius(15)
        .shadow(color: .red.opacity(0.5), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

@available(iOS 14.0, *)
struct RDR2NoDataView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "safari.fill")
                .font(.system(size: 80))
                .foregroundColor(.red)
                .shadow(color: .red.opacity(0.5), radius: 10)
            
            Text("The West is Empty...")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("No Red Dead Redemption 2 records found. Tap '+' to create a new outlaw record.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(15)
        .padding()
    }
}

@available(iOS 14.0, *)
struct RDR2ListView: View {
    @EnvironmentObject var dataManager: GameDataManager
    @State private var searchText = ""
    @State private var isShowingAddView = false
    
    var filteredGames: [RedDeadRedemption2] {
        if searchText.isEmpty {
            return dataManager.rdr2Games
        } else {
            return dataManager.rdr2Games.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.mainCharacter.localizedCaseInsensitiveContains(searchText) ||
                $0.gangName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        let gamesToDelete = offsets.map { filteredGames[$0] }
        for game in gamesToDelete {
            dataManager.deleteRDR2(game)
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                HStack {
                    Text("Red Dead Redemption")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        isShowingAddView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color.black)
                .shadow(color: .white.opacity(0.1), radius: 2, x: 0, y: 1)
                
                RDR2SearchBarView(searchText: $searchText)
                    .padding(.horizontal)
                    .padding(.top, 5)
                
                if filteredGames.isEmpty {
                    Spacer()
                    RDR2NoDataView()
                    Spacer()
                } else {
                    List {
                        ForEach(filteredGames, id: \.id) { game in
                            ZStack {
                                NavigationLink(destination: RDR2DetailView(game: game)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                RDR2ListRowView(game: game)
                            }
                            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .listRowBackground(Color.black)
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.black)
                }
            }
        }
        .sheet(isPresented: $isShowingAddView) {
            NavigationView {
                RDR2AddView()
                    .environmentObject(dataManager)
            }
        }
    }
}


@available(iOS 14.0, *)
struct RDR2DetailFieldRow: View {
    var label: String
    var value: String
    var iconName: String?
    
    var body: some View {
        HStack(alignment: .top) {
            if let icon = iconName {
                Image(systemName: icon)
                    .foregroundColor(.yellow)
                    .frame(width: 20)
            }
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 130, alignment: .leading)
            
            Text(value)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

@available(iOS 14.0, *)
struct RDR2DetailSection<Content: View>: View {
    var title: String
    var icon: String
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.red)
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .padding(.bottom, 5)
            
            VStack(spacing: 15) {
                content
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.black.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(hex: "964B00"), lineWidth: 2)
                    )
            )
        }
        .padding(.top, 10)
    }
}

@available(iOS 14.0, *)
struct RDR2DetailView: View {
    var game: RedDeadRedemption2
    
    private func arrayToString(_ array: [String]) -> String {
        array.joined(separator: ", ")
    }
    
    private func boolToStatus(_ value: Bool) -> String {
        value ? "Enabled" : "Disabled"
    }
    
    var body: some View {
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
                        Image("rdr")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 280)
                            .cornerRadius(8)
                            .clipped()
                            .shadow(color: Color.red.opacity(0.7), radius: 5)
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(game.name)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 5)
                    
                    Text("The Van der Linde Gang Chronicle")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Divider().background(Color.red)
                }
                .padding(.horizontal)
                
                RDR2DetailSection(title: "Character & Faction", icon: "person.3.fill") {
                    VStack(spacing: 15) {
                        RDR2DetailFieldRow(label: "Main Character", value: game.mainCharacter, iconName: "person.fill")
                        RDR2DetailFieldRow(label: "Gang Name", value: game.gangName, iconName: "flag.fill")
                        RDR2DetailFieldRow(label: "Companions", value: arrayToString(game.companions), iconName: "person.2.fill")
                        RDR2DetailFieldRow(label: "Camp Upgrades", value: boolToStatus(game.campUpgrades), iconName: "tent.fill")
                    }
                }
                
                RDR2DetailSection(title: "World & Terrain", icon: "map.fill") {
                    VStack(spacing: 15) {
                        RDR2DetailFieldRow(label: "Open World Regions", value: arrayToString(game.openWorldRegions), iconName: "globe")
                        RDR2DetailFieldRow(label: "Towns Visited", value: arrayToString(game.towns), iconName: "house.fill")
                        RDR2DetailFieldRow(label: "Wildlife Count", value: "\(game.wildlifeCount) Species", iconName: "pawprint.fill")
                        RDR2DetailFieldRow(label: "Weather System", value: boolToStatus(game.weatherSystem), iconName: "cloud.sun.fill")
                        RDR2DetailFieldRow(label: "Dynamic Events", value: boolToStatus(game.dynamicEvents), iconName: "sparkles")
                    }
                }
                
                RDR2DetailSection(title: "Mechanics & Systems", icon: "wrench.and.screwdriver.fill") {
                    VStack(spacing: 15) {
                        RDR2DetailFieldRow(label: "Honor System", value: game.honorSystem, iconName: "goforward.10")
                        RDR2DetailFieldRow(label: "Interaction Depth", value: game.interactionDepth, iconName: "hand.tap.fill")
                        RDR2DetailFieldRow(label: "Money System", value: game.moneySystem, iconName: "dollarsign.circle.fill")
                        
                        RDR2DetailFieldRow(label: "Crafting System", value: boolToStatus(game.craftingSystem), iconName: "hammer.fill")
                        RDR2DetailFieldRow(label: "Horse Bonding", value: boolToStatus(game.horseBonding), iconName: "mustache.fill")
                        RDR2DetailFieldRow(label: "Cinematic Mode", value: boolToStatus(game.cinematicMode), iconName: "film.fill")
                    }
                }
                
                RDR2DetailSection(title: "Activities & Law", icon: "flame.fill") {
                    VStack(spacing: 15) {
                        RDR2DetailFieldRow(label: "Side Missions Count", value: "\(game.sideMissions)", iconName: "list.number")
                        RDR2DetailFieldRow(label: "Bounties Available", value: boolToStatus(game.bounties), iconName: "person.fill.badge.plus")
                        RDR2DetailFieldRow(label: "Train Robberies", value: boolToStatus(game.trainRobberies), iconName: "train.side.front.car")
                        RDR2DetailFieldRow(label: "Law Enforcement", value: boolToStatus(game.lawEnforcement), iconName: "shield.lefthalf.fill")
                    }
                }
                
                RDR2DetailSection(title: "Equipment & Hunting", icon: "target") {
                    VStack(spacing: 15) {
                        RDR2DetailFieldRow(label: "Weapon Variety", value: arrayToString(game.weaponVariety), iconName: "lock.open.fill")
                        RDR2DetailFieldRow(label: "Horses Available", value: arrayToString(game.horsesAvailable), iconName: "lasso")
                        RDR2DetailFieldRow(label: "Hunting Animals", value: arrayToString(game.huntingAnimals), iconName: "leaf.fill")
                        RDR2DetailFieldRow(label: "Hunting Mechanics", value: game.huntingMechanics, iconName: "scope")
                        RDR2DetailFieldRow(label: "Fishing System", value: boolToStatus(game.fishingSystem), iconName: "drop.fill")
                        RDR2DetailFieldRow(label: "Food Items", value: arrayToString(game.foodItems), iconName: "takeoutbag.and.cup.and.straw.fill")
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 50)
        }
        .background(
            Color(hex: "964B00").opacity(0.1)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
