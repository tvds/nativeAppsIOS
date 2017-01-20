import UIKit

class AddViewController: UITableViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
   
   
    @IBOutlet weak var descriptionField: UITextField!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    var medication: Medication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        picker.delegate = self
        saveButton.isEnabled = false
    }
    
    @IBAction func hideKeyboard() {
        nameField.resignFirstResponder()
    }
    
    @IBAction func photoFromLibrary(_ sender: UIButton) {
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func shootPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    @IBAction func save() {
        let name = nameField.text!
        let description = descriptionField.text!
        if (myImageView.image != nil) {
            let imageData = UIImageJPEGRepresentation(myImageView.image!, 0.6)
            let compressedJPGImage = UIImage(data: imageData!)
            
            medication = Medication(description: description, name: name, image: compressedJPGImage!)

        }else{
            medication = Medication(description: description, name: name)
        }
                performSegue(withIdentifier: "added", sender: self)
    }
    
  
   
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //source:https://makeapppie.com/2016/06/28/how-to-use-uiimagepickercontroller-for-a-camera-and-photo-library-in-swift-3-0/
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = chosenImage
        dismiss(animated:true, completion: nil)
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
