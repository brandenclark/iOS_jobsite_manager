//
//  JobDetailController.swift
//  Project 4 Clark Branden
//
//  Created by Branden Clark on 12/5/18.
//  Copyright © 2018 Branden Clark. All rights reserved.
//

import UIKit

class JobDetailController: UIViewController {
    // MARK: - Constants
    let queue = DispatchQueue(label: "DatabaseHandler", attributes: .concurrent)
    // MARK: - Properties
    var job: Job = Job()
    
    // MARK: - Outlets
    @IBOutlet weak var JobID: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Address: UILabel!
    
    // MARK: - Actions
    @IBAction func DeleteJob(_ sender: Any) {
        queue.async {
            EquipmentManagerDatabase.sharedDatabase.deleteJob(self.job.jobId)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Do any additional setup after loading the view, typically from a nib.
        UpdateUI()
    }
    
    // MARK: - Helpers
    private func UpdateUI() {
        JobID.text = String(job.jobId)
        Name.text = job.name
        Address.text = job.address
    }
    
}
