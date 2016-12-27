

import UIKit

class MasterViewController: UITableViewController {
    
    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var medicationArray = [Medication]()
        //var model: MedicationModel!
    var filteredMedications = [Medication]()
    
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
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)

        

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
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMedications.count
        }
        return medicationArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let medication: Medication
        if searchController.isActive && searchController.searchBar.text != "" {
            medication = filteredMedications[indexPath.row]
        } else {
            medication = medicationArray[indexPath.row]
        }
        cell.textLabel!.text = medication.name
        // cell.detailTextLabel!.text = medication.description
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete {
            medicationArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
           // .deleteRowsAtIndexPaths([indexPath as IndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showDetail":
            if let indexPath = tableView.indexPathForSelectedRow {
                let medication: Medication
                if searchController.isActive && searchController.searchBar.text != "" {
                    medication = filteredMedications[indexPath.row]
                } else {
                    medication = medicationArray[indexPath.row]
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailMedication = medication
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        default:
            break
        }

    }
    
    @IBAction func unwindFromAdd(_ segue: UIStoryboardSegue) {
        let source = segue.source as! AddViewController
        medicationArray.append(source.medication!)
        tableView!.reloadData()

    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredMedications = medicationArray.filter { medication in
            return medication.name.lowercased().contains(searchText.lowercased())
        }
   
        tableView.reloadData()
    }
    
}
extension MasterViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}



