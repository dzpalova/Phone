//
//  ViewController.swift
//  RecentCalls
//
//  Created by Daniela Palova on 16.04.21.
//

import UIKit

class RecentCallsTableController: UITableViewController {
    var callStore = CallStore()
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var clearAllButton: UIBarButtonItem!
    @IBOutlet var editButton: UIBarButtonItem!
    
    @IBAction func changeSegmentedControlValue(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    @IBAction func clearAllPressed(_ sender: UIBarButtonItem) {
        if isEditing {
            segmentedControl.selectedSegmentIndex == 0 ? callStore.deleteAll() : callStore.deleteAllMissed()
            tableView.reloadData()
        }
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        clearAllButton.title = isEditing ? "" : "Clear"
        editButton.title = isEditing ? "Edit" : "Done"
        isEditing.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.barTintColor = tableView.backgroundColor
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Recents"
//    }
    
//    override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
//        navigationController!.navigationBar.barTintColor = tableView.backgroundColor
//        navigationController!.navigationBar.shadowImage = UIImage()
//    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y == -tableView.safeAreaInsets.top {
            navigationController!.navigationBar.barTintColor = tableView.backgroundColor
            navigationController!.navigationBar.shadowImage = UIImage()
        } else {
            navigationController!.navigationBar.barTintColor = UINavigationController().navigationBar.barTintColor
            //navigationController!.navigationBar.shadowImage = UINavigationController().navigationBar.shadowImage
        }
    }
}
/*
//
//  ViewController.swift
//  RecentCalls
//
//  Created by Daniela Palova on 16.04.21.
//

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
            segmentedControl.selectedSegmentIndex == 0 ? callStore.deleteAll() : callStore.deleteAllMissed()
            tableView.reloadData()
        }
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        clearAllButton.title = isEditing ? "" : "Clear"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.barTintColor = tableView.backgroundColor
        clearAllButton.title = ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
*/
