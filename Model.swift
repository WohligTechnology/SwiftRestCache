//
//  Model.swift
//  SwiftRestCache
//
//  Created by Chintan Shah on 14/04/16.
//  Copyright © 2016 Chintan Shah. All rights reserved.
//

import SwiftHTTP
import UIKit
import CoreData
import SystemConfiguration
import SwiftyJSON
import CryptoSwift
import SQLite

var adminUrl = "http://wohlig.io:81/callApi/blazen/"
var apiUrl = "http://wohlig.io:81/callApi/abc/"
let CacheDetail = Table("CacheDetail")

public class RestCache {
    
    var request = HTTPTask()
    var json: JSON!
    let Db = Database()
    
    public func searchHi (completion: ((JSON) -> Void)) {
        do {
            
            let urlString = apiUrl+"search/getResults"
            let getData = Db.getCache(urlString, dataParams: "Null")
            completion(getData)
            
            request.GET(urlString, parameters: nil, completionHandler: {(response: HTTPResponse) in
//                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
//                print("String: \(str)")
                
                try! self.json =  JSON(data: response.responseObject as! NSData)
                print("response: \(self.json)") //prints the HTML of the page
//                print("make response: \(response.responseObject)") //prints the HTML of the page
                let makeResponse = String(self.json)
                
                print("Make Response: \(makeResponse)")
                
                self.Db.checkCache(urlString, dataParams: "Null", dataResponse: makeResponse)
                if(hasResponseChanged) {
                    hasResponseChanged = false
                    completion(self.json)
                }
            })
        } catch {
            completion(1)
        }
    }
    
    
    public func getNav (completion: ((JSON) -> Void)) {
        
        do {
            let urlString = adminUrl+"navigation/get"
            let getData = Db.getCache(urlString, dataParams: "Null")
            completion(getData)
            
            request.GET(urlString, parameters: nil, completionHandler: {(response: HTTPResponse) in
                try! self.json =  JSON(data: response.responseObject as! NSData)
                print("response: \(self.json)") //prints the HTML of the page
                
                let makeResponse = String(self.json)
                
                self.Db.checkCache(urlString, dataParams: "Null", dataResponse: makeResponse)
                if(hasResponseChanged) {
                    hasResponseChanged = false
                    completion(self.json)
                }
            })
        } catch {
            completion(1)
        }
        
    }
    
    public func getHome (completion: ((JSON) -> Void)) {
        
        do {
            let urlString = adminUrl+"home/get"
            let getData = Db.getCache(urlString, dataParams: "Null")
            completion(getData)
            
            request.GET(urlString, parameters: nil, completionHandler: {(response: HTTPResponse) in
                
                try! self.json =  JSON(data: response.responseObject as! NSData)
                print("response: \(self.json)") //prints the HTML of the page
                
                let makeResponse = "\(self.json)"
                
                self.Db.checkCache(urlString, dataParams: "Null", dataResponse: makeResponse)
                if(hasResponseChanged) {
                    hasResponseChanged = false
                    completion(self.json)
                }
            })
        } catch {
            completion(1)
        }
        
    }
    
    public func getArticle (completion: ((JSON) -> Void)) {
        
        do {
            let urlString = apiUrl+"article/get"
            let getData = Db.getCache(urlString, dataParams: "id=1")
            completion(getData)
            
            request.GET(urlString, parameters: ["id" : 1], completionHandler: {(response: HTTPResponse) in
                try! self.json =  JSON(data: response.responseObject as! NSData)
                print("response: \(self.json)") //prints the HTML of the page
                
                let makeResponse = "\(self.json)"
                
                self.Db.checkCache(urlString, dataParams: "id=1", dataResponse: makeResponse)
                if(hasResponseChanged) {
                    hasResponseChanged = false
                    completion(self.json)
                }
            })
        } catch {
            completion(1)
        }
        
    }
    
    public func getAllGalleryImages (completion: ((JSON) -> Void)) {
        
        do {
            let urlString = adminUrl+"image/getAllAlbums"
            let getData = Db.getCache(urlString, dataParams: "Null")
            completion(getData)
            
            request.GET(urlString, parameters: nil, completionHandler: {(response: HTTPResponse) in
                try! self.json =  JSON(data: response.responseObject as! NSData)
                print("response: \(self.json)") //prints the HTML of the page
                
                let makeResponse = "\(self.json)"
                
                self.Db.checkCache(urlString, dataParams: "Null", dataResponse: makeResponse)
                if(hasResponseChanged) {
                    hasResponseChanged = false
                    completion(self.json)
                }
            })
        } catch {
            completion(1)
        }
        
    }
    
    public func getAllImages (completion: ((JSON) -> Void)) {
        
        do {
            let urlString = apiUrl+"image/getAlbumImages"
            let getData = Db.getCache(urlString, dataParams: "id=1")
            completion(getData)
            
            request.GET(urlString, parameters: nil, completionHandler: {(response: HTTPResponse) in
                try! self.json =  JSON(data: response.responseObject as! NSData)
                print("response: \(self.json)") //prints the HTML of the page
                
                let makeResponse = "\(self.json)"
                
                self.Db.checkCache(urlString, dataParams: "Null", dataResponse: makeResponse)
                if(hasResponseChanged) {
                    hasResponseChanged = false
                    completion(self.json)
                }
                
                
            })
        } catch {
            completion(1)
        }
        
    }
    
    public func getAllGalleryVideos (completion: ((JSON) -> Void)) {
        
        do {
            let urlString = adminUrl+"video/getAllAlbums"
            let getData = Db.getCache(urlString, dataParams: "Null")
            completion(getData)
            
            request.GET(urlString, parameters: nil, completionHandler: {(response: HTTPResponse) in
                try! self.json =  JSON(data: response.responseObject as! NSData)
                print("response: \(self.json)") //prints the HTML of the page
                
                let makeResponse = "\(self.json)"
                
                self.Db.checkCache(urlString, dataParams: "Null", dataResponse: makeResponse)
                if(hasResponseChanged) {
                    hasResponseChanged = false
                    completion(self.json)
                }
            })
        } catch {
            completion(1)
        }
        
    }
    
    public func getAllVideos (completion: ((JSON) -> Void)) {
        
        do {
            let urlString = apiUrl+"video/getAlbumVideos"
            let getData = Db.getCache(urlString, dataParams: "id=1")
            completion(getData)
            
            request.GET(urlString, parameters: nil, completionHandler: {(response: HTTPResponse) in
                try! self.json =  JSON(data: response.responseObject as! NSData)
                print("response: \(self.json)") //prints the HTML of the page
                
                let makeResponse = "\(self.json)"
                
                self.Db.checkCache(urlString, dataParams: "Null", dataResponse: makeResponse)
                if(hasResponseChanged) {
                    hasResponseChanged = false
                    completion(self.json)
                }
            })
        } catch {
            completion(1)
        }
        
    }
}
