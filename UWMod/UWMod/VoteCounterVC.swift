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
    @IBOutlet weak var ineligibleLabel: RegBrown!
    
    @IBOutlet weak var yesButton:               PMSuperButton!
    @IBOutlet weak var noButton:                PMSuperButton!
    
    // MARK: - Variables
    
    var totalPlayers                            = 0
    var majority                                = 0
    var noVotes                                 = 0
    var yesVotes                                = 0
    var ineligiblePlayers:                      String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPlayers                            = eligiblePlayersToVote()
        // ceil is used to hit the ceiling of the division. ie. 7/2 = 3.5 -> 4 as majority
        majority                                = Int(ceil(Double(totalPlayers) / 2))
        
        mainAlertView.layer.cornerRadius        = STYLE.CornerRadius
        mainAlertView.backgroundColor           = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        let headerTitle                         = "Vote Counter"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!,
                                                                      withColour: STYLE.Red)
        
        ineligibleLabel.text                    = fetchIneligiblePlayers()
        
        alertTextLabel.text                     = ""
        alertTextLabel.isHidden                 = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func eligiblePlayersToVote() -> Int {
        var tempPlayerCount = 0
        
        for player in GAME.livingActors {
            if player.canVote {
                tempPlayerCount += 1
            }
        }
        
        return tempPlayerCount
    }
    
    private func fetchIneligiblePlayers() -> String {
        var tempStr                             = "Players Ineligible to Vote:\n"
        var allPlayersCanVote                   = true
        
        for player in GAME.livingActors {
            if !player.canVote {
                tempStr = tempStr + "\(player.name) "
                allPlayersCanVote = false
            }
        }
        
        if !allPlayersCanVote {
            tempStr = "All players can vote, currently."
        }
        
        return tempStr
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
