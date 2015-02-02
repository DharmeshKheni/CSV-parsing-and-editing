//
//  nexta-zViewController.swift
//  csv Parsing
//
//  Created by Anil on 27/01/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit

class nexta_zViewController: UIViewController {

    @IBOutlet weak var ageLable: UILabel!
    var ageOfPerson = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ageLable.text = ageOfPerson
    }
}
