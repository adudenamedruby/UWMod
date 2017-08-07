//
//  VoteCounterVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-07.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class VoteCounterVC: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var mainAlertView:           UIView!
    @IBOutlet weak var headerView:              UIView!
    @IBOutlet weak var headerTitleLabel:        OldTan!
    @IBOutlet weak var alertTextLabel:          RegBrown!
    
    @IBOutlet weak var yesButton:               PMSuperButton!
    @IBOutlet weak var noButton:                PMSuperButton!
    
    // MARK: - Variables
    
    var totalPlayers                            = 0
    var majority                                = 0
    var noVotes                                 = 0
    var yesVotes                                = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPlayers                            = GAME.livingActors.count
        majority                                = Int(ceil(Double(totalPlayers) / 2))
        
        mainAlertView.layer.cornerRadius        = STYLE.CornerRadius
        mainAlertView.backgroundColor           = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        let headerTitle                         = "Vote Counter"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!,
                                                                      withColour: STYLE.Red)
        
        alertTextLabel.text                     = ""
        alertTextLabel.isHidden                 = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        yesVotes += 1
        yesButton.setTitle("\(yesVotes)", for: .normal)
        checkVote()
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        noVotes += 1
        noButton.setTitle("\(noVotes)", for: .normal)
        checkVote()
    }
    
    private func checkVote() {
        if yesVotes == majority {
            
            updateLabel(message: "The vote PASSES!\n\n Total Living: \(totalPlayers)\nYES: \(yesVotes)\nNO: \(noVotes)")
            
        } else if noVotes == majority {
            updateLabel(message: "The vote FAILS!\n\n Total Living: \(totalPlayers)\nYES: \(yesVotes)\nNO: \(noVotes)")
        }
    
    }
    
    private func updateLabel(message: String) {
        yesButton.isHidden = true
        noButton.isHidden = true
        alertTextLabel.isHidden = false
        alertTextLabel.text = message
    }

}
