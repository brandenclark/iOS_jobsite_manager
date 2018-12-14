//
//  NewJobController.swift
//  Project 4 Clark Branden
//
//  Created by Branden Clark on 12/6/18.
//  Copyright © 2018 Branden Clark. All rights reserved.
//

import UIKit

class NewJobController: UIViewController {
    // MARK: - Storyboard
    struct Storyboard {
        static let AlertMessage = "Please fill out both fields."
        static let ModeSwitchAnimationTime = 1.0
        static let JobDetailSegueIdentifier = "JobDetail"
    }
    
    // MARK: - Constants
    let queue = DispatchQueue(label: "DatabaseHandler", attributes: .concurrent)

    // MARK: - Outlets
    @IBOutlet weak var JobNameTextField: UITextField!
    @IBOutlet weak var JobAddressTextField: UITextField!
    
    // Mark: - Action
    @IBAction func CancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateJobButton(_ sender: Any) {
        //Needs Work - Submit through db methods
        if JobNameTextField.hasText && JobAddressTextField.hasText {
            
            queue.async {
                EquipmentManagerDatabase.sharedDatabase.createJob(
                    named: self.JobNameTextField.text ?? "Fail",
                    at: self.JobAddressTextField.text ?? "Epic Fail")
            }
            
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "\(Storyboard.AlertMessage)",
                message: nil, preferredStyle: .alert)
            
            self.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: Storyboard.ModeSwitchAnimationTime,
                                 repeats: false,
                                 block: { _ in alert.dismiss(animated: true,
                                                             completion: nil)} )
        }
    }
}
