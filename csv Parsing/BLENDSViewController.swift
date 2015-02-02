//
//  BLENDSViewController.swift
//  csv Parsing
//
//  Created by Anil on 27/01/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit

class BLENDSViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var names = [String]()
    var age = [String]()
    var index = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let csvURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("usersSecond", ofType: "csv")!)
        var error: NSErrorPointer = nil
        let csv = CSV(contentsOfURL: csvURL!, error: error)!
        
        let columns = csv.columns
        self.names = csv.columns["name"]!
        self.age = csv.columns["age"]!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        cell.textLabel.text = self.names[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.index = indexPath.row
        self.performSegueWithIdentifier("goNext", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "goNext") {
            
            var nextView = segue.destinationViewController as BLENDSnextViewController
            
            nextView.ageOfPerson = age[index]
        }
    }
}
