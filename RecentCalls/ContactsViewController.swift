import UIKit

class ContactsViewController: UITableViewController {
    var contactItems = ContactItems()
    
    @IBOutlet var userCardView: UIView!
    
    override func viewDidLoad() {
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactItems.rowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactItem", for: indexPath)
        let item = contactItems.contacts[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        contactItems.titleSection(section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contactItems.contacts.count
    }
}

