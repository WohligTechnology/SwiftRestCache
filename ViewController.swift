//
//  ViewController.swift
//  SwiftRestCache
//
//  Created by Chintan Shah on 14/04/16.
//  Copyright © 2016 Chintan Shah. All rights reserved.
//

import UIKit
import CoreData
import CryptoSwift
import SwiftyJSON

var id = 0
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

class ViewController: UIViewController {
    var api = RestCache()
    @IBOutlet weak var HiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("App Delegate: \(appDelegate)")
    }

    func showLabel(json: JSON){
        
        if(json == 1)
        {
            print("ERROR.");
        }
        else
        {
            print("Callback: \(json)")
        }
            
    }
    
    @IBAction func sayHiTap(sender: AnyObject) {
        
        api.searchHi(self.showLabel)
        
    }
    
    @IBAction func getNav(sender: AnyObject) {
        
        api.getNav(self.showLabel)
    
    }
    
    @IBAction func homeTap(sender: AnyObject) {
        
        api.getHome(self.showLabel)
    }
    
    @IBAction func articleTap(sender: AnyObject) {
        
       api.getArticle(self.showLabel)
        
    }
    
    @IBAction func imageAllTap(sender: AnyObject) {
        
        api.getAllGalleryImages(self.showLabel)
        
    }
    
    @IBAction func imageListTap(sender: AnyObject) {
        
        api.getAllImages(self.showLabel)
        
    }
    
    @IBAction func videoAllTap(sender: AnyObject) {
        
        api.getAllGalleryVideos(self.showLabel)
        
    }
    
    @IBAction func videoListTap(sender: AnyObject) {
        
        api.getAllVideos(self.showLabel)
        
    }
    
}