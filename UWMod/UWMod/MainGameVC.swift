//
//  MainGameVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-30.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class MainGameVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var forwardButton: PMSuperButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    // MARK: - Variables
    
    let nightPhrases = ["Night falls...",
                        "The moon rises...",
                        "Another day ends...",
                        "The sky darkens..."]
    
    let daytimePhrases = ["A new dawn...",
                          "The sun rises...",
                          "The rooster crows...",
                          "Another night ends..."]
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.alpha = 0
        self.forwardButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if GAME.firstNight {
            self.titleLabel.textColor = STYLE.Tan
            self.titleLabel.text = "The first night begins..."
        } else {
        
            if GAME.currentDay < GAME.currentNight {
                self.titleLabel.textColor = STYLE.Brown
                self.titleLabel.text = daytimePhrases.randomElement()
                reportNightDeaths()
            } else {
                self.titleLabel.textColor = STYLE.Tan
                self.titleLabel.text = nightPhrases.randomElement()
            }
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
    
    // MARK: - Button functions
    
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
            let newView = storyboard.instantiateViewController(withIdentifier: "mainNightPhase") as! MainNightVC
            self.present(newView, animated: true, completion: { () -> Void in
                self.resetElementAlpha()
                self.backgroundImage.image = #imageLiteral(resourceName: "daytime")
            })
        }
    }
    
    func resetElementAlpha() {
        self.titleLabel.alpha = 0
        self.forwardButton.alpha = 0
    }
    
    func reportNightDeaths() {
        // TODO: Report all players eliminated during the night
    }
    
}
