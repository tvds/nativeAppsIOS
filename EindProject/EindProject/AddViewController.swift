import UIKit

class AddViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
   
    @IBOutlet weak var extraField: UITextField!
   
    @IBOutlet weak var descriptionField: UITextField!
    
    
    var color: Medication?
    
    override func viewDidLoad() {
        nameField.delegate = self
        saveButton.isEnabled = false
    }
    
    @IBAction func hideKeyboard() {
        nameField.resignFirstResponder()
    }
    
    
    @IBAction func save() {
        let name = nameField.text!
        let extra = extraField.text!
        let description = descriptionField.text!
        color = Medication(name: name, extra: extra, description: description)
        performSegue(withIdentifier: "added", sender: self)
    }
}

extension AddViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let oldText = text as NSString
            let newText = oldText.replacingCharacters(in: range, with: string)
            saveButton.isEnabled = newText.characters.count > 0
        } else {
            saveButton.isEnabled = string.characters.count > 0
        }
        return true
    }
}
