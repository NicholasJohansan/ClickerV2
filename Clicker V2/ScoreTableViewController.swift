//
//  ScoreTableViewController.swift
//  Clicker V2
//
//  Created by Edwin Ti on 22/8/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {
    var scores: [Score] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedScores = Score.loadFromFile() {
            scores = loadedScores
        } else {
            Score.saveToFile(scores: scores)
        }
        
        if let _ = defaults.object(forKey: "totalClicks") as? Int {
            //pass
        } else {
            defaults.set(30, forKey: "totalClicks")
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func setTotalClicks(_ sender: Any) {
        
        let totalClicks = defaults.object(forKey: "totalClicks") as? Int ?? 30
        
        let alert = UIAlertController(title: "Set Total Clicks", message: "Enter how many times to click in total", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter number:"
            textField.text = String(totalClicks)
        })
        
        alert.addAction(UIAlertAction(title: "Set", style: .default, handler: { (_) in
            if let clicks = Int(alert.textFields![0].text!) {
                self.defaults.set(clicks, forKey: "totalClicks")
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreRow", for: indexPath)

        if let cell = cell as? ScoreTableViewCell {
            let currentScore = scores[indexPath.row]
            if currentScore.new == true {
                cell.newView.isHidden = false
            } else {
                cell.newView.isHidden = true
            }
            cell.timeLabel.text = "\(currentScore.clicksPerSecond) CPS"
            cell.cpsLabel.text = "\(currentScore.clicks) clicks / \(currentScore.timeTaken)s"
            cell.timestampLabel.text = "\(currentScore.date) - \(currentScore.time)"
        }

        return cell
    }
    
    @IBAction func unwindToScoreTable(segue: UIStoryboardSegue) {
        if segue.identifier == "exitClicker" {
            let source = segue.source as! ClickerViewController
            
            for score in scores {
                if score.new == true {
                    score.new = false
                }
            }
            
            scores.append(Score(timeTaken: source.time, timestamp: source.timestamp, clicks: source.clicksNeeded))
            
            scores = scores.sorted(by: { $0.clicksPerSecond > $1.clicksPerSecond })
            
            Score.saveToFile(scores: scores)
            tableView.reloadData()
        }
        
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            scores.remove(at: indexPath.row)
            Score.saveToFile(scores: scores)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
