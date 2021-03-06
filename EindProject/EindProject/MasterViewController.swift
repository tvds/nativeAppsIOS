

import UIKit

class MasterViewController: UITableViewController {
    
    
    var model = MedicationModel()
    var detailViewController: DetailViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMedications = [Medication]()
    var medications = [Medication]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --- Voor dummy data zet onderstaande uit commentaar, build app en daarna terug in commentaar ---
        /*
        model.setDummyData()
        medications = model.medications
        insertItems()
        */
       
        retrieveItems()
        
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
    func insertItems()
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: medications)
        UserDefaults.standard.set(data, forKey: "myList")
    }
    
    func retrieveItems()
    {
        if let data = UserDefaults.standard.object(forKey: "myList") as? NSData {
            medications = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Medication]
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMedications.count
        }
        return medications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let medication: Medication
        if searchController.isActive && searchController.searchBar.text != "" {
            medication = filteredMedications[indexPath.row]
        } else {
            medication = medications[indexPath.row]
        }
        cell.textLabel!.text = medication.name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete {
            medications.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            insertItems()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showDetail":
            if let indexPath = tableView.indexPathForSelectedRow {
                let medication: Medication
                if searchController.isActive && searchController.searchBar.text != "" {
                    medication = filteredMedications[indexPath.row]
                } else {
                    medication = medications[indexPath.row]
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
    
    @IBAction func quitApp(_ sender: AnyObject) {
        exit(0);
    }
    
    @IBAction func unwindFromAdd(_ segue: UIStoryboardSegue) {
        let source = segue.source as! AddViewController
        if source.medication != nil {
            medications.append(source.medication!)
            insertItems()
        }
        tableView!.reloadData()
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredMedications = medications.filter { medication in
            return medication.name.lowercased().contains(searchText.lowercased())
        }
   
        tableView.reloadData()
    }
    
}
//Source:https://www.raywenderlich.com/113772/uisearchcontroller-tutorial
extension MasterViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}



