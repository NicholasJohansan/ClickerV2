//
//  Score.swift
//  Clicker V2
//
//  Created by Johansan on 22/8/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import Foundation

class Score: Codable {
    var timeTaken: Float
    var time: String
    var date: String
    var clicks: Int
    var clicksPerSecond: Float
    
    init(timeTaken: Float, timestamp: Date, clicks: Int) {
        self.timeTaken = timeTaken
        self.clicks = clicks
        self.clicksPerSecond = Float(self.clicks)/self.timeTaken
        
        let formatter = DateFormatter()
        
        formatter.setLocalizedDateFormatFromTemplate("d MMM yyyy")
        self.date = formatter.string(from: timestamp)
        
        formatter.setLocalizedDateFormatFromTemplate("h:mm a")
        self.time = formatter.string(from: timestamp)
    }
    
    static func getArchiveURL() -> URL {
        let plistName = "scores"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }
    
    static func saveToFile(scores: [Score]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedScores = try? propertyListEncoder.encode(scores)
        try? encodedScores?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Score]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedScoresData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedScores = try? propertyListDecoder.decode(Array<Score>.self, from: retrievedScoresData) else { return nil }
        return decodedScores
    }
}
