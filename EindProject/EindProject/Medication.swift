import Foundation
import UIKit

class Medication: NSObject, NSCoding {
    
    let name: String
    let myDescription: String
    var image = UIImage()
    
    override init(){
        self.myDescription = "no description"
        self.name = "unknown"
        self.image = UIImage (named: "noImage.png")!
        super.init()
    }
   
    required init(description: String, name: String) {
        self.myDescription = description
        self.name = name
        self.image = UIImage (named: "noImage.png")!
    }
    
    required init(description: String, name: String, image: UIImage) {
        self.myDescription = description
        self.name = name
        self.image = image
    }
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.myDescription = decoder.decodeObject(forKey: "myDescription") as! String
        self.image = decoder.decodeObject(forKey: "image") as! UIImage
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(myDescription, forKey: "myDescription")
        coder.encode(image, forKey: "image")
    }
}
