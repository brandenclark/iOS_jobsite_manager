//
//  JobListController.swift
//  Project 4 Clark Branden
//
//  Created by Branden Clark on 12/5/18.
//  Copyright © 2018 Branden Clark. All rights reserved.
//

import UIKit

class JobListController: UITableViewController {
    
    // MARK: - Constants
    struct Storyboard {
        static let JobCellIdentifier = "JobCell"
        static let JobDetailSequeIdentifier = "JobDetail"
    }
    
    let queue = DispatchQueue(label: "DatabaseHandler", attributes: .concurrent)
    
    // MARK: - Properties
    var jobList = [Job]()
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Do any additional setup after loading the view, typically from a nib.
        queue.async {
            self.jobList = EquipmentManagerDatabase.sharedDatabase.jobList()
            
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Seques
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.JobDetailSequeIdentifier {
            if let DestVC = segue.destination as? JobDetailController {
                if let indexPath = sender as? IndexPath {
                    DestVC.job = jobList[indexPath.row]
                }
            }
        }
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.JobCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = jobList[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.JobDetailSequeIdentifier, sender: indexPath)
    }
    
    
}
