import Foundation

class Medication {
    
    let name: String
    let description: String
    
    init(description: String, name: String) {
        self.description = description
        self.name = name
    }
}
