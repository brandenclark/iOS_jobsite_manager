//
//  EquipmentListController.swift
//  Project 4 Clark Branden
//
//  Created by Branden Clark on 12/5/18.
//  Copyright © 2018 Branden Clark. All rights reserved.
//

import UIKit

class EquipmentListController: UITableViewController {
    
    // MARK: - Storyboard
    struct Storyboard {
        static let EquipmentCellIdentifier = "EquipmentCell"
        static let EquipmentDetailSequeIdentifier = "EquipmentDetail"
    }
    
    // MARK: - Constants
    
    
    
    // MARK: - Properties
    var equipmentList = [Equipment]()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         equipmentList = EquipmentManagerDatabase.sharedDatabase.equipmentList()
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipmentList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.EquipmentCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = equipmentList[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
