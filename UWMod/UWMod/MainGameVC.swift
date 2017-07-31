//
//  MainGameVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-30.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class MainGameVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var forwardButton: PMSuperButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    let nightPhrases = ["Night falls...",
                        "The moon rises...",
                        "Another day ends...",
                        "The sky darkens..."]
    
    let daytimePhrases = ["A new dawn...",
                          "The sun rises...",
                          "The rooster crows...",
                          "Another night ends..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.alpha = 0
        self.forwardButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if GAME.currentDay < GAME.currentNight {
            self.titleLabel.textColor = UIColor.ColourTheme.ChocolateBrown
            self.titleLabel.text = daytimePhrases.randomElement()
        } else {
            self.titleLabel.textColor = UIColor.ColourTheme.Tan
            self.titleLabel.text = nightPhrases.randomElement()
        }
        
        self.titleLabel.fadeIn(completion: {
            (finished: Bool) -> Void in
            self.forwardButton.fadeIn()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetElementAlpha() {
        self.titleLabel.alpha = 0
        self.forwardButton.alpha = 0
    }
    
    @IBAction func continueForward(_ sender: Any) {
        
        if GAME.currentDay < GAME.currentNight {
            let storyboard: UIStoryboard = UIStoryboard(name: "DayPhase", bundle: nil)
            let newView = storyboard.instantiateViewController(withIdentifier: "mainDayPhase") as! DayVC
            self.present(newView, animated: true, completion: { () -> Void in
                self.resetElementAlpha()
                self.backgroundImage.image = #imageLiteral(resourceName: "nighttime")
            })
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "NightPhase", bundle: nil)
            let newView = storyboard.instantiateViewController(withIdentifier: "mainNightPhase") as! NightVC
            self.present(newView, animated: true, completion: { () -> Void in
                self.resetElementAlpha()
                self.backgroundImage.image = #imageLiteral(resourceName: "daytime")
            })
        }
    }
}
