

import UIKit

class MasterViewController: UITableViewController {
    
    
    var model = MedicationModel()
    var detailViewController: DetailViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMedications = [Medication]()
  
 
    override func viewDidLoad() {
        super.viewDidLoad()
        model.setDummyData()                                        // haalt dummy data op
        searchController.searchResultsUpdater = self                // check wanneer text veranderd in searchbar
        searchController.dimsBackgroundDuringPresentation = false    // searchController ligt op een andere controller waar de resultaten op verschijnen, die mag dus niet gedimd worden
        definesPresentationContext = true                           // searchbar verdwijnt bij veranderen van view
        tableView.tableHeaderView = searchController.searchBar      // searchbar toevoegen aan header
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)  // fixt white gap tussen header en results

        
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMedications.count
        }
        return model.medications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let medication: Medication
        if searchController.isActive && searchController.searchBar.text != "" {
            medication = filteredMedications[indexPath.row]
        } else {
            medication = model.medications[indexPath.row]
        }
        cell.textLabel!.text = medication.name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete {
            model.medications.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
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
                    medication = model.medications[indexPath.row]
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
            model.medications.append(source.medication!)
        }
        tableView!.reloadData()
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredMedications = model.medications.filter { medication in
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



