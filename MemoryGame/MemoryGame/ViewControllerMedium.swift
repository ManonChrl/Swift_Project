//
//  ViewControllerMedium.swift
//  MemoryGame
//
//  Created by Manon chancereul on 15/04/2015.
//  Copyright (c) 2015 Manon chancereul. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewControllerMedium: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    @IBOutlet weak var button17: UIButton!
    @IBOutlet weak var button18: UIButton!
    @IBOutlet weak var button19: UIButton!
    @IBOutlet weak var button20: UIButton!
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button24: UIButton!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var cardBack:UIImage!
    
    var buttons:[UIButton] = []
    
    var imageTable = [UIImage(named: "banana"),UIImage(named: "cherry"),UIImage(named: "coco"),UIImage(named: "strawberry"),UIImage(named: "pineapple"),UIImage(named: "pear"),UIImage(named: "grape"),UIImage(named: "orange"),UIImage(named: "banana"),UIImage(named: "cherry"),UIImage(named: "coco"),UIImage(named: "strawberry"),UIImage(named: "pineapple"),UIImage(named: "pear"),UIImage(named: "grape"),UIImage(named: "orange"),UIImage(named: "apple"),UIImage(named: "kiwi"),UIImage(named: "blueberry"),UIImage(named: "apricot"),UIImage(named: "apple"),UIImage(named: "kiwi"),UIImage(named: "blueberry"),UIImage(named: "apricot")]
    
    var numberOfCard = 0
    var numberCardShowed = 0
    var score = 0
    var timer = NSTimer()
    var timerGame = NSTimer()
    var counter = 90
    
    var card1:UIButton!,card2:UIButton!
    
    private var winSoundID: SystemSoundID = 0
    private var heartbeatSoundID: SystemSoundID = 0
    private var buzzerSoundID: SystemSoundID = 0
    
    var backgroundImage:UIImage!
    
    // Function that suffle an array
    func shuffleArray<T>(var array: [T]) -> [T] {
        for index in reverse(0..<array.count) {
            let randomIndex = Int(arc4random_uniform(UInt32(index)))
            (array[index], array[randomIndex]) = (array[randomIndex], array[index])
        }
        return array
    }
    
    // Put back the cardBack image to the two cards
    func hideCards(){
        UIView.transitionWithView(card1.imageView!, duration: 0.25, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: {
            self.card1.setImage(self.cardBack, forState: .Normal)
            }, completion: { (fininshed: Bool) -> () in
        })
        UIView.transitionWithView(card2.imageView!, duration: 0.25, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: {
            self.card2.setImage(self.cardBack, forState: .Normal)
            }, completion: { (fininshed: Bool) -> () in
                //when animation over, enable buttons
                self.enableButton()
        })
    }
    
    //Function to play win sound
    func playWinSound() {
        if winSoundID == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("win", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &winSoundID)
        }
        AudioServicesPlaySystemSound(winSoundID)
    }
    
    //Function to play heartbeat sound
    func playHearbeatSound() {
        if heartbeatSoundID == 0 {
            let sound2URL = NSBundle.mainBundle().URLForResource("heartbeat", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(sound2URL, &heartbeatSoundID)
        }
        AudioServicesPlaySystemSound(heartbeatSoundID)
    }
    
    //Function to play buzzer sound
    func playBuzzerSound() {
        if buzzerSoundID == 0 {
            let sound3URL = NSBundle.mainBundle().URLForResource("buzzer", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(sound3URL, &buzzerSoundID)
        }
        AudioServicesPlaySystemSound(buzzerSoundID)
    }
    
    // Delete the cards when user finds two similar
    func deleteCards(){
        card1.hidden = true
        card2.hidden = true
        enableButton()
    }
    
    // Disable all the buttons
    func disableButton(){
        for button in buttons {
            button.enabled = false
        }
    }
    
    // Enable the button of the cards still hidden
    func enableButton(){
        for button in buttons {
            if(button.imageView?.image?.hashValue == cardBack?.hashValue){
                button.enabled = true }
        }
    }
    
    // Begin with all cards not hidden and with cardBack image
    func initCards(sender:UIButton){
        sender.setImage(cardBack, forState: .Normal)
        sender.hidden = false
    }
    
    // Save the high score and the name associated
    func saveHS(alert:UIAlertController){
        // reset SQL to insert another value
        let SQLITE_TRANSIENT = sqlite3_destructor_type(COpaquePointer(bitPattern: -1))
        // Get name from textfield
        let textField = alert.textFields![0] as! UITextField
        // Open sqlite3
        var database:COpaquePointer = nil
        let paths = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        var dataFilePath = documentsDirectory.stringByAppendingPathComponent("data.sqlite") as String
        var result = sqlite3_open(dataFilePath, &database)
        if result != SQLITE_OK {
            sqlite3_close(database)
            println("Failed to open database")
            return
        }
        // Update the high score medium in database and the name
        let update = "INSERT OR REPLACE INTO HIGHSCORE " +
        "VALUES (?, ?, ?);"
        var statement:COpaquePointer = nil
        if sqlite3_prepare_v2(database, update, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, "medium", -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(statement, 2, Int32(score))
            sqlite3_bind_text(statement, 3, textField.text, -1, SQLITE_TRANSIENT)
            println("scoreMaxMedium in database")
            
        }
        if sqlite3_step(statement) != SQLITE_DONE {
            println("Error updating table")
            sqlite3_close(database)
            return
        }
        // Close the database
        sqlite3_close(database)
    }
    
    // Update the timer until counter = 0
    func updateTimer(dt:NSTimer){
        // decrease of one the counter
        counter--
        timerLabel.text = "\(counter)"
        if(counter==10){
            playHearbeatSound()
        }
        if counter==0{
            // End of game
            timerGame.invalidate()
            playBuzzerSound()
            let alertLose:UIAlertController!
            alertLose = UIAlertController(title: "You lose ! ",
                message: "No time left !",
                preferredStyle: .Alert)
            let actionNewGame = UIAlertAction(title: "New Game", style: .Default) { action -> Void in
                // Start a new game
                self.viewDidLoad()
            }
            let actionFinish = UIAlertAction(title: "Back", style: .Default) { action -> Void in
                // Go back to main view
                self.performSegueWithIdentifier("finishMedium", sender: self)
            }
            alertLose.addAction(actionFinish)
            alertLose.addAction(actionNewGame)
            presentViewController(alertLose, animated: true, completion: nil)
        }
    }
    
    
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
        var result = sqlite3_open(dataFilePath, &database)
        
        if result != SQLITE_OK {
            sqlite3_close(database)
            println("Failed to open database")
            return
        }
        // Get the medium high score
        var statement:COpaquePointer = nil
        let query = "SELECT * FROM HIGHSCORE WHERE ID = 'medium'"
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                // Put the medium high score in the label
                highScoreLabel.text = String(sqlite3_column_int(statement, 1))
            }
            sqlite3_finalize(statement)
        }
        // Close the database
        sqlite3_close(database)
        
        // Reset variables
        score = 0
        numberCardShowed = 0
        counter = 90
        imageTable = shuffleArray(imageTable)
        scoreLabel.text = String(score)
        
        // Instanciate array of buttons
        buttons = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11,button12,button13,button14,button15,button16,button17,button18,button19,button20,button21,button22,button23,button24]
        
        // Initialize all cards
        for button in buttons {
            initCards(button)
        }
        // Enable all buttons
        enableButton()
        
        //Start timer game
        timerGame = NSTimer.scheduledTimerWithTimeInterval(1.0
            , target: self, selector: Selector("updateTimer:"), userInfo: nil, repeats: true)
    }
    
    func mainFunction (button: UIButton) {
        // check if it is the first card chosen by the user
        if numberOfCard == 0 {
            card1 = button
        } else {
            card2 = button
        }
        numberOfCard++
        // if two cards had been chosen
        if(numberOfCard==2){
            // if it is not the same card (button)
            if(card1 != card2){
                // the two cards chosen had same picture
                if(card1.imageView?.image?.hashValue == card2.imageView?.image?.hashValue){
                    numberCardShowed+=2
                    score+=10
                    // disable all buttons
                    disableButton()
                    // hide cards chosen and enable buttons
                    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("deleteCards"), userInfo: nil, repeats: false)
                    // this is the end of the game
                    if(numberCardShowed==24){
                        timerGame.invalidate()
                        score+=counter
                        playWinSound()
                        var alertWin:UIAlertController!
                        var actionNewGame = UIAlertAction()
                        var actionFinish = UIAlertAction()
                        // if the user beats the high score
                        if(score>highScoreLabel.text?.toInt()){
                            // Alert the user that he has beaten the high score
                            alertWin = UIAlertController(title: "Congratulation !",
                                message: "You beat the high score with \(score)",
                                preferredStyle: .Alert)
                            alertWin.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                                textField.text = "Your name here"
                            })
                            actionNewGame = UIAlertAction(title: "New Game", style: .Default) { action -> Void in
                                self.saveHS(alertWin)
                                // prepare a new game
                                self.viewDidLoad()
                            }
                            actionFinish = UIAlertAction(title: "Back", style: .Default) { action -> Void in
                                self.saveHS(alertWin)
                                // Go back to main view
                                self.performSegueWithIdentifier("finishMedium", sender: self)
                            }
                        } else {
                            // Alert the user that he won
                            alertWin = UIAlertController(title: "Congratulation ! ",message: "You score is \(score)",
                                preferredStyle: .Alert)
                            
                            actionNewGame = UIAlertAction(title: "New Game", style: .Default) { action -> Void in
                                // prepare a new game
                                self.viewDidLoad()
                            }
                            actionFinish = UIAlertAction(title: "Back", style: .Default) { action -> Void in
                                // Go back to main view
                                self.performSegueWithIdentifier("finishMedium", sender: self)
                            }
                        }
                        
                        alertWin.addAction(actionFinish)
                        alertWin.addAction(actionNewGame)
                        presentViewController(alertWin, animated: true, completion: nil)
                    }
                } else {
                    // the two cards have not the same picture
                    if score>0 {
                        score-=2
                    }
                    // disable all buttons
                    disableButton()
                    // flip card over and enable buttons
                    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("hideCards"), userInfo: nil, repeats: false)
                }
                numberOfCard = 0
                scoreLabel.text = String(score)
            } else {
                numberOfCard = 1
            }
        }
    }
    
    @IBAction func finishTapped(sender: UIButton) {
        timerGame.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // flip over cards to show the picture
    func animationCards(sender:UIButton,position: Int){
        if(sender.imageView?.image?.hashValue == cardBack.hashValue){
            UIView.transitionWithView(sender.imageView!, duration: 0.25, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: {
                // change the image of the card with transition
                sender.setImage(self.imageTable[position], forState: .Normal)
                }, completion: { (fininshed: Bool) -> () in
            })
        }
    }
    
    
    @IBAction func button1tapped(sender: UIButton) {
        animationCards(sender,position: 0)
        mainFunction(sender)
    }
    
    @IBAction func button2tapped(sender: UIButton) {
        animationCards(sender,position: 1)
        mainFunction(sender)
    }
    
    @IBAction func button3tapped(sender: UIButton) {
        animationCards(sender,position: 2)
        mainFunction(sender)
    }
    
    @IBAction func button4tapped(sender: UIButton) {
        animationCards(sender,position: 3)
        mainFunction(sender)
    }
    
    @IBAction func button5tapped(sender: UIButton) {
        animationCards(sender,position: 4)
        mainFunction(sender)
    }
    
    @IBAction func button6tapped(sender: UIButton) {
        animationCards(sender,position: 5)
        mainFunction(sender)
    }
    
    @IBAction func button7tapped(sender: UIButton) {
        animationCards(sender,position: 6)
        mainFunction(sender)
    }
    
    @IBAction func button8tapped(sender: UIButton) {
        animationCards(sender,position: 7)
        mainFunction(sender)
    }
    
    @IBAction func button9tapped(sender: UIButton) {
        animationCards(sender,position: 8)
        mainFunction(sender)
    }
    
    @IBAction func button10tapped(sender: UIButton) {
        animationCards(sender,position: 9)
        mainFunction(sender)
    }
    
    @IBAction func button11tapped(sender: UIButton) {
        animationCards(sender,position: 10)
        mainFunction(sender)
    }
    
    @IBAction func button12tapped(sender: UIButton) {
        animationCards(sender,position: 11)
        mainFunction(sender)
    }
    
    @IBAction func button13tapped(sender: UIButton) {
        animationCards(sender,position: 12)
        mainFunction(sender)
    }
    
    @IBAction func button14tapped(sender: UIButton) {
        animationCards(sender,position: 13)
        mainFunction(sender)
    }
    
    @IBAction func button15tapped(sender: UIButton) {
        animationCards(sender,position: 14)
        mainFunction(sender)
    }
    
    @IBAction func button16tapped(sender: UIButton) {
        animationCards(sender,position: 15)
        mainFunction(sender)
    }
    
    @IBAction func button17tapped(sender: UIButton) {
        animationCards(sender,position: 16)
        mainFunction(sender)
    }
    
    @IBAction func button18tapped(sender: UIButton) {
        animationCards(sender,position: 17)
        mainFunction(sender)
    }
    
    @IBAction func button19tapped(sender: UIButton) {
        animationCards(sender,position: 18)
        mainFunction(sender)
    }
    
    @IBAction func button20tapped(sender: UIButton) {
        animationCards(sender,position: 19)
        mainFunction(sender)
    }
    
    @IBAction func button21tapped(sender: UIButton) {
        animationCards(sender,position: 20)
        mainFunction(sender)
    }
    
    @IBAction func button22tapped(sender: UIButton) {
        animationCards(sender,position: 21)
        mainFunction(sender)
    }
    
    @IBAction func button23tapped(sender: UIButton) {
        animationCards(sender,position: 22)
        mainFunction(sender)
    }
    
    @IBAction func button24tapped(sender: UIButton) {
        animationCards(sender,position: 23)
        mainFunction(sender)
    }
    
    
    // Send back the theme chosen to the main view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "finishMedium") {
            var VC = segue.destinationViewController as! ViewController;
            VC.backgroundImage = backgroundImage
            VC.backgroundCard = cardBack
        }
    }
    
}
