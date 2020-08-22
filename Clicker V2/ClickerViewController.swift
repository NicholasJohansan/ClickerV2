//
//  ViewController.swift
//  Clicker V2
//
//  Created by Johansan on 22/8/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import UIKit

class ClickerViewController: UIViewController {

    @IBOutlet weak var clickerLabel: UILabel!
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        counter += 1
        clickerLabel.text = String(counter)
        
        if counter == 30 {
            print("Maximum reached")
        }
    }
    

}

