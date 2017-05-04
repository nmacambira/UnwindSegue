//
//  FirstViewController.swift
//  UnwindSegue
//
//  Created by Natalia Macambira on 24/04/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    var sectionsTitles: [String] = ["Activity", "Day of the week"]
    
    var sectionsCellsText: [String] = ["Select an activity", "Select the days of the week"]
    
    var selectedActivityIndex: Int?
    
    var selectedDaysIndex: [Int]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }    
    
    //MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            return sectionsTitles[section]
            
        } else {
            
            return sectionsTitles[section]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 && sectionsCellsText[0] == "Select an activity" {
            
            cell.textLabel?.textColor = UIColor.lightGray
            
        } else if indexPath.section == 1 && sectionsCellsText[1] == "Select the days of the week" {
            
             cell.textLabel?.textColor = UIColor.lightGray
            
        } else {
            
             cell.textLabel?.textColor = UIColor.black
        }
        
        cell.textLabel?.text = sectionsCellsText[indexPath.section]
        
        return cell
        
    }
    
    //MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            self.performSegue(withIdentifier: "selectActivity", sender: nil)
            
        } else {
            
            self.performSegue(withIdentifier: "selectDaysOfTheWeek", sender: nil)
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToFirstVC(sender: UIStoryboardSegue) {
        
        if sender.identifier == "selectedActivity" {
            
            if let singleSelection = sender.source as? SingleSelectionTableViewController,
                let activity = singleSelection.selectedActivity,
                let activityIndex = singleSelection.selectedActivityIndex {
                
                self.sectionsCellsText[0] = activity
                
                self.selectedActivityIndex = activityIndex
                
                let section = IndexSet(integer: 0)
                self.tableView.reloadSections(section, with: UITableViewRowAnimation.automatic)
                
            }
            
        } else if sender.identifier == "doneDaysOfTheWeek" {
            
            if let multipleSelection = sender.source as? MultipleSelectionTableViewController,
                let days = multipleSelection.selectedDays,
                let daysIndex = multipleSelection.selectedDaysIndex {
                
                self.sectionsCellsText[1] = days
                
                self.selectedDaysIndex = daysIndex
                
                let section = IndexSet(integer: 1)
                self.tableView.reloadSections(section, with: UITableViewRowAnimation.automatic)
            }
            
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "selectActivity" {
            
            let destination = segue.destination as! SingleSelectionTableViewController
            
            if let selectedActivity = selectedActivityIndex {
                destination.selectedActivityIndex = selectedActivity
            }
            
        } else if segue.identifier == "selectDaysOfTheWeek" {
            
            let destination = segue.destination as! MultipleSelectionTableViewController
            
            if let selectedDays = selectedDaysIndex {
                destination.selectedDaysIndex = selectedDays
            }
            
        }
    }
    
}

