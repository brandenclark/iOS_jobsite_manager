//
//  Job.swift
//  Project 4 Clark Branden
//
//  Created by Branden Clark on 11/29/18.
//  Copyright © 2018 Branden Clark. All rights reserved.
//

import Foundation
import GRDB

struct Job : TableRecord, FetchableRecord {
    
    // MARK: - Properties
    
    
    var jobId: Int
    var name: String
    var address: String
    var equipmentId: Int?
    
    // MARK: - Table mapping
    
    static let databaseTableName = "Jobs"
    
    // MARK: - Field names
    
    static let jobId = "job_id"
    static let name = "name"
    static let address = "address"
    static let equipmentId = "equipment_id"
    
    // MARK: - Initialization
    
    init() {
        jobId = 0
        name = ""
        address = ""
        equipmentId = 0
    }
    
    init(row: Row) {
        jobId = row[Job.jobId]
        name = row[Job.name]
        address = row[Job.address]
        equipmentId = row[Job.equipmentId]
    }
}
