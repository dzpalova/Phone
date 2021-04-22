import UIKit

class RecentCallsTableController: UITableViewController {
    var callStore = CallStore()
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var clearAllButton: UIBarButtonItem!
    
    @IBAction func changeSegmentedControlValue(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    @IBAction func clearAllPressed(_ sender: UIBarButtonItem) {
        if !isEditing {
            return
        }

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
        let clearAllAction = UIAlertAction(title: "Clear All", style: .destructive) { _ in
            self.callStore.deleteAll()
            self.tableView.reloadData()
        }
        alertController.addAction(clearAllAction)
                
        let cancelAction = UIAlertAction(title: "Don't clear", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
                
        present(alertController, animated: true, completion: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Recents"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        navigationItem.leftBarButtonItem?.title = editing ? "Clear" : ""
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
}
