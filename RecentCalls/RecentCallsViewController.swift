import UIKit

class RecentCallsTableController: UITableViewController {
    var callStore = CallStore()
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var clearAllButton: UIBarButtonItem!
    
    @IBAction func changeSegmentedControlValue(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    @IBAction func clearAllPressed(_ sender: UIBarButtonItem) {
        if isEditing {
            callStore.deleteAll()
            tableView.reloadData()
        }
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        clearAllButton.title = isEditing ? "" : "Clear"
        navigationItem.rightBarButtonItem?.title = isEditing ? "Edit" : "Done"
        isEditing.toggle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButtonItem.action = #selector(editPressed)
        
        title = "Recents"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func displayNoItemsLabel() {
        tableView.separatorStyle = .none
        let noItemsLabel = UILabel(frame: tableView.frame)
        noItemsLabel.text = "No Items"
        noItemsLabel.textAlignment = .center
        tableView.backgroundView = noItemsLabel
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if callStore.callsCount() == 0 {
            displayNoItemsLabel()
        }
        return segmentedControl.selectedSegmentIndex == 0 ?
            callStore.callsCount() : callStore.missedCallsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "callCell", for: indexPath) as! CallCell
        let call = segmentedControl.selectedSegmentIndex == 0 ?
            callStore.getCall(at: indexPath) : callStore.getMissedCall(at: indexPath)
        cell.setCell(with: call)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if segmentedControl.selectedSegmentIndex == 0 {
                callStore.removeCall(at: indexPath)
            } else {
                callStore.removeMissedCall(at: indexPath)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y == -tableView.safeAreaInsets.top {
            navigationController!.navigationBar.barTintColor = tableView.backgroundColor
            navigationController!.navigationBar.shadowImage = UIImage()
        } else {
            navigationController!.navigationBar.barTintColor = UINavigationController().navigationBar.barTintColor
        }
    }
}
