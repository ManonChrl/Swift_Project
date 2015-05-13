//
//  ViewControllerThemes.swift
//  MemoryGame
//
//  Created by Manon chancereul on 22/04/2015.
//  Copyright (c) 2015 Manon chancereul. All rights reserved.
//

import UIKit

class ViewControllerThemes: UIViewController {
    
    var backgroundImage:UIImage!
    var backgroundCard:UIImage!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    
    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    @IBOutlet weak var card3: UIButton!
    
    var buttons:[UIButton] = []
    var cards:[UIButton] = []
    
    // Put a border around the button of the background image chosen
    func borderBackground(){
        for button in buttons {
            if(button.currentBackgroundImage?.hashValue == backgroundImage?.hashValue){
                button.layer.borderColor = UIColor.whiteColor().CGColor
                button.layer.borderWidth = 5
            }
        }
    }
    
    // Put a border around the button of the card image chosen
    func borderCards(){
        for card in cards {
            if(card.currentBackgroundImage?.hashValue == backgroundCard?.hashValue){
                card.layer.borderColor = UIColor.redColor().CGColor
                card.layer.borderWidth = 5
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        buttons = [button1,button2,button3,button4,button5,button6]
        cards = [card1,card2,card3]
        // Put a border around the button of the background image chosen
        borderBackground()
        // Put a border around the button of the card image chosen
        borderCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // remove the border of all the background image
    func removeBorder(){
        for button in buttons {
            button.layer.borderColor = UIColor.whiteColor().CGColor
            button.layer.borderWidth = 0
        }
    }
    
    // remove the border of all the card image
    func removeBorderCard(){
        for card in cards {
            card.layer.borderColor = UIColor.whiteColor().CGColor
            card.layer.borderWidth = 0
        }
    }
    
    @IBAction func b1tapped(sender: UIButton) {
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        backgroundImage = UIImage(named: "back")
        // remove all borders from background image
        removeBorder()
        // put border on background image chosen
        sender.layer.borderColor = UIColor.whiteColor().CGColor
        sender.layer.borderWidth = 5
    }
    
    @IBAction func b2tapped(sender: UIButton) {
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1")!)
        backgroundImage = UIImage(named: "back1")
        // remove all borders from background image
        removeBorder()
        // put border on background image chosen
        sender.layer.borderColor = UIColor.whiteColor().CGColor
        sender.layer.borderWidth = 5
    }
    
    @IBAction func b3tapped(sender: UIButton) {
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back2")!)
        backgroundImage = UIImage(named: "back2")
        // remove all borders from background image
        removeBorder()
        // put border on background image chosen
        sender.layer.borderColor = UIColor.whiteColor().CGColor
        sender.layer.borderWidth = 5
    }
    
    @IBAction func b4tapped(sender: UIButton) {
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back3")!)
        backgroundImage = UIImage(named: "back3")
        // remove all borders from background image
        removeBorder()
        // put border on background image chosen
        sender.layer.borderColor = UIColor.whiteColor().CGColor
        sender.layer.borderWidth = 5
    }
    
    @IBAction func b5tapped(sender: UIButton) {
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back4")!)
        backgroundImage = UIImage(named: "back4")
        // remove all borders from background image
        removeBorder()
        // put border on background image chosen
        sender.layer.borderColor = UIColor.whiteColor().CGColor
        sender.layer.borderWidth = 5
    }
    
    @IBAction func b6tapped(sender: UIButton) {
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back5")!)
        backgroundImage = UIImage(named: "back5")
        // remove all borders from background image
        removeBorder()
        // put border on background image chosen
        sender.layer.borderColor = UIColor.whiteColor().CGColor
        sender.layer.borderWidth = 5
    }
    
    
    @IBAction func card1tapped(sender: UIButton) {
        // remove all borders from cards image
        removeBorderCard()
        // put border on card image chosen
        sender.layer.borderColor = UIColor.redColor().CGColor
        sender.layer.borderWidth = 5
        // Set the background card
        backgroundCard = UIImage(named: "backCard")
    }
    
    @IBAction func card2tapped(sender: UIButton) {
        // remove all borders from cards image
        removeBorderCard()
        // put border on card image chosen
        sender.layer.borderColor = UIColor.redColor().CGColor
        sender.layer.borderWidth = 5
        // Set the background card
        backgroundCard = UIImage(named: "back6")
    }
    @IBAction func card3tapped(sender: UIButton) {
        // remove all borders from cards image
        removeBorderCard()
        // put border on card image chosen
        sender.layer.borderColor = UIColor.redColor().CGColor
        sender.layer.borderWidth = 5
        // Set the background card
        backgroundCard = UIImage(named: "back7")
    }
    
    
    
    @IBAction func buttonSave(sender: UIButton) {
    }
    
    // Send back the theme choosen to the main view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "saveThemes") {
            var VC = segue.destinationViewController as! ViewController;
            VC.backgroundImage = backgroundImage
            VC.backgroundCard = backgroundCard
        }
    }
    
}
