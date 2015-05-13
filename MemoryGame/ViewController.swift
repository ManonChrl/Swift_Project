//
//  ViewController.swift
//  MemoryGame
//
//  Created by Manon chancereul on 14/04/2015.
//  Copyright (c) 2015 Manon chancereul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var highScoreEasy:Int = 0
    var backgroundImage:UIImage!
    var backgroundCard:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the background image if not chosen by the user in Themes
        if (backgroundImage == nil) {
            backgroundImage = UIImage(named:"back")
        }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage!)
        // Set the default background card if not chosen by the user in Themes
        if (backgroundCard == nil) {
            backgroundCard = UIImage(named:"backCard")
        }
        // Open sqlite3
        var database:COpaquePointer = nil
        let paths = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        var dataFilePath = documentsDirectory.stringByAppendingPathComponent("data.sqlite") as String
        var result = sqlite3_open(dataFilePath, &database)
        println(dataFilePath)
        if result != SQLITE_OK {
            sqlite3_close(database)
            println("Failed to open database")
            return
        }
        
        // Create the database if not exists
        let createSQL = "CREATE TABLE IF NOT EXISTS HIGHSCORE " +
        "(ID TEXT PRIMARY KEY, VALUE INTEGER, NAME TEXT);"
        var errMsg:UnsafeMutablePointer<Int8> = nil
        result = sqlite3_exec(database, createSQL, nil, nil, &errMsg);
        if (result != SQLITE_OK) {
            sqlite3_close(database)
            println("Failed to create table")
            return
        }
        
        // Close database
        sqlite3_close(database)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Send the theme chosen to the other views
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "easy") {
            var VCeasy = segue.destinationViewController as! ViewControllerEasy;
            VCeasy.backgroundImage = backgroundImage
            VCeasy.cardBack = backgroundCard
        }
        if(segue.identifier == "medium"){
            var VCmedium = segue.destinationViewController as! ViewControllerMedium;
            VCmedium.backgroundImage = backgroundImage
            VCmedium.cardBack = backgroundCard
        }
        if(segue.identifier == "hard"){
            var VChard = segue.destinationViewController as! ViewControllerHard;
            VChard.backgroundImage = backgroundImage
            VChard.cardBack = backgroundCard
        }
        if(segue.identifier == "highScore"){
            var VChs = segue.destinationViewController as! ViewControllerHighScore;
            VChs.backgroundImage = backgroundImage
            VChs.backgroundCard = backgroundCard
        }
        if(segue.identifier == "themes"){
            var VCt = segue.destinationViewController as! ViewControllerThemes;
            VCt.backgroundImage = backgroundImage
            VCt.backgroundCard = backgroundCard
        }
    }
    
    
    
}
