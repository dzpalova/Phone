import UIKit
import Foundation

class ContactsViewController: UITableViewController, UISearchBarDelegate {
    var allContactItems = ContactItems()
    var contactItems: ContactItems!
    
    @IBOutlet var userCardView: UIView!
    var searchBar: UISearchController!
    
    override func viewDidLoad() {
        contactItems = allContactItems
        
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        searchBar = UISearchController()
        navigationItem.searchController = searchBar
        searchBar.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            return
        }

        var filtered = [Contact]()
        print(searchText)
        for contact in allContactItems {
            if contact.name.prefix(searchText.count).lowercased() == searchText.lowercased() {
                filtered.append(contact)
                print(contact)
            }
        }
        
        if filtered.count != 0 {
            contactItems.clearAll()
            contactItems.parseData(filtered)
        } else {
            contactItems = allContactItems
        }
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        contactItems = allContactItems
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactItems.rowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactItem", for: indexPath)
        let contact = contactItems.getContact(indexPath)
        cell.textLabel?.text = contact.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        contactItems.titleSection(section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contactItems.contacts.count
    }
}

