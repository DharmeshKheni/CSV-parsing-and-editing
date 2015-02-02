//
//  BLENDSnextViewController.swift
//  csv Parsing
//
//  Created by Anil on 27/01/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit

class BLENDSnextViewController: UIViewController {

    @IBOutlet weak var ageLbl: UILabel!
    var ageOfPerson = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ageLbl.text = self.ageOfPerson
    }

}
