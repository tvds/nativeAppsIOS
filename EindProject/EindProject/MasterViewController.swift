

import UIKit

class MasterViewController: UITableViewController {
    
    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    var medicationArray = [Medication]()
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        medicationArray = [
            Medication(description:"Behandeling parkinson", name:"Akineton"),
            Medication(description:"antibioticum", name:"Amoxiclav teva"),
            Medication(description:"Hypertensie", name:"Bisoprolol"),
            Medication(description:"Spasmolytica, heft verkramping (spasmen) op in maag-darmkanaal, galwegen, urinewegen.", name:"Buscopan (oraal, I.M)"),
            Medication(description:"Antitrombotica/anticoagulantia. Antistolling, behandeling diverse cardiovasculaire problemen", name:"Clexane (subcutaan)"),
            Medication(description:"Behandeling Parkinson", name:"Corbilta"),
            Medication(description:"Antibioticum", name:"Clamoxyl I.M"),
            Medication(description:"Opheffen van luchtwegvernauwing bij COPD", name:"Combivent unit dose"),
            Medication(description:"Anti-Alzheimer middelen", name:"Donepezil"),
            Medication(description:"Krachtige pijnstiller", name:"Durogesic (pleister)"),
            Medication(description:"Antitrombotica", name:"Eliquis"),
            Medication(description:"Diarree", name:"Enterol")
        ]
        


        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicationArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let medication = medicationArray[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = medication.name
        return cell
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let medication = medicationArray[(indexPath as NSIndexPath).row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailMedication = medication
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}


