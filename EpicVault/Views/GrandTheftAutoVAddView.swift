
import SwiftUI
import UIKit

@available(iOS 14.0, *)
struct GrandTheftAutoVAddSectionHeaderView: View {
    let title: String
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title3)
                .foregroundColor(Color.red)
            Text(title)
                .font(.headline)
                .foregroundColor(Color.white)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 15)
        .background(Color.black.opacity(0.6))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.red.opacity(0.5), lineWidth: 1)
        )
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVAddFieldView<Content: View>: View {
    let label: String
    let iconName: String
    @Binding var text: String
    let content: Content
    
    init(label: String, iconName: String, text: Binding<String>, @ViewBuilder content: () -> Content) {
        self.label = label
        self.iconName = iconName
        self._text = text
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(Color.red)
                Text(label)
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.8))
            }
            content
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.red.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVAddToggleView: View {
    let label: String
    let iconName: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(Color.red)
            Text(label)
                .foregroundColor(Color.white)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: Color.red))
        }
        .padding(12)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.red.opacity(0.3), lineWidth: 1)
        )
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVAddStepperView: View {
    let label: String
    let iconName: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(Color.red)
            Text("\(label): **\(value)**")
                .foregroundColor(Color.white)
            Spacer()
            Stepper("", value: $value, in: range)
                .labelsHidden()
                .background(Color.white)
                .cornerRadius(5)
        }
        .padding(12)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.red.opacity(0.3), lineWidth: 1)
        )
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVDetailFieldRow: View {
    let label: String
    let value: String
    let iconName: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: iconName)
                        .foregroundColor(Color.red)
                    Text(label)
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.7))
                }
                Text(value)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            Spacer()
        }
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity)
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVStatPill: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption2)
                .foregroundColor(Color.red)
            Text("\(label): **\(value)**")
                .font(.caption2)
                .foregroundColor(Color.white)
            Spacer()
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 3)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.4))
        .cornerRadius(5)
        .frame(maxWidth: .infinity)
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVNoDataView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "questionmark.diamond.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(Color.red)
                .shadow(color: Color.red, radius: 5)
            
            Text("No Grand Theft Auto V Data Found")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
            Text("Looks like the streets of Los Santos are empty. Tap the '+' to add a new entry!")
                .font(.callout)
                .foregroundColor(Color.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(30)
        .background(Color.black.opacity(0.8))
        .cornerRadius(15)
        .padding()
    }
}

@available(iOS 14.0, *)
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 15) {
                    ForEach(0..<columns, id: \.self) { column in
                        self.content(row, column)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVAddView: View {

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataManager: GameDataManager
    
    @State private var name: String = ""
    @State private var mainCharacters: String = ""
    @State private var storylineSummary: String = ""
    @State private var cityName: String = ""
    @State private var mapArea: String = ""
    @State private var availableVehicles: String = ""
    @State private var availableWeapons: String = ""
    @State private var propertyPurchases: Bool = false
    @State private var policeWantedLevels: Int = 1
    @State private var safeHouses: Int = 1
    @State private var heistsAvailable: Int = 1
    @State private var playableAreas: String = ""
    @State private var moneySystem: String = ""
    @State private var customizationOptions: String = ""
    @State private var onlineModeSupported: Bool = false
    @State private var gangFactions: String = ""
    @State private var miniGames: String = ""
    @State private var specialAbilities: String = ""
    @State private var missionsCompleted: Int = 0
    @State private var collectibles: String = ""
    @State private var interactionLevel: String = ""
    @State private var radioStations: String = ""
    @State private var dayNightCycle: Bool = false
    @State private var weatherSystem: Bool = false
    @State private var vehicleModifications: Bool = false
    @State private var lawEnforcementPresence: String = ""
    @State private var populationDensity: String = ""
    
    @State private var inputImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private func arrayFromString(_ text: String) -> [String] {
        return text.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
    }
    
    private func validateAndSave() {
        var errors: [String] = []
        
        if name.isEmpty { errors.append("Name is required.") }
        if storylineSummary.isEmpty { errors.append("Storyline Summary is required.") }
        if cityName.isEmpty { errors.append("City Name is required.") }
        if mainCharacters.isEmpty { errors.append("Main Characters are required.") }
        if availableVehicles.isEmpty { errors.append("Available Vehicles are required.") }
        if availableWeapons.isEmpty { errors.append("Available Weapons are required.") }
        if moneySystem.isEmpty { errors.append("Money System is required.") }
        if playableAreas.isEmpty { errors.append("Playable Areas are required.") }
        if customizationOptions.isEmpty { errors.append("Customization Options are required.") }
        if gangFactions.isEmpty { errors.append("Gang Factions are required.") }
        if miniGames.isEmpty { errors.append("Mini-Games are required.") }
        if specialAbilities.isEmpty { errors.append("Special Abilities are required.") }
        if collectibles.isEmpty { errors.append("Collectibles are required.") }
        if interactionLevel.isEmpty { errors.append("Interaction Level is required.") }
        if radioStations.isEmpty { errors.append("Radio Stations are required.") }
        if lawEnforcementPresence.isEmpty { errors.append("Law Enforcement Presence is required.") }
        if populationDensity.isEmpty { errors.append("Population Density is required.") }
        if inputImage == nil { errors.append("Game image is required.") }
        
        if errors.isEmpty {
            guard let imageData = inputImage?.pngData() else {
                errors.append("Could not convert image to data.")
                alertMessage = "Validation Errors: \n" + errors.joined(separator: "\n")
                showAlert = true
                return
            }
            
            let newGame = GrandTheftAutoV(
                name: name,
                mainCharacters: arrayFromString(mainCharacters),
                storylineSummary: storylineSummary,
                cityName: cityName,
                mapArea: mapArea,
                availableVehicles: arrayFromString(availableVehicles),
                availableWeapons: arrayFromString(availableWeapons),
                propertyPurchases: propertyPurchases,
                policeWantedLevels: policeWantedLevels,
                safeHouses: safeHouses,
                heistsAvailable: heistsAvailable,
                playableAreas: arrayFromString(playableAreas),
                moneySystem: moneySystem,
                customizationOptions: arrayFromString(customizationOptions),
                onlineModeSupported: onlineModeSupported,
                gangFactions: arrayFromString(gangFactions),
                miniGames: arrayFromString(miniGames),
                specialAbilities: arrayFromString(specialAbilities),
                missionsCompleted: missionsCompleted,
                collectibles: arrayFromString(collectibles),
                interactionLevel: interactionLevel,
                radioStations: arrayFromString(radioStations),
                dayNightCycle: dayNightCycle,
                weatherSystem: weatherSystem,
                vehicleModifications: vehicleModifications,
                lawEnforcementPresence: lawEnforcementPresence,
                populationDensity: populationDensity,
                image: imageData
            )
            
            dataManager.addGTA(newGame)
            alertMessage = "Success: Grand Theft Auto V entry added! \n\nName: \(newGame.name)"
        } else {
            alertMessage = "Validation Errors: \n" + errors.joined(separator: "\n")
        }
        showAlert = true
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack {
                        GrandTheftAutoVAddSectionHeaderView(title: "Game Image", iconName: "photo.on.rectangle.fill")
                        
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            VStack {
                                if let image = inputImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                        .shadow(color: Color.red, radius: 5)
                                } else {
                                    Image(systemName: "photo.on.rectangle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(Color.red)
                                    Text("Tap to select a game image (Required)")
                                        .foregroundColor(Color.white.opacity(0.8))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    GrandTheftAutoVAddSectionHeaderView(title: "Core Game Information", iconName: "star.fill")
                    
                    VStack(spacing: 15) {
                        GrandTheftAutoVAddFieldView(label: "Name", iconName: "tag.fill", text: $name) {
                            TextField("Enter Game Title", text: $name)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "City Name", iconName: "building.2.fill", text: $cityName) {
                            TextField("e.g., Los Santos", text: $cityName)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Storyline Summary", iconName: "book.fill", text: $storylineSummary) {
                            TextEditor(text: $storylineSummary)
                                .frame(height: 100)
                                .foregroundColor(Color.white)
                                .background(Color.clear)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Main Characters (Comma-Sep)", iconName: "person.3.fill", text: $mainCharacters) {
                            TextField("e.g., Michael, Franklin, Trevor", text: $mainCharacters)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Map Area", iconName: "map.fill", text: $mapArea) {
                            TextField("e.g., 75 sq km", text: $mapArea)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    GrandTheftAutoVAddSectionHeaderView(title: "Mechanics & World Details", iconName: "gearshape.fill")
                    
                    VStack(spacing: 15) {
                        GrandTheftAutoVAddStepperView(label: "Wanted Levels", iconName: "shield.righthalf.fill", value: $policeWantedLevels, range: 1...6)
                        GrandTheftAutoVAddStepperView(label: "Heists Available", iconName: "banknote.fill", value: $heistsAvailable, range: 0...10)
                        
                        GrandTheftAutoVAddStepperView(label: "Safe Houses", iconName: "house.fill", value: $safeHouses, range: 1...20)
                        GrandTheftAutoVAddStepperView(label: "Missions Completed", iconName: "flag.checkered.2.crossed", value: $missionsCompleted, range: 1...200)
                        
                        
                        GrandTheftAutoVAddFieldView(label: "Money System", iconName: "dollarsign.circle.fill", text: $moneySystem) {
                            TextField("e.g., Cash-based economy", text: $moneySystem)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Law Enforcement Presence", iconName: "police.station.fill", text: $lawEnforcementPresence) {
                            TextField("e.g., Dynamic, Static", text: $lawEnforcementPresence)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Population Density", iconName: "person.2.fill", text: $populationDensity) {
                            TextField("e.g., Dense, Sparse", text: $populationDensity)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Interaction Level", iconName: "hand.tap.fill", text: $interactionLevel) {
                            TextField("e.g., High, Moderate", text: $interactionLevel)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Playable Areas (Comma-Sep)", iconName: "square.grid.3x3.square", text: $playableAreas) {
                            TextField("e.g., City, Desert, Mountains", text: $playableAreas)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    GrandTheftAutoVAddSectionHeaderView(title: "Items, Factions, & Abilities", iconName: "wrench.and.screwdriver.fill")
                    
                    VStack(spacing: 15) {
                        GrandTheftAutoVAddFieldView(label: "Available Vehicles (Comma-Sep)", iconName: "car.fill", text: $availableVehicles) {
                            TextField("e.g., Cars, Bikes, Planes", text: $availableVehicles)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Available Weapons (Comma-Sep)", iconName: "gun.fill", text: $availableWeapons) {
                            TextField("e.g., Pistol, Shotgun", text: $availableWeapons)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Customization Options (Comma-Sep)", iconName: "paintbrush.fill", text: $customizationOptions) {
                            TextField("e.g., Clothing, Cars, Weapons", text: $customizationOptions)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Gang Factions (Comma-Sep)", iconName: "figure.social.distancing", text: $gangFactions) {
                            TextField("e.g., Families, Ballers", text: $gangFactions)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Special Abilities (Comma-Sep)", iconName: "bolt.circle.fill", text: $specialAbilities) {
                            TextField("e.g., Bullet Time, Rage", text: $specialAbilities)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Collectibles (Comma-Sep)", iconName: "bag.fill", text: $collectibles) {
                            TextField("e.g., Spaceship Parts", text: $collectibles)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Mini-Games (Comma-Sep)", iconName: "puzzle.fill", text: $miniGames) {
                            TextField("e.g., Tennis, Golf, Yoga", text: $miniGames)
                                .foregroundColor(Color.white)
                        }
                        
                        GrandTheftAutoVAddFieldView(label: "Radio Stations (Comma-Sep)", iconName: "hifispeaker.2.fill", text: $radioStations) {
                            TextField("e.g., Non Stop Pop, Los Santos Rock Radio", text: $radioStations)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    GrandTheftAutoVAddSectionHeaderView(title: "Feature Toggles", iconName: "togglepower")
                    
                    VStack(spacing: 15) {
                        GrandTheftAutoVAddToggleView(label: "Property Purchases", iconName: "house.lodge.fill", isOn: $propertyPurchases)
                        GrandTheftAutoVAddToggleView(label: "Online Mode Supported", iconName: "globe", isOn: $onlineModeSupported)
                        GrandTheftAutoVAddToggleView(label: "Day/Night Cycle", iconName: "sun.max.fill", isOn: $dayNightCycle)
                        GrandTheftAutoVAddToggleView(label: "Weather System", iconName: "cloud.rain.fill", isOn: $weatherSystem)
                        GrandTheftAutoVAddToggleView(label: "Vehicle Modifications", iconName: "car.tools.fill", isOn: $vehicleModifications)
                    }
                    .padding(.horizontal)
                    
                    Button(action: validateAndSave) {
                        Text("SAVE GAME DATA")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(12)
                            .shadow(color: Color.red, radius: 10)
                    }
                    .padding([.horizontal, .bottom])
                }
                .padding(.top)
            }
            .navigationTitle("Add GTA V Entry")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingImagePicker) {
                GrandTheftAutoVImagePicker(image: $inputImage)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertMessage.contains("Success") ? "Operation Complete" : "Validation Failed"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if alertMessage.contains("Success") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                )
            }
        }
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVDetailView: View {
    let game: GrandTheftAutoV
    
    private func formattedArray(_ array: [String]) -> String {
        array.isEmpty ? "N/A" : array.joined(separator: ", ")
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    storylineSection
                    coreStatsSection
                    charactersSection
                    worldExtrasSection
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

@available(iOS 14.0, *)
private extension GrandTheftAutoVDetailView {
    
    var headerSection: some View {
        VStack(alignment: .center, spacing: 10) {
            if let uiImage = UIImage(data: game.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 230)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.red.opacity(0.7), radius: 5)
            } else {
                Image("grndtheft")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.red.opacity(0.7), radius: 5)
            }
            
            Text(game.name)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
            
            Text(game.cityName)
                .font(.headline)
                .foregroundColor(.red)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
    }
    
    var storylineSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Storyline Overview")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            Text(game.storylineSummary)
                .foregroundColor(.white.opacity(0.8))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(15)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
    
    var coreStatsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Core Stats")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            VStack(spacing: 10) {
                GrandTheftAutoVDetailFieldRow(label: "City", value: game.cityName, iconName: "building.fill")
                GrandTheftAutoVDetailFieldRow(label: "Map Area", value: game.mapArea, iconName: "map")
                GrandTheftAutoVDetailFieldRow(label: "Wanted Levels", value: "\(game.policeWantedLevels)", iconName: "shield.lefthalf.fill")
                GrandTheftAutoVDetailFieldRow(label: "Heists Available", value: "\(game.heistsAvailable)", iconName: "banknote")
                GrandTheftAutoVDetailFieldRow(label: "Safe Houses", value: "\(game.safeHouses)", iconName: "house")
                GrandTheftAutoVDetailFieldRow(label: "Missions Completed", value: "\(game.missionsCompleted)", iconName: "flag.checkered")
                GrandTheftAutoVDetailFieldRow(label: "Money System", value: game.moneySystem, iconName: "creditcard")
                GrandTheftAutoVDetailFieldRow(label: "Interaction Level", value: game.interactionLevel, iconName: "hand.raised.fill")
                GrandTheftAutoVDetailFieldRow(label: "Law Enforcement", value: game.lawEnforcementPresence, iconName: "person.badge.shield.fill")
                GrandTheftAutoVDetailFieldRow(label: "Population Density", value: game.populationDensity, iconName: "person.2.circle.fill")
            }
        }
        .padding(15)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
    
    var charactersSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Characters & Gear")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            GrandTheftAutoVDetailFieldRow(label: "Main Characters", value: formattedArray(game.mainCharacters), iconName: "person.3")
            GrandTheftAutoVDetailFieldRow(label: "Gang Factions", value: formattedArray(game.gangFactions), iconName: "figure.stand")
            GrandTheftAutoVDetailFieldRow(label: "Special Abilities", value: formattedArray(game.specialAbilities), iconName: "bolt")
            GrandTheftAutoVDetailFieldRow(label: "Available Weapons", value: formattedArray(game.availableWeapons), iconName: "goforward.lock")
            GrandTheftAutoVDetailFieldRow(label: "Available Vehicles", value: formattedArray(game.availableVehicles), iconName: "car")
            GrandTheftAutoVDetailFieldRow(label: "Customization Options", value: formattedArray(game.customizationOptions), iconName: "tshirt")
        }
        .padding(15)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
    
    var worldExtrasSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("World & Extras")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            VStack(spacing: 10) {
                GrandTheftAutoVDetailFieldRow(label: "Property Purchases", value: game.propertyPurchases ? "Yes" : "No", iconName: "dollarsign.square")
                GrandTheftAutoVDetailFieldRow(label: "Online Mode", value: game.onlineModeSupported ? "Supported" : "Not Supported", iconName: "network")
                GrandTheftAutoVDetailFieldRow(label: "Day/Night Cycle", value: game.dayNightCycle ? "Yes" : "No", iconName: "sun.max")
                GrandTheftAutoVDetailFieldRow(label: "Weather System", value: game.weatherSystem ? "Yes" : "No", iconName: "cloud.drizzle")
                GrandTheftAutoVDetailFieldRow(label: "Vehicle Mods", value: game.vehicleModifications ? "Yes" : "No", iconName: "wrench")
                GrandTheftAutoVDetailFieldRow(label: "Playable Areas", value: formattedArray(game.playableAreas), iconName: "map.pin.circle")
                GrandTheftAutoVDetailFieldRow(label: "Mini-Games", value: formattedArray(game.miniGames), iconName: "puzzle.fill")
                GrandTheftAutoVDetailFieldRow(label: "Collectibles", value: formattedArray(game.collectibles), iconName: "bag")
                GrandTheftAutoVDetailFieldRow(label: "Radio Stations", value: formattedArray(game.radioStations), iconName: "radio")
            }
        }
        .padding(15)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVSearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.red)
            TextField("Search Games...", text: $searchText)
                .foregroundColor(Color.white)
                .padding(.vertical, 8)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.red)
                }
            }
        }
        .padding(.horizontal, 10)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.red.opacity(0.5), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVListRowView: View {
    let game: GrandTheftAutoV
    
    private var gameImage: UIImage {
        UIImage(data: game.image) ?? UIImage(systemName: "gamecontroller.fill")!
    }
    
    private var darkOrange: Color {
        Color(red: 0.8, green: 0.4, blue: 0.0)
    }
    
    private var darkGreen: Color {
        Color(red: 0.0, green: 0.6, blue: 0.0)
    }
    
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
                
                Image("grndtheft")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.red.opacity(0.7), radius: 5)
                
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(game.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                    HStack {
                        Image(systemName: "map.fill")
                        Text(game.cityName)
                    }
                    .font(.subheadline)
                    .foregroundColor(Color.white.opacity(0.8))
                }
                Spacer()
                Image(systemName: game.onlineModeSupported ? "globe" : "person.crop.circle")
                    .font(.title)
                    .foregroundColor(game.onlineModeSupported ? Color.green : darkOrange)
            }
            
            Divider().background(Color.red.opacity(0.5))
            
            VStack(spacing: 5) {
                HStack {
                    GrandTheftAutoVStatPill(icon: "shield.righthalf.fill", label: "Wanted", value: "\(game.policeWantedLevels)")
                    GrandTheftAutoVStatPill(icon: "banknote.fill", label: "Heists", value: "\(game.heistsAvailable)")
                    GrandTheftAutoVStatPill(icon: "flag.checkered.2.crossed", label: "Missions", value: "\(game.missionsCompleted)")
                }
                HStack {
                    GrandTheftAutoVStatPill(icon: "car.fill", label: "Vehicles", value: "\(game.availableVehicles.count)")
                    GrandTheftAutoVStatPill(icon: "goforward.lock", label: "Weapons", value: "\(game.availableWeapons.count)")
                    GrandTheftAutoVStatPill(icon: "bolt.circle.fill", label: "Abilities", value: "\(game.specialAbilities.count)")
                }
                
                HStack {
                    GrandTheftAutoVStatPill(icon: "cloud.rain.fill", label: "Weather", value: game.weatherSystem ? "Yes" : "No")
                    GrandTheftAutoVStatPill(icon: "tshirt.fill", label: "Custom.", value: "\(game.customizationOptions.count)")
                    GrandTheftAutoVStatPill(icon: "person.3", label: "Characters", value: "\(game.mainCharacters.count)")
                }
                
                GrandTheftAutoVStatPill(icon: "sun.max.fill", label: "Day/Night", value: game.dayNightCycle ? "Yes" : "No")
                GrandTheftAutoVStatPill(icon: "house.fill", label: "Safe Houses", value: "\(game.safeHouses)")
                GrandTheftAutoVStatPill(icon: "dollarsign.circle.fill", label: "Money", value: game.moneySystem)
                
            }
            
            Text("Summary: \(game.storylineSummary)")
                .font(.caption)
                .italic()
                .foregroundColor(Color.white.opacity(0.6))
                .lineLimit(2)
                .padding(.top, 5)
            
        }
        .padding(15)
        .background(
            Color.gray.opacity(0.2)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color.red.opacity(0.4), radius: 5, x: 0, y: 5)
        )
    }
}

@available(iOS 14.0, *)
struct GrandTheftAutoVListView: View {
    @EnvironmentObject var dataManager: GameDataManager
    @State private var isShowingAddView = false
    @State private var searchText = ""
    
    var filteredGames: [GrandTheftAutoV] {
        if searchText.isEmpty {
            return dataManager.gtaGames
        } else {
            return dataManager.gtaGames.filter { game in
                game.name.localizedCaseInsensitiveContains(searchText) ||
                game.cityName.localizedCaseInsensitiveContains(searchText) ||
                game.mainCharacters.joined(separator: " ").localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack {
                    Text("Grand Theft Auto V Archive")
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
                
                GrandTheftAutoVSearchBarView(searchText: $searchText)
                    .padding(.horizontal)
                    .padding(.top, 5)
                
                if filteredGames.isEmpty && searchText.isEmpty {
                    Spacer()
                    GrandTheftAutoVNoDataView()
                    Spacer()
                } else if filteredGames.isEmpty {
                    Spacer()
                    Text("No results for '\(searchText)'")
                        .foregroundColor(Color.white.opacity(0.7))
                    Spacer()
                } else {
                    List {
                        ForEach(filteredGames) { game in
                            ZStack {
                                NavigationLink(destination: GrandTheftAutoVDetailView(game: game)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                GrandTheftAutoVListRowView(game: game)
                            }
                            .listRowInsets(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                            .listRowBackground(Color.black)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.black)
                }
            }
        }
        .sheet(isPresented: $isShowingAddView) {
            NavigationView {
                GrandTheftAutoVAddView()
                    .environmentObject(dataManager)
            }
            
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { filteredGames[$0] }.forEach(dataManager.deleteGTA)
        }
    }
}

