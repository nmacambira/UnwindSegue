//
//  SingleSelectionTableViewController.swift
//  UnwindSegue
//
//  Created by Natalia Macambira on 30/04/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class SingleSelectionTableViewController: UITableViewController {
    
    var actitvities: [String] = ["Beach tennis", "Fistball", "Footbag", "Running", "Skateboarding", "Snowboarding", "Squash", "Wakeboarding"]

    var selectedActivity: String?
    
    var selectedActivityIndex: Int?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)

    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return actitvities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)

        cell.textLabel?.text = actitvities[indexPath.row]
        
        if selectedActivityIndex != nil {
            
            if selectedActivityIndex == indexPath.row {
                
                cell.accessoryType = .checkmark
                
            } else {
                
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "selectedActivity" {
            
            if let cell = sender as? UITableViewCell {
                
                let indexPath = tableView.indexPath(for: cell)
                
                if let row = indexPath?.row {
                
                    self.selectedActivity = actitvities[row]
                    
                    self.selectedActivityIndex = row
                }
            }
            
        }
    }
    
}
