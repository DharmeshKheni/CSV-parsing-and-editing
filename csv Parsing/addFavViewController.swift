//
//  addFavViewController.swift
//  csv Parsing
//
//  Created by Anil on 30/01/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit

class addFavViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var marks: UITextField!
    
    var dataArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.delegate = self
        self.age.delegate = self
        self.marks.delegate = self
    }
    
    @IBAction func save(sender: AnyObject) {
        
        var txxt1 = name.text
        var txxt2 = age.text
        var txxt3 = marks.text
        
        self.dataArray = [txxt1 as String, txxt2 as String, txxt3 as String]
        
        if !NSFileManager.defaultManager().fileExistsAtPath(self.dataFilePath()){
            
            NSFileManager.defaultManager().createFileAtPath(self.dataFilePath(), contents: nil, attributes: nil)
            println("File Created")
            
        }
        
        println(self.dataFilePath())
        var writeString : String = String()
        
        writeString = String(format: "%@,%@,%@\n", dataArray.objectAtIndex(0) as String, dataArray.objectAtIndex(1) as String, dataArray.objectAtIndex(2) as String)
        var handle : NSFileHandle = NSFileHandle()
        handle = NSFileHandle(forWritingAtPath: self.dataFilePath())!
        handle.truncateFileAtOffset(handle.seekToEndOfFile())
        handle.writeData(writeString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)
        txxt1 = ""
        txxt2 = ""
        txxt3 = ""
        
        dataArray = [txxt1, txxt2, txxt3]
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func dataFilePath() -> String{
        
        var paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var documentsDirectory: AnyObject = paths.objectAtIndex(0)
        return documentsDirectory.stringByAppendingPathComponent("fav.csv")
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true)
        return false
    }

}
