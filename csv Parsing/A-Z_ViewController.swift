//
//  A-Z_ViewController.swift
//  csv Parsing
//
//  Created by Anil on 27/01/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit

class A_Z_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var names = [String]()
    var ages = [String]()
    var ids = [String]()
    var index = Int()
    var filteredCandies = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let csvURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("users", ofType: "csv")!)
        var error: NSErrorPointer = nil
        let csv = CSV(contentsOfURL: csvURL!, error: error)!
        
        let columns = csv.columns
        self.names = csv.columns["name"]!
        self.ages = csv.columns["age"]!
        self.ids = csv.columns["id"]!
        var filteredCandies = self.ages
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            return self.filteredCandies.count
        } else {
            return self.ages.count
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        var age = String()
        if tableView == self.searchDisplayController?.searchResultsTableView {
            age = filteredCandies[indexPath.row]
        } else {
            age = ages[indexPath.row]
        }
        
        // Configure the cell
        cell.textLabel.text = self.names[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        self.filteredCandies = self.ages.filter({(age : String) -> Bool in
            
            var categoryMatch = (scope == "All") || (age == scope)
            var stringMatch = age.rangeOfString(searchText)

            return categoryMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.index = indexPath.row
        self.performSegueWithIdentifier("goNext", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "goNext") {
            
            var nextView = segue.destinationViewController as nexta_zViewController
            
           nextView.ageOfPerson = ages[index]
        }
    }
    
}
