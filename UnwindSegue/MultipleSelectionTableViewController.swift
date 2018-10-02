//
//  MultipleSelectionTableViewController.swift
//  UnwindSegue
//
//  Created by Natalia Macambira on 30/04/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class MultipleSelectionTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: - Instance Properties
    let daysOfTheWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var selectedDays: String?
    var selectedDaysIndex: [Int]? = []    

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfTheWeek.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayOfTheWeekCell", for: indexPath)
        cell.textLabel?.text = daysOfTheWeek[indexPath.row]
        if let selectedDays = selectedDaysIndex {
            if selectedDays.contains(indexPath.row) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    // MARK: - Table view delegate    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let selectedRow = indexPath.row
        if let selectedDays = selectedDaysIndex {
            if selectedDays.contains(selectedRow) {
                let index = selectedDays.index(of: selectedRow)
                selectedDaysIndex!.remove(at: index!)
            } else {
                selectedDaysIndex!.append(selectedRow)
            }            
        }
        self.tableView.reloadRows(at: [indexPath], with: .none)     
    }    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneDaysOfTheWeek" {
            if (sender as AnyObject) === doneButton {
                var days: String = ""
                
                for (index, day) in daysOfTheWeek.enumerated() {
                    if let selectedDays = selectedDaysIndex {
                        if selectedDays.contains(index) {
                            days += "\(day), "
                        }
                    }
                }
                
                let endIndex = days.index(days.endIndex, offsetBy: -2)
                self.selectedDays = String(days[..<endIndex]) // Swift 4.0
            }
        }
    }
}
