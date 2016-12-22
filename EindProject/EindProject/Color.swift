import CoreGraphics

struct Medication {
    
    let name: String
    let extra: String
    let description: String
}

extension Medication: Hashable {
    
    static func ==(lhs: Medication, rhs: Medication) -> Bool {
        return lhs.name == rhs.name
            && lhs.extra == rhs.extra
            && lhs.description == rhs.description
    }
    
    var hashValue: Int {
        return name.hashValue
    }
}

extension Medication: Comparable {
    
    static func <(lhs: Medication, rhs: Medication) -> Bool {
        return lhs.name < rhs.name
    }
}
