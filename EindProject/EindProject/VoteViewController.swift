import UIKit

class VoteViewController: UIViewController {
    
    
    @IBOutlet weak var preview: UIView!
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var color: Medication!
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = color.name;
        extraLabel.text = color.extra;
        descriptionLabel.text = color.description;
    }
    
}
