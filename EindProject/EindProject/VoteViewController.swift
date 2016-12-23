import UIKit

class VoteViewController: UIViewController {
    
    
  //  @IBOutlet weak var preview: UIView!
    @IBOutlet weak var buttonStack: UIStackView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var color: Medication!
    
    override func viewWillAppear(_ animated: Bool) {
        if presentingViewController!.traitCollection.horizontalSizeClass == .regular {
           // preview.removeFromSuperview()
            let buttonsSize = buttonStack.bounds.size
            preferredContentSize = CGSize(width: buttonsSize.width + 16, height: buttonsSize.height + 16)
        } else {

        nameLabel.text = color.name;
        extraLabel.text = color.extra;
        descriptionLabel.text = color.description;
        }

    }
    @IBAction func back() {
        performSegue(withIdentifier: "voted", sender: self)
    }
}
