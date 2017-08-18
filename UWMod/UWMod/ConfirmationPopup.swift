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
    
    /// The player that was selected
    var chosenPlayer:                       Player!
    
    // Passed variables
    var eliminatedByType:                   RoleType?
    var actingPlayer:                       Player?
    var reason:                             SelectPlayerReason?
    var role:                               Role?
    
    var alternateHeaderTitle:               String?
    var alternateAlertText:                 String?
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainAlertView.layer.cornerRadius    = STYLE.CornerRadius
        mainAlertView.backgroundColor       = STYLE.Tan
        headerView.backgroundColor          = STYLE.Brown
        
        chosenPlayer                        = GAME.useChosenPlayer()
        
        var headerTitle                     = "Confirm Elimination"
        
        if reason != nil {
            if reason                   == .AssignPlayer {
                headerTitle             = "Confirm Assignment"
                alternateAlertText      = "Are you sure you want to assign \(chosenPlayer.name)?"
                
            } else if reason            == .BodyguardSelectProtectee {
                headerTitle             = "Confirm Protection"
                alternateAlertText      = "Are you sure you want to protect \(chosenPlayer.name)?"
            
            } else if reason            == .WerewolfElimination {
                headerTitle             = "Werewolf Target"
                alternateAlertText      = "Are you sure you want to maul \(chosenPlayer.name)?"
                
            } else if reason            == .VillageElimination {
                headerTitle             = "Village Target"
                alternateAlertText      = "Are you sure you want to lynch \(chosenPlayer.name)?"
    
            } else if reason            == .ZombieLobotomization {
                headerTitle             = "Confirm Dinner"
                alternateAlertText      = "Are you sure you want to eat \(chosenPlayer.name)'s brains?"
                
            } else if reason            == .BlobAbsorbtion {
                headerTitle             = "Confirm Absorbiton"
                alternateAlertText      = "Are you sure you want to absorb \(chosenPlayer.name)?"
                
            } else if reason            == .JoinTheCult {
                headerTitle             = "Confirm Brainwashing"
                alternateAlertText      = "Are you sure \(chosenPlayer.name)'s joining the Cult?"
                
            } else if reason            == .PriestSelectProtectee {
                headerTitle             = "Confirm Blessing"
                alternateAlertText      = "Are you sure you want to bless \(chosenPlayer.name)?"
                
            } else if reason            == .CupidLovestrike {
                headerTitle             = "Confirm Love"
                alternateAlertText      = "Are you sure you want to affect \(chosenPlayer.name) with love?"
            }
        }
        
        if alternateAlertText != nil {
            alertTextLabel.text             = alternateAlertText
        } else {
            alertTextLabel.text             = ""
        }
        
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func notify(name: String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name),
                                        object: nil)
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        
        let eliminationReasons: [SelectPlayerReason] = [.WerewolfElimination, .VillageElimination]
        
        if reason != nil {
            if eliminationReasons.contains(reason!) {
            
                if eliminatedByType != nil {
                    chosenPlayer.killedBy = eliminatedByType
                }
                
                if GAME.wolfRoles.contains(chosenPlayer.roleType()) && !GAME.aWerewolfHasBeenSlain {
                    GAME.aWerewolfHasBeenSlain = true
                }
                
                if reason == .WerewolfElimination {
                    self.notify(name: EliminationByWerewolfSuccessNotification)
                }
                
                if chosenPlayer.roleType() == .Cursed && reason == .WerewolfElimination {
                        chosenPlayer.updateRole(withRole: CURSED_WEREWOLF)
                } else {
                    GAME.prepareToEliminatePlayer(victim: chosenPlayer)
                }
                
            } else if reason == .AssignPlayer {
                chosenPlayer.assignRole(role: role!)
                GAME.addPlayerToLivingActors(player: chosenPlayer)
                
            } else if reason == .BodyguardSelectProtectee || reason == .PriestSelectProtectee {
                actingPlayer?.protect(playerToProtect: chosenPlayer, protector: actingPlayer!)
                actingPlayer?.hasActedTonight = true
                
                if reason == .PriestSelectProtectee {
                    actingPlayer?.hasUsedOneTimePower()
                }
            
            } else if reason == .ZombieLobotomization {
                actingPlayer?.eatBrains(ofVictim: chosenPlayer, zombie: actingPlayer!)
                actingPlayer?.hasActedTonight = true
                
            } else if reason == .BlobAbsorbtion {
                if !GAME.theBlobHasAbsorbed {
                    chosenPlayer.addToTeam(team: .TeamBlob)
                    GAME.theBlobHasAbsorbed = true
                }
                
            } else if reason == .JoinTheCult {
                chosenPlayer.addToTeam(team: .TeamCult)
                actingPlayer?.hasActedTonight = true
                
            } else if reason == .CupidLovestrike {
                actingPlayer?.linkPlayers(playerToLink: chosenPlayer, playerCausingLink: actingPlayer!)
            }
    
        }
        
        let presentingVC = self.presentingViewController
        
        self.dismiss(animated: true, completion: {
            if self.eliminatedByType != nil {
                if GAME.wolfRoles.contains(self.eliminatedByType!) {
                    GAME.werewolvesHaveKilled()
                    self.notify(name: EliminationByWerewolfSuccessNotification)
                }
                
            }
            
            if self.reason == .AssignPlayer {
                self.notify(name: AssignPlayerSuccessNotification)
            
            } else if self.reason == .BodyguardSelectProtectee {
                self.notify(name: BodyguardProtectingSuccessNotification)
                
            } else if self.reason == .PriestSelectProtectee {
                self.notify(name: PriestProtectSuccessNotification)
            
            } else if self.reason == .CupidLovestrike {
                var count = 0
                for playerX in GAME.availablePlayers {
                    if playerX.isAffectedBy(condition: .Lovestruck) {
                        count += 1
                    }
                    
                    if count == 2 {
                        self.actingPlayer?.hasUsedOneTimePower()
                        self.notify(name: CupidLovestrikeSecondSuccessNotification)
                    } else if count == 1 {
                        self.notify(name: CupidLovestrikeFirstSuccessNotification)
                    }
                }
            }
            
            presentingVC!.dismiss(animated: false, completion: nil)
            
        })
    }
}
