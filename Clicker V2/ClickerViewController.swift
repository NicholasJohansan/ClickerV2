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
    var timer: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    @objc func update(){
        timer += 0.1
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        counter += 1
        clickerLabel.text = String(counter)
        
        if counter == 30 {
            print("Maximum reached in \(timer) seconds")
               }
        }
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "exitClicker"{
       
    }

}

