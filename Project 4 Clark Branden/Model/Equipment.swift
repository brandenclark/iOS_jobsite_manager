//
//  Equipment.swift
//  Project 4 Clark Branden
//
//  Created by Branden Clark on 11/29/18.
//  Copyright © 2018 Branden Clark. All rights reserved.
//

import Foundation
import GRDB

struct Equipment : TableRecord, FetchableRecord {
    
    // MARK: - Properties
    
    var equipmentId: Int
    var name: String
    var barcode: Int
    var jobId: Int?
    
    // MARK: - Table mapping
    
    static let databaseTableName = "Equipment"
    
    // MARK: - Field names
    
    static let equipmentId = "equipment_id"
    static let name = "name"
    static let barcode = "barcode"
    static let jobId = "job_id"
    
    // MARK: - Initialization
    
    init() {
        equipmentId = 0
        name = ""
        barcode = 0
        jobId = 0
        
    }
    
    init(row: Row) {
        equipmentId = row[Equipment.equipmentId]
        name = row[Equipment.name]
        barcode = row[Equipment.barcode]
        jobId = row[Equipment.jobId]
    }
}
