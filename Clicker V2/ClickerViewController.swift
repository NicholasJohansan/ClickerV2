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
    var time: Float = 0.0
    var timestamp: Date!
    var clicksNeeded: Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clicksNeeded = defaults.object(forKey: "totalClicks") as? Int ?? 30
        totalClicksLabel.text = "\(clicksNeeded) Clicks"
        clicksLeftLabel.text = "\(clicksNeeded) more clicks left"
        startLabel.isHidden = false
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        
        if counter == 0 {
            timestamp = Date()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                self.time += 0.1
                self.timeElapsedLabel.text = "\(String(format: "%.2f", self.time))s"
            })
            startLabel.isHidden = true
        }
        
        counter += 1
        clickerLabel.text = String(counter)
        clicksLeftLabel.text = "\(clicksNeeded - counter) more clicks left"
        
        if counter == clicksNeeded {
            print("Maximum reached in \(time) seconds")
            performSegue(withIdentifier: "exitClicker", sender: Any?.self)
        }
    }
}

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "exitClicker"{
       
    }

}

