import Foundation
import UIKit

class Medication {
    
    let name: String
    let description: String

    var image = UIImage()
    
    init(description: String, name: String) {
        self.description = description
        self.name = name
    }
    
    init(description: String, name: String, image: UIImage) {
        self.description = description
        self.name = name
        self.image = image
    }
}
