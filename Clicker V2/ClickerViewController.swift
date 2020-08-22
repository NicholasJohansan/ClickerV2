//
//  ViewController.swift
//  Clicker V2
//
//  Created by Johansan on 22/8/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import UIKit

class ClickerViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var totalClicksLabel: UILabel!
    @IBOutlet weak var clickerLabel: UILabel!
    @IBOutlet weak var clicksLeftLabel: UILabel!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    var counter = 0
    var timer: Float = 0.0
    var timestamp: Date!
    var clicksNeeded: Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clicksNeeded = defaults.object(forKey: "totalClicks") as? Int ?? 30
        totalClicksLabel.text = "\(clicksNeeded) Clicks"
        clicksLeftLabel.text = "\(clicksNeeded) more clicks left"
        startLabel.isHidden = false
    }
    
    @objc func update(){
        timer += 0.1
        timeElapsedLabel.text = "\(String(format: "%.2f", timer))s"
        
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        
        if counter == 0 {
            timestamp = Date()
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            startLabel.isHidden = true
        }
        
        counter += 1
        clickerLabel.text = String(counter)
        clicksLeftLabel.text = "\(clicksNeeded - counter) more clicks left"
        
        if counter == clicksNeeded {
            print("Maximum reached in \(timer) seconds")
            performSegue(withIdentifier: "exitClicker", sender: Any?.self)
        }
    }
}

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "exitClicker"{
       
    }

}

