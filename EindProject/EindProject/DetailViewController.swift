

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var medicationImageView: UIImageView!
    
    var detailMedication: Medication? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailMedication = detailMedication {
            if let detailDescriptionLabel = detailDescriptionLabel, let medicationImageView = medicationImageView {
                detailDescriptionLabel.text = detailMedication.description
                medicationImageView.image =  detailMedication.image
                title = detailMedication.name
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

