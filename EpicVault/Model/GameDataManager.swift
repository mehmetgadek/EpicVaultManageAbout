
import SwiftUI

struct GrandTheftAutoV: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var mainCharacters: [String]
    var storylineSummary: String
    var cityName: String
    var mapArea: String
    var availableVehicles: [String]
    var availableWeapons: [String]
    var propertyPurchases: Bool
    var policeWantedLevels: Int
    var safeHouses: Int
    var heistsAvailable: Int
    var playableAreas: [String]
    var moneySystem: String
    var customizationOptions: [String]
    var onlineModeSupported: Bool
    var gangFactions: [String]
    var miniGames: [String]
    var specialAbilities: [String]
    var missionsCompleted: Int
    var collectibles: [String]
    var interactionLevel: String
    var radioStations: [String]
    var dayNightCycle: Bool
    var weatherSystem: Bool
    var vehicleModifications: Bool
    var lawEnforcementPresence: String
    var populationDensity: String
    var image: Data
}

struct AssassinsCreedValhalla: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var playableCharacter: String
    var genderChoiceAvailable: Bool
    var clanName: String
    var mainStoryChapters: Int
    var openWorldRegions: [String]
    var settlementCustomization: Bool
    var raidsAvailable: Int
    var enemyTypes: [String]
    var skillTreeAbilities: [String]
    var stealthMechanics: String
    var combatStyle: String
    var weaponTypes: [String]
    var armorSets: [String]
    var mountsAvailable: [String]
    var companions: [String]
    var mythologicalRealms: [String]
    var dialogueChoices: Bool
    var historicalFigures: [String]
    var explorationFocus: String
    var collectibles: [String]
    var miniGames: [String]
    var synchronizationPoints: Int
    var weatherSystem: Bool
    var dayNightCycle: Bool
    var hiddenBlades: Bool
    var image: Data
}

struct RedDeadRedemption2: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var mainCharacter: String
    var gangName: String
    var horsesAvailable: [String]
    var huntingAnimals: [String]
    var openWorldRegions: [String]
    var weaponVariety: [String]
    var honorSystem: String
    var bounties: Bool
    var trainRobberies: Bool
    var sideMissions: Int
    var fishingSystem: Bool
    var towns: [String]
    var wildlifeCount: Int
    var campUpgrades: Bool
    var foodItems: [String]
    var companions: [String]
    var lawEnforcement: Bool
    var moneySystem: String
    var interactionDepth: String
    var craftingSystem: Bool
    var horseBonding: Bool
    var cinematicMode: Bool
    var weatherSystem: Bool
    var dynamicEvents: Bool
    var huntingMechanics: String
    var image: Data
}

struct ZeldaBreathOfTheWild: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var heroName: String
    var worldRegions: [String]
    var shrinesCount: Int
    var korokSeeds: Int
    var staminaLevels: Int
    var healthLevels: Int
    var weaponsDurability: Bool
    var foodRecipes: [String]
    var craftingSystem: Bool
    var fastTravelPoints: Int
    var divineBeasts: [String]
    var elementalEnemies: [String]
    var paragliderAvailable: Bool
    var armorSets: [String]
    var weaponTypes: [String]
    var mounts: [String]
    var climateZones: [String]
    var stealthMechanics: String
    var enemyCamps: Int
    var dayNightCycle: Bool
    var weatherEffects: Bool
    var puzzles: [String]
    var bossBattles: [String]
    var explorationFreedom: String
    var worldSize: String
    var image: Data
}

struct GodOfWarRagnarok: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var mainCharacter: String
    var companionCharacter: String
    var realmsVisited: [String]
    var weaponTypes: [String]
    var shieldTypes: [String]
    var armorSets: [String]
    var skillTreeAbilities: [String]
    var enemiesFaced: [String]
    var bossesDefeated: [String]
    var sideQuests: Int
    var collectibles: [String]
    var puzzles: [String]
    var explorationAreas: [String]
    var cameraStyle: String
    var combatSystem: String
    var specialMoves: [String]
    var magicRunes: [String]
    var craftingUpgrades: Bool
    var dialogueChoices: Bool
    var cinematicMoments: Bool
    var fastTravelPoints: Int
    var worldScale: String
    var healthUpgrades: Int
    var rageMode: Bool
    var mythologicalCreatures: [String]
    var image: Data
}

class GameDataManager: ObservableObject {
    @Published var gtaGames: [GrandTheftAutoV] = []
    @Published var valhallaGames: [AssassinsCreedValhalla] = []
    @Published var rdr2Games: [RedDeadRedemption2] = []
    @Published var zeldaGames: [ZeldaBreathOfTheWild] = []
    @Published var gowGames: [GodOfWarRagnarok] = []
    
    private let gtaKey = "GTA_GAMES"
    private let valhallaKey = "VALHALLA_GAMES"
    private let rdr2Key = "RDR2_GAMES"
    private let zeldaKey = "ZELDA_GAMES"
    private let gowKey = "GOW_GAMES"
    
    init() {
        loadAllData()
    }
    
    func addGTA(_ game: GrandTheftAutoV) {
        gtaGames.append(game)
        saveData(gtaGames, key: gtaKey)
    }
    
    func addValhalla(_ game: AssassinsCreedValhalla) {
        valhallaGames.append(game)
        saveData(valhallaGames, key: valhallaKey)
    }
    
    func addRDR2(_ game: RedDeadRedemption2) {
        rdr2Games.append(game)
        saveData(rdr2Games, key: rdr2Key)
    }
    
    func addZelda(_ game: ZeldaBreathOfTheWild) {
        zeldaGames.append(game)
        saveData(zeldaGames, key: zeldaKey)
    }
    
    func addGOW(_ game: GodOfWarRagnarok) {
        gowGames.append(game)
        saveData(gowGames, key: gowKey)
    }
    
    func deleteGTA(_ game: GrandTheftAutoV) {
        gtaGames.removeAll { $0.id == game.id }
        saveData(gtaGames, key: gtaKey)
    }
    
    func deleteValhalla(_ game: AssassinsCreedValhalla) {
        valhallaGames.removeAll { $0.id == game.id }
        saveData(valhallaGames, key: valhallaKey)
    }
    
    func deleteRDR2(_ game: RedDeadRedemption2) {
        rdr2Games.removeAll { $0.id == game.id }
        saveData(rdr2Games, key: rdr2Key)
    }
    
    func deleteZelda(_ game: ZeldaBreathOfTheWild) {
        zeldaGames.removeAll { $0.id == game.id }
        saveData(zeldaGames, key: zeldaKey)
    }
    
    func deleteGOW(_ game: GodOfWarRagnarok) {
        gowGames.removeAll { $0.id == game.id }
        saveData(gowGames, key: gowKey)
    }
    
    private func saveData<T: Codable>(_ data: [T], key: String) {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func loadData<T: Codable>(key: String, type: T.Type) -> [T] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([T].self, from: data) {
            return decoded
        }
        return []
    }
    
    private func loadAllData() {
        gtaGames = loadData(key: gtaKey, type: GrandTheftAutoV.self)
        valhallaGames = loadData(key: valhallaKey, type: AssassinsCreedValhalla.self)
        rdr2Games = loadData(key: rdr2Key, type: RedDeadRedemption2.self)
        zeldaGames = loadData(key: zeldaKey, type: ZeldaBreathOfTheWild.self)
        gowGames = loadData(key: gowKey, type: GodOfWarRagnarok.self)
    }
    
    func loadDummyData() {
        if let sampleImage = UIImage(systemName: "gamecontroller")?.pngData() {
            let gta = GrandTheftAutoV(name: "Grand Theft Auto V", mainCharacters: ["Michael", "Franklin", "Trevor"], storylineSummary: "Three criminals navigate Los Santos while planning major heists.", cityName: "Los Santos", mapArea: "75 sq km", availableVehicles: ["Cars", "Bikes", "Planes"], availableWeapons: ["Pistol", "Shotgun", "Sniper Rifle"], propertyPurchases: true, policeWantedLevels: 5, safeHouses: 8, heistsAvailable: 6, playableAreas: ["City", "Desert", "Mountains"], moneySystem: "Cash-based economy", customizationOptions: ["Clothing", "Cars", "Weapons"], onlineModeSupported: true, gangFactions: ["Families", "Ballers"], miniGames: ["Tennis", "Golf", "Yoga"], specialAbilities: ["Bullet Time", "Rage", "Stealth"], missionsCompleted: 80, collectibles: ["Spaceship Parts", "Hidden Packages"], interactionLevel: "High", radioStations: ["Non Stop Pop", "Los Santos Rock Radio"], dayNightCycle: true, weatherSystem: true, vehicleModifications: true, lawEnforcementPresence: "Dynamic", populationDensity: "Dense", image: sampleImage)
            
            let valhalla = AssassinsCreedValhalla(name: "Assassin’s Creed: Valhalla", playableCharacter: "Eivor", genderChoiceAvailable: true, clanName: "Raven Clan", mainStoryChapters: 13, openWorldRegions: ["England", "Norway"], settlementCustomization: true, raidsAvailable: 20, enemyTypes: ["Saxons", "Templars"], skillTreeAbilities: ["Stealth", "Melee", "Ranged"], stealthMechanics: "Advanced system", combatStyle: "Dual-wielding", weaponTypes: ["Axe", "Bow", "Sword"], armorSets: ["Bear", "Wolf", "Raven"], mountsAvailable: ["Horse", "Wolf"], companions: ["Sigurd", "Randvi"], mythologicalRealms: ["Asgard", "Jotunheim"], dialogueChoices: true, historicalFigures: ["King Alfred"], explorationFocus: "High", collectibles: ["Opals", "Artifacts"], miniGames: ["Orlog", "Drinking Contest"], synchronizationPoints: 60, weatherSystem: true, dayNightCycle: true, hiddenBlades: true, image: sampleImage)
            
            let rdr2 = RedDeadRedemption2(name: "Red Dead Redemption 2", mainCharacter: "Arthur Morgan", gangName: "Van der Linde Gang", horsesAvailable: ["Arabian", "Turkoman"], huntingAnimals: ["Deer", "Bear", "Wolf"], openWorldRegions: ["New Hanover", "Lemoyne", "Ambarino"], weaponVariety: ["Revolver", "Repeater", "Bow"], honorSystem: "Dynamic moral choice", bounties: true, trainRobberies: true, sideMissions: 50, fishingSystem: true, towns: ["Valentine", "Saint Denis"], wildlifeCount: 200, campUpgrades: true, foodItems: ["Steak", "Beans"], companions: ["Dutch", "John", "Sadie"], lawEnforcement: true, moneySystem: "Cash", interactionDepth: "Realistic", craftingSystem: true, horseBonding: true, cinematicMode: true, weatherSystem: true, dynamicEvents: true, huntingMechanics: "Tracking and skinning", image: sampleImage)
            
            let zelda = ZeldaBreathOfTheWild(name: "The Legend of Zelda: Breath of the Wild", heroName: "Link", worldRegions: ["Hyrule Field", "Gerudo Desert"], shrinesCount: 120, korokSeeds: 900, staminaLevels: 3, healthLevels: 30, weaponsDurability: true, foodRecipes: ["Mushroom Skewer", "Spicy Meat"], craftingSystem: true, fastTravelPoints: 80, divineBeasts: ["Vah Ruta", "Vah Naboris"], elementalEnemies: ["Fire Wizzrobe", "Ice Moblin"], paragliderAvailable: true, armorSets: ["Climbing Gear", "Stealth Armor"], weaponTypes: ["Sword", "Bow", "Spear"], mounts: ["Horse", "Deer"], climateZones: ["Desert", "Tundra"], stealthMechanics: "Light-based visibility", enemyCamps: 150, dayNightCycle: true, weatherEffects: true, puzzles: ["Shrine Challenges"], bossBattles: ["Calamity Ganon"], explorationFreedom: "Unlimited", worldSize: "Massive", image: sampleImage)
            
            let gow = GodOfWarRagnarok(name: "God of War: Ragnarök", mainCharacter: "Kratos", companionCharacter: "Atreus", realmsVisited: ["Midgard", "Asgard", "Vanaheim"], weaponTypes: ["Leviathan Axe", "Blades of Chaos"], shieldTypes: ["Guardian Shield"], armorSets: ["Spartan Rage", "Berserker Armor"], skillTreeAbilities: ["Frost Strike", "Wrath of the Frost"], enemiesFaced: ["Draugr", "Odin’s Ravens"], bossesDefeated: ["Thor", "Odin"], sideQuests: 40, collectibles: ["Artifacts", "Lore Scrolls"], puzzles: ["Rune Locks", "Light Bridges"], explorationAreas: ["Frozen Lake", "Dwarven Mines"], cameraStyle: "One-shot cinematic", combatSystem: "Action Combo", specialMoves: ["Spartan Rage"], magicRunes: ["Frost", "Fire"], craftingUpgrades: true, dialogueChoices: false, cinematicMoments: true, fastTravelPoints: 25, worldScale: "Large", healthUpgrades: 10, rageMode: true, mythologicalCreatures: ["Fenrir", "Jörmungandr"], image: sampleImage)
            
            gtaGames = [gta]
            valhallaGames = [valhalla]
            rdr2Games = [rdr2]
            zeldaGames = [zelda]
            gowGames = [gow]
            saveData(gtaGames, key: gtaKey)
            saveData(valhallaGames, key: valhallaKey)
            saveData(rdr2Games, key: rdr2Key)
            saveData(zeldaGames, key: zeldaKey)
            saveData(gowGames, key: gowKey)
        }
    }
}
