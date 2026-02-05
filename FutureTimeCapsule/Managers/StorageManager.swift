import Foundation

@Observable
final class StorageManager {
    static let shared = StorageManager()
    
    private let capsulesKey = "savedCapsules"
    var capsules: [FutureCapsule] = []
    
    private init() {
        loadCapsules()
    }
    
    func loadCapsules() {
        guard let data = UserDefaults.standard.data(forKey: capsulesKey),
              let decoded = try? JSONDecoder().decode([FutureCapsule].self, from: data) else {
            capsules = []
            return
        }
        capsules = decoded
    }
    
    func saveCapsules() {
        guard let encoded = try? JSONEncoder().encode(capsules) else { return }
        UserDefaults.standard.set(encoded, forKey: capsulesKey)
    }
    
    func addCapsule(_ capsule: FutureCapsule) {
        capsules.append(capsule)
        saveCapsules()
    }
    
    func updateCapsule(_ capsule: FutureCapsule) {
        if let index = capsules.firstIndex(where: { $0.id == capsule.id }) {
            capsules[index] = capsule
            saveCapsules()
        }
    }
    
    var sealedCapsules: [FutureCapsule] {
        capsules.filter { $0.isSealed }
    }
    
    var openedCapsules: [FutureCapsule] {
        capsules.filter { !$0.isSealed }
    }
    
    var statistics: Statistics {
        let total = capsules.count
        let opened = openedCapsules.count
        let fulfilled = openedCapsules.filter { $0.fulfillmentStatus == .fulfilled }.count
        let successRate = opened > 0 ? Double(fulfilled) / Double(opened) * 100 : 0
        
        return Statistics(
            created: total,
            opened: opened,
            fulfilled: fulfilled,
            successRate: successRate
        )
    }
    
    func capsulesByYear() -> [Int: Int] {
        var yearCounts: [Int: Int] = [:]
        
        for capsule in openedCapsules {
            if let openedDate = capsule.openedDate {
                let year = Calendar.current.component(.year, from: openedDate)
                yearCounts[year, default: 0] += 1
            }
        }
        
        return yearCounts
    }
}

struct Statistics {
    let created: Int
    let opened: Int
    let fulfilled: Int
    let successRate: Double
}
