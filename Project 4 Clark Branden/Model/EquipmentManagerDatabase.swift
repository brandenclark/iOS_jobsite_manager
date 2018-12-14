//
//  EquipmentManagerDatabase.swift
//  Project 4 Clark Branden
//
//  Created by Branden Clark on 12/8/18.
//  Copyright © 2018 Branden Clark. All rights reserved.
//

import Foundation
import GRDB

class EquipmentManagerDatabase {
    
    // MARK: - Constants
    
    struct Constant {
        static let FileName = "test.sqlite"
        static let JobsTable = "Jobs"
        static let EquipmentTable = "Equipment"
    }
    
    // MARK: - Properties
    
    var dbQueue: DatabaseQueue!
    
    
    // MARK: - Singleton
    
    // See http://bit.ly/1tdRybj for a discussion of this singleton pattern.
    static let sharedDatabase = EquipmentManagerDatabase()
    
    fileprivate init() {
        setupDatabase()
        // This guarantees that code outside this file can't instantiate a GeoDatabase.
        // So others must use the sharedGeoDatabase singleton.
//        dbQueue = try? DatabaseQueue(path: Bundle.main.path(forResource: Constant.fileName,
//                                                            ofType: Constant.fileExtension)!)
    }
    
    func setupDatabase() {
        
        if let documentsPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            // create the custom folder path for the database
            let databasePath = documentsPathString.appending("/\(Constant.FileName)")
            
            let fileManager = FileManager.default
            
            // Create the database if it doesn't exist
            if !fileManager.fileExists(atPath: databasePath) {
                
                fileManager.createFile(atPath: databasePath,
                                       contents: Data(),
                                       attributes: nil)
                
                dbQueue = try? DatabaseQueue(path: databasePath)
                
                
                do {
                    try dbQueue.write { db in
                        try db.execute(
                            """
                            CREATE TABLE Jobs
                            (
                                job_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                name TEXT NOT NULL,
                                address TEXT NOT NULL,
                                equipment_id INTEGER NULL,
                                CONSTRAINT fk_equipment
                                    FOREIGN KEY (equipment_id)
                                    REFERENCES Equipment(equipment_id)
                            );

                            CREATE TABLE Equipment
                            (
                                equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                name TEXT NOT NULL,
                                barcode INTEGER NOT NULL,
                                job_id INTEGER NULL,
                                CONSTRAINT fk_jobs
                                    FOREIGN KEY (job_id)
                                    REFERENCES Jobs(job_id)
                            );
                            """
                        )
                    }
                }
                catch {
                    print("Failed to create DB: \(error)")
                }
                
                do {
                    print("Did the do")
                    try dbQueue.write { db in
                        try db.execute(
                            "INSERT INTO \(Constant.JobsTable) (name, address) VALUES (?, ?);",
                            arguments: [
                                "Clark Remodel",
                                "639 Wymount Terrace, Provo, UT 84604"
                                ])
                    }
                }
                catch {
                    print("Failed to Insert New Initial Jobs: \(error)")
                }
                
                do {
                    print("Did the do 2")
                    try dbQueue.write { db in
                        try db.execute(
                            "INSERT INTO \(Constant.EquipmentTable) (name, barcode) VALUES (?, ?);",
                            arguments: [
                                "Bulldozer",
                                123456789
                            ])
                    }
                }
                catch {
                    print("Failed to Insert New Initial Equipment: \(error)")
                }
                
            }
            else {
                dbQueue = try? DatabaseQueue(path: databasePath)
            }
            
            
        print("Documents at location: \(documentsPathString)")
        }
    }
    
    // MARK: - Helpers
    
//    func jobForId(_ jobId: Int) -> Job  {
//        do {
//            let result = try dbQueue.inDatabase { (db: Database) -> Job in
//                let row = try Row.fetchOne(db,
//                                           "select * from \(Job.databaseTableName) " +
//                    "where \(Job.id) = ?",
//                    arguments: [ jobId ])
//                if let returnedRow = row {
//                    return Job(row: returnedRow)
//                }
//                
//                return Job()
//            }
//            
//            return result
//        } catch {
//            return Job()
//        }
//        
//    }
    
    func createJob(named name:String, at address:String) {
        do {
            try dbQueue.write { db in
                try db.execute("""
                                INSERT INTO Jobs (name, address)
                                VALUES (?, ?)
                                """, arguments: [name, address])
                                }
        } catch {
            
        }
    }
    
    func deleteJob(_ id:Int) {
        do {
            try dbQueue.write { db in
                try db.execute("""
                                DELETE
                                FROM
                                    Jobs
                                WHERE
                                    job_id = (?)
                                """, arguments: [id])
            }
        } catch {
            
        }
    }
    
    func equipmentList() -> [Equipment]  {
        do {
            let result = try dbQueue.inDatabase { (db: Database) -> [Equipment] in
                var result = [Equipment]()
                
                let rows = try Row.fetchCursor(db,
                                           "select * from \(Equipment.databaseTableName) ")
                while let row = try rows.next() {
                    result.append(Equipment(row: row))
                }
                
                return result
            }
            
            return result
        } catch {
            return [Equipment]()
        }
    }
    
    func jobList() -> [Job]  {
        do {
            let result = try dbQueue.inDatabase { (db: Database) -> [Job] in
                var result = [Job]()
                
                let rows = try Row.fetchCursor(db,
                                               "select * from \(Job.databaseTableName) ")
                while let row = try rows.next() {
                    result.append(Job(row: row))
                }
                
                return result
            }
            
            return result
        } catch {
            return [Job]()
        }
    }
}
