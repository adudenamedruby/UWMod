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
    
    @IBOutlet var phaseReportView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var eliminatedLabel: RegularTextBrownLabel!
    @IBOutlet var playersEliminatedTextView: UITextView!
    @IBOutlet var savedLabel: RegularTextBrownLabel!
    @IBOutlet var playersProtectedTextView: UITextView!
    
    
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
        
        self.phaseReportView.alpha = 0
        self.phaseReportView.layer.cornerRadius = STYLE.CornerRadius
        self.phaseReportView.backgroundColor = STYLE.Tan
        self.headerView.backgroundColor = STYLE.Brown
        self.playersEliminatedTextView.textColor = STYLE.Red
        self.playersProtectedTextView.textColor = STYLE.Green
        self.resetPhaseView()
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
            } else {
                self.titleLabel.textColor = STYLE.Tan
                self.titleLabel.text = nightPhrases.randomElement()
            }
        }
        
        self.titleLabel.fadeIn(completion: {
            (finished: Bool) -> Void in
            if GAME.firstNight {
                self.forwardButton.fadeIn(duration: 1, delay: 0)
            } else {
                self.reportPhaseEliminationResults()
            }
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
                self.resetPhaseView()
                self.backgroundImage.image = #imageLiteral(resourceName: "nighttime")
            })
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "NightPhase", bundle: nil)
            let newView = storyboard.instantiateViewController(withIdentifier: "mainNightPhase") as! MainNightVC
            self.present(newView, animated: true, completion: { () -> Void in
                self.resetElementAlpha()
                self.resetPhaseView()
                self.backgroundImage.image = #imageLiteral(resourceName: "daytime")
            })
        }
    }
    
    func resetElementAlpha() {
        self.titleLabel.alpha = 0
        self.forwardButton.alpha = 0
        self.phaseReportView.alpha = 0
    }
    
    func resetPhaseView() {
        eliminatedLabel.isHidden = true
        playersEliminatedTextView.isHidden = true
        savedLabel.isHidden = true
        playersProtectedTextView.isHidden = true
    }
    
    func reportPhaseEliminationResults() {
        // TODO: Report all players eliminated during the night
        
        if GAME.playersEliminatedThisPhase != "" || GAME.playersProtectedThisPhase != "" {
            
            if GAME.playersEliminatedThisPhase != "" {
                eliminatedLabel.isHidden = false
                playersEliminatedTextView.isHidden = false
                playersEliminatedTextView.text = GAME.playersEliminatedThisPhase
            }
            
            if GAME.playersProtectedThisPhase != "" {
                savedLabel.isHidden = false
                playersProtectedTextView.isHidden = false
                playersProtectedTextView.text = GAME.playersProtectedThisPhase
            }
            
            self.showReportCard()
        }
        
        forwardButton.fadeIn(duration: 1, delay: 0)
    }
    
    func showReportCard() {
        self.phaseReportView.fadeIn(duration: 1, delay: 0)
    }
    
    
    
}
