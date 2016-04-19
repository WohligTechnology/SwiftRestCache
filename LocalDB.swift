//
//  LocalDB.swift
//  
//
//  Created by Chintan Shah on 15/04/16.
//
//

import SQLite
import SwiftyJSON

var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!

public class Database {

    public let db = try! Connection("\(path)/db.sqlite3")
	
    public let CacheDetail = Table("CacheDetail")
    
    let id = Expression<Int64>("id")
    let url = Expression<String>("url")
    let params = Expression<String>("params")
    let hash = Expression<String>("hash")
    let timestamp = Expression<NSDate>("timestamp")
    let count = Expression<Int64>("count")
    let response = Expression<String>("response")
    
    init () {
//        print(path)
        try! db.run(CacheDetail.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(url)
            t.column(params)
            t.column(hash, unique: true)
            t.column(timestamp)
            t.column(count)
            t.column(response)
        })
        
    }
    
    func checkCache(dataUrl: String, dataParams: String, dataResponse: String) -> Void {
        
//        print("in the check cache function")
//        print("dataResponse: \(dataResponse)")
        let dataHash = dataResponse.md5()
//        print("Hash is: \(dataHash)")
        
        let fetchRequest = CacheDetail.filter(url == dataUrl && params == dataParams)
//        print("Fetch request is fine \(fetchRequest)")
        var fetchCount = db.scalar(fetchRequest.count)
        let timeStamp = NSDate();
        
        if(fetchCount == 0) {
//                print("In the if statement")
                //Add the following row
            
            
                let insert = CacheDetail.insert(url <- dataUrl, params <- dataParams, hash <- dataHash, timestamp <- timeStamp, count <- 1, response <- dataResponse)
                do {
                    let rowCount = try db.scalar(CacheDetail.count)
                    if(rowCount == 100 && dataUrl != " ") {
                        let leastVisited = CacheDetail.select(count.min, id)
                        if(db.scalar(leastVisited.count) > 1) {
                            
                            leastVisited.order(timeStamp)
//                            print("least visited: \(db.scalar(leastVisited.count))")
                            let oldestTSRow = db.pluck(leastVisited)
//                            print("oldest row: \(oldestTSRow)")
                            let removeRowId = oldestTSRow!.get(id)
//                            print("remove row: \(removeRowId)")
                            let nowDelete = CacheDetail.filter(id == removeRowId)
                            try db.run(nowDelete.delete())
                            
                            let rowid = try db.run(insert)
//                            print("inserted id: \(rowid)")
                    
                        } else {
                            
                            try db.run(leastVisited.delete())
                            
                        }
                        
                    } else if (dataUrl != " ") {
                        
                        let rowid = try db.run(insert)
//                        print("inserted id: \(rowid)")
                        
                    }
                } catch {
                    print("insertion failed: \(error)")
                }
                
            } else {
                
                //Compare Hashes
            let tableHash = db.scalar(fetchRequest.select(hash))
//            print("tableHash: \(tableHash)")
//            print("dataHash: \(dataHash)")
                if(tableHash != dataHash) {
                    //Update the record
                    hasResponseChanged = true
//                    print("In the different hash function")
                    let update = fetchRequest.update(params <- dataParams, hash <- dataHash, timestamp <- timeStamp, count++)
                    do {
                        let rowid = try db.run(update)
//                        print("updated id: \(rowid)")
                    } catch {
//                        print("updation failed: \(error)")
                    }
                }
            }
            //            for fetchedUser in fetchedUsers {
            //
            //                context.deleteObject(fetchedUser)
            //                //                    context.save()
            //            }
    }
    
    func getCache(urlString: String, dataParams: String) -> JSON {
        
        let returnTable = CacheDetail.filter(url == urlString && params == dataParams)
        if(db.scalar(returnTable.count) > 0) {
            
            let returnRow = db.pluck(returnTable)
            let returnData = returnRow?.get(response)
            let final = JSON(returnData!)
//            print("Final return statement: \(final)")
            return final
            
        }
        return JSON("Not found")
    }
}
