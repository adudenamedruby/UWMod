//
//  ConfirmationPopup.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-05.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class ConfirmationPopup: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainAlertView:       UIView!
    @IBOutlet weak var headerView:          UIView!
    @IBOutlet weak var headerTitleLabel:    OldTan!
    @IBOutlet weak var alertTextLabel:      RegBrown!
    
    
    // MARK: - Variables
    
    var player:                             Player!
    var eliminatedBy:                       RoleType?
    var alternateHeaderTitle:               String?
    var alternateAlertText:                 String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainAlertView.layer.cornerRadius    = STYLE.CornerRadius
        mainAlertView.backgroundColor       = STYLE.Tan
        headerView.backgroundColor          = STYLE.Brown
        
        var headerTitle = "Confirm Elimination"

        if alternateHeaderTitle != nil {
            headerTitle = alternateHeaderTitle!
        }
        
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        if alternateAlertText != nil {
            alertTextLabel.text             = alternateAlertText!
        } else {
            alertTextLabel.text             = "Are you sure you want to eliminate \(player.name)?"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        
        if eliminatedBy != nil {
            player.killedBy = eliminatedBy
        }
        
        if GAME.wolfRoles.contains(player.roleType()) && !GAME.aWerewolfHasBeenSlain {
            GAME.aWerewolfHasBeenSlain = true
        }
        
        GAME.prepareToEliminatePlayer(victim: player)
        
        let presentingVC = self.presentingViewController
        
        self.dismiss(animated: true, completion: {
            if self.eliminatedBy != nil {
                if GAME.wolfRoles.contains(self.eliminatedBy!) {
                    GAME.werewolvesHaveKilled()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "eliminationByWerewolf"), object: nil)
                }
                
            } else if self.player.roleType() == .WolfCub {
                GAME.increasePossibleWerewolfTargets()
            }
            
            presentingVC!.dismiss(animated: false, completion: nil)
            
        })
    }
}
