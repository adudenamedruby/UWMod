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
    @IBOutlet weak var ineligibleLabel:         RegBrown!
    
    @IBOutlet weak var yesButton:               PMSuperButton!
    @IBOutlet weak var tallyButton:             PMSuperButton!
    
    // MARK: - Variables
    
    var totalPlayers                            = 0
    var noVotes                                 = 0
    var yesVotes                                = 0
    var maxVotes                                = 0
    var mayorPresent                            = false
    var ineligiblePlayers:                      String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPlayers                            = eligiblePlayersToVote()
        
        mainAlertView.layer.cornerRadius        = STYLE.CornerRadius
        mainAlertView.backgroundColor           = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        let headerTitle                         = "Vote Counter"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!,
                                                                      withColour: STYLE.Red)
        
        ineligibleLabel.text                    = fetchIneligiblePlayers()
        
        alertTextLabel.text                     = ""
        alertTextLabel.isHidden                 = true
        
        
        maxVotes = GAME.livingActors.count
        if mayorPresent {
            maxVotes += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func eligiblePlayersToVote() -> Int {
        var tempPlayerCount = 0
        
        for player in GAME.livingActors {
            if !(player.isAffectedBy(condition: .Lobotomy)) {
                tempPlayerCount += 1
            }
        }
        
        return tempPlayerCount
    }
    
    private func fetchIneligiblePlayers() -> String {
        var tempStr                             = "Players Ineligible to Vote:\n"
        var mayorVote                           = ""
        var allPlayersCanVote                   = true
        
        for player in GAME.livingActors {
            if player.isAffectedBy(condition: .Lobotomy) {
                tempStr = tempStr + "\(player.name) "
                allPlayersCanVote = false
            }
            
            if player.roleType == .Mayor {
                mayorPresent = true
                mayorVote = "\n\nRemember to count Mayor \(player.name)'s vote twice."
            }
        }
        
        if allPlayersCanVote {
            tempStr = "All players can vote... for now."
        }
        
        if mayorVote != "" {
            tempStr = tempStr + mayorVote
        }
        
        return tempStr
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        GAME.pauseTimer()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        if yesVotes < maxVotes {
            yesVotes += 1
            yesButton.setTitle("\(yesVotes)", for: .normal)
        }
    }
    
    @IBAction func correctionButton(_ sender: Any) {
        if yesVotes > 0 {
            yesVotes -= 1
        }
        
        if yesVotes == 0 {
            yesButton.setTitle("YES", for: .normal)
        } else {
            yesButton.setTitle("\(yesVotes)", for: .normal)
        }
    }
    
    
    @IBAction func tallyButtonPressed(_ sender: Any) {
        checkVote()
    }
    
    
    // TODO: Add Tally button and check for equivalency (which is failure)
    private func checkVote() {
        noVotes = totalPlayers - yesVotes
        if noVotes < 0 {
            noVotes = 0
        }
        var message = ""
        
        if yesVotes > noVotes {
            
            message = "The vote PASSES!\n\n"
            
            if yesVotes != 0 {
                message = message + "YES: \(yesVotes)\n"
            }
            
            if noVotes != 0 {
                message = message + "NO: \(noVotes)"
            }
            
        } else {
            
            message = "The vote FAILS!\n\n"
            
            if yesVotes != 0 {
                message = message + "YES: \(yesVotes)\n"
            }
            
            if noVotes != 0 {
                message = message + "NO: \(noVotes)"
            }
            
        }
        
        updateLabel(message: message)
    
    }
    
    private func updateLabel(message: String) {
        yesButton.isHidden = true
        tallyButton.isHidden = true
        alertTextLabel.isHidden = false
        alertTextLabel.text = message
    }

}
