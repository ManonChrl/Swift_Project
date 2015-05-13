//
//  ViewControllerHighScore.swift
//  MemoryGame
//
//  Created by Manon chancereul on 14/04/2015.
//  Copyright (c) 2015 Manon chancereul. All rights reserved.
//

import UIKit

class ViewControllerHighScore: UIViewController {
    
    @IBOutlet weak var easyLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var hardLabel: UILabel!
    
    var backgroundImage:UIImage!
    var backgroundCard:UIImage!
    
    @IBOutlet weak var easyNameLabel: UILabel!
    @IBOutlet weak var mediumNameLabel: UILabel!
    @IBOutlet weak var hardNameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the background image
        if (backgroundImage != nil) {
            self.view.backgroundColor = UIColor(patternImage: backgroundImage!)
        }
        // Open the database
        var database:COpaquePointer = nil
        let paths = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        
        var dataFilePath = documentsDirectory.stringByAppendingPathComponent("data.sqlite") as String
        println(dataFilePath)
        var result = sqlite3_open(dataFilePath, &database)
        
        if result != SQLITE_OK {
            sqlite3_close(database)
            println("Failed to open database")
            return
        }
        // Get all the high score
        var statement:COpaquePointer = nil
        let easyQuery = "SELECT * FROM HIGHSCORE WHERE ID = 'easy'"
        if sqlite3_prepare_v2(database, easyQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                easyLabel.text = String(sqlite3_column_int(statement, 1))
                easyNameLabel.text = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement,2)))
            }
            sqlite3_finalize(statement)
        }
        let mediumQuery = "SELECT * FROM HIGHSCORE WHERE ID = 'medium'"
        if sqlite3_prepare_v2(database, mediumQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                mediumLabel.text = String(sqlite3_column_int(statement, 1))
                mediumNameLabel.text = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement,2)))
            }
            sqlite3_finalize(statement)
        }
        let hardQuery = "SELECT * FROM HIGHSCORE WHERE ID = 'hard'"
        if sqlite3_prepare_v2(database, hardQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                hardLabel.text = String(sqlite3_column_int(statement, 1))
                hardNameLabel.text = String.fromCString(UnsafePointer<Int8>(sqlite3_column_text(statement,2)))
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(database)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Send back the theme chosen to the main view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "finishHighScore") {
            var VC = segue.destinationViewController as! ViewController;
            VC.backgroundImage = backgroundImage
            VC.backgroundCard = backgroundCard
        }
    }
    
}
