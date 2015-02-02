//
//  SecondViewController.swift
//  csv Parsing
//
//  Created by Anil on 27/01/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var names = [String]()
    var ages = [String]()
    var ids = [String]()
    var index = Int()
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let csvURL = NSURL(fileURLWithPath: self.pathToFile())
        
        var error: NSErrorPointer = nil
        let csv = CSV(contentsOfURL: csvURL!, error: error)!

        if let name = csv.columns["Name"]{
            
            self.names = name
        }
        if let age = csv.columns["Age"]{
            
            self.ages = age
        }
        if let id = csv.columns["Marks"]{
            
            self.ids = id
        }
        
    }
    
    func refresh(sender:AnyObject){
        
        // Code to refresh table view
        let csvURL = NSURL(fileURLWithPath: self.pathToFile())
        
        var error: NSErrorPointer = nil
        let csv = CSV(contentsOfURL: csvURL!, error: error)!
        
        if let name = csv.columns["Name"]{
            
            self.names = name
        }
        if let age = csv.columns["Age"]{
            
            self.ages = age
        }
        if let id = csv.columns["Marks"]{
            
            self.ids = id
        }
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.names.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        
        // Configure the cell
        cell.textLabel.text = self.names[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.names.removeAtIndex(indexPath.row)
            self.ages.removeAtIndex(indexPath.row)
            self.ids.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            var updatedArray = [self.names,self.ages,self.ids]
            println(updatedArray)
            if NSFileManager.defaultManager().fileExistsAtPath(self.dataFilePath()){
                
                println("file available")
                
            }
        }
    }
    
    func pathToFile()->String{
        
        
        let filemanager = NSFileManager.defaultManager()
        
        let documentsPath : AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)[0] as NSString
        let destinationPath:NSString = documentsPath.stringByAppendingString("/fav.csv")
        
        if(!filemanager.fileExistsAtPath(destinationPath) ){
            
            if let fileForCopy = NSBundle.mainBundle().pathForResource("fav",ofType:"csv"){
            
            filemanager.copyItemAtPath(fileForCopy,toPath:destinationPath, error: nil)
                
            }
            
            return destinationPath
        }
        else{
            return destinationPath
        }}
    func dataFilePath() -> String{
        
        var paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var documentsDirectory: AnyObject = paths.objectAtIndex(0)
        return documentsDirectory.stringByAppendingPathComponent("fav.csv")
    }
}

