import UIKit

class ScoresViewController: UICollectionViewController {

    var model: ScoreModel!
    private var itemsToDelete: [IndexPath] = []
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            collectionView!.allowsMultipleSelection = true
        } else {
            itemsToDelete.map { $0.row }.sorted(by: >).forEach { model.removeTuple(at: $0) }
            collectionView!.deleteItems(at: itemsToDelete)
            let header = collectionView!.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader).first! as! HeaderView
            header.textLabel.text = "Tap to vote on one of the following \(model.count) colors:"
            collectionView!.allowsMultipleSelection = false
            itemsToDelete = []
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! ColorCell
        let (color, score) = model.tuple(at: indexPath.row)
        cell.extraLabel.text = "\(score)"
        cell.nameLabel.text = color.name
        cell.nameLabel.textColor = itemsToDelete.contains(indexPath) ? UIColor.red : UIColor.black
        //cell.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! HeaderView
        header.textLabel.text = "Tap to vote on one of the following \(model.count) colors:"
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing {
            if itemsToDelete.contains(indexPath) {
                itemsToDelete.remove(at: itemsToDelete.index(of: indexPath)!)
            } else {
                itemsToDelete.append(indexPath)
            }
            collectionView.reloadItems(at: [indexPath])
        } else {
            performSegue(withIdentifier: "vote", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "vote":
            let destination = segue.destination as! VoteViewController
            let selectedIndexPath = collectionView!.indexPathsForSelectedItems!.first!
            destination.color = model.tuple(at: selectedIndexPath.row).color
            
            let popover = segue.destination.popoverPresentationController!
            let selectedCell = collectionView!.cellForItem(at: selectedIndexPath)!
            popover.sourceView = selectedCell
            popover.sourceRect = selectedCell.bounds
        default:
            break
        }
    }
    
    @IBAction func unwindFromVote(_ segue: UIStoryboardSegue) {
       // let source = segue.source as! VoteViewController
        
        collectionView!.reloadItems(at: collectionView!.indexPathsForSelectedItems!)
        
    }
    
    @IBAction func unwindFromAdd(_ segue: UIStoryboardSegue) {
        let source = segue.source as! AddViewController
        if let color = source.color {
            model[color] = 0
            collectionView!.reloadData()
        }
    }
}
