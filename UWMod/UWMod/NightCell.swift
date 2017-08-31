//
//  NightCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class NightCell: TisprCardStackViewCell, UpdateCardDelegate {
    
    @IBOutlet weak var cardBorder:              UIView!
    @IBOutlet weak var headerView:              UIView!
    @IBOutlet weak var containerView:           UIView!
    @IBOutlet weak var roleIconImage:           UIImageView!
    @IBOutlet weak var roleTitleLabel:          OldBrownRole!
    @IBOutlet weak var playerNameLabel:         RegBrown!
    @IBOutlet weak var roleDescritpionLabel:    UILabel!
    
    @IBOutlet weak var helpButton:              UIButton!
    @IBOutlet weak var popupOuterView:          UIView!
    @IBOutlet weak var popupInnerView:          UIView!
    @IBOutlet weak var textView:                UITextView!
    @IBOutlet weak var darknessView:            UIView!
    @IBOutlet weak var headerTitleLabel:        OldTan!
    
    public var player:                          Player?
    public var role:                            Role?
    
    var actionViewFrame:                        CGRect!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardBorder.layer.cornerRadius = STYLE.CornerRadius
        cardBorder.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        let headerTitle = "Role Help"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        popupInnerView.layer.cornerRadius = STYLE.CornerRadius
        popupInnerView.backgroundColor = STYLE.Tan
        popupOuterView.layer.cornerRadius = STYLE.CornerRadius
        popupOuterView.backgroundColor = STYLE.Beige
        
        actionViewFrame = CGRect(x: 0,
                                 y: 0,
                                 width: self.containerView.frame.size.width,
                                 height: self.containerView.frame.size.height)
        
        resetHelpView()
    }
    
    public func configureCell() {
        
        if GAME.firstNight {
            player = nil
            if GAME.shouldPerformMagicAssignment() {
                GAME.magicVillagerAssignment()
            }
        }
        
        resetHelpView()
        setupCardTextBasedOnPlayerOrRole()
        loadPlayerName()
        checkPlayerForLife()
        loadSubviews()
    }
    
    @IBAction func helpPressed(_ sender: Any) {
        fadePopupIn()
    }
    @IBAction func backButtonPRessed(_ sender: Any) {
        fadePopupOut()
    }
    
    private func fadePopupIn() {
        darknessView.isHidden = false
        darknessView.fadeIn(duration: 0.2, delay: 0)

        popupOuterView.isHidden = false
        popupOuterView.fadeIn(duration: 0.2, delay: 0)
    }
    
    private func fadePopupOut() {
        popupOuterView.fadeOut(duration: 0.2, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.popupOuterView.isHidden = true
        })

        darknessView.fadeOut(duration: 0.2, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.darknessView.isHidden = true
        })
    }
    
    private func resetHelpView() {
        popupOuterView.isHidden = true
        popupOuterView.alpha = 0
        darknessView.isHidden = true
        darknessView.alpha = 0
    }
    
    private func loadPlayerName() {
        if player != nil {
            playerNameLabel.text = "(\((player?.name)!))"
            playerNameLabel.alpha = 1
            playerNameLabel.textColor = STYLE.Brown
        } else {
            playerNameLabel.text = ""
        }
    }
    
    private func checkPlayerForLife() {
        if player != nil {
            if !(player?.isAlive)! {
                roleTitleLabel.textColor = STYLE.Grey
                roleTitleLabel.alpha = 0.5
                playerNameLabel.textColor = STYLE.Grey
                playerNameLabel.alpha = 0.5
                roleDescritpionLabel.textColor = STYLE.Grey
                roleDescritpionLabel.alpha = 0.5
            }
        }
    }
    
    private func setupCardTextBasedOnPlayerOrRole() {
        
        if GAME.firstNight {
            for player in GAME.availablePlayers {
                if player.isAssigned {
                    if player.role === role {
                        self.player = player
                    }
                }
            }
        }
        
        if player != nil {
            roleIconImage.image = player?.roleImage
            let roleTitle = player?.roleName
            roleTitleLabel.attributedText = roleTitle?.styleTitleLabel(withStringFont: STYLE.OldRoleFont!, withColour: STYLE.Red)
            roleTitleLabel.alpha = 1
            roleDescritpionLabel.text = player?.roleDescription
            roleDescritpionLabel.alpha = 1
            roleDescritpionLabel.textColor = STYLE.Brown
            textView.attributedText = player?.roleExplanation
            
        } else {
            roleIconImage.image = role?.image
            let roleTitle = role?.name
            roleTitleLabel.attributedText = roleTitle?.styleTitleLabel(withStringFont: STYLE.OldRoleFont!, withColour: STYLE.Red)
            roleDescritpionLabel.text = role?.description
            textView.attributedText = role?.roleExplanation
        }
        
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    public func updateCard() {
        configureCell()
    }
    
    
    // MARK: - Manage & load specific subviews
    
    private func loadSubviews() {
        clearSubview()
        
        if (GAME.firstNight && player == nil) {
            presentAssignPlayer()
            
        } else if (player?.isAlive)! {
         
            if GAME.wolfRoles.contains((player?.roleType)!) {
                if !GAME.firstNight {
                    if GAME.werewolfEliminationsThisNight != 0 {
                        presentWerewolfAssassination()
                    }
                }
                
            } else if player?.roleType == .Ghost {
                GAME.prepareToEliminatePlayer(victim: player!)
            
            } else if player?.roleType == .Bodyguard && !((player?.hasActedTonight)!) && !GAME.firstNight {
                presentBodyguardView()
                
            } else if player?.roleType == .Seer && !GAME.firstNight {
                presentSeerView()
                
            } else if player?.roleType == .Zombie && !GAME.firstNight {
                presentZombieView()
                
//            } else if (player?.team.contains(.TeamBlob))! && !GAME.theBlobHasAbsorbed {
            } else if player?.roleType == .TheBlob && !GAME.theBlobHasAbsorbed && !GAME.firstNight {
                presentBlobView()
                
            } else if player?.roleType == .CultLeader && !(player?.hasActedTonight)! && !GAME.firstNight {
                presentJoinCultView()
                
            } else if player?.roleType == .Sorceress && !GAME.firstNight {
                presentSorceressView()
                
            } else if player?.roleType == .Priest && !((player?.rolePowerUsed)!) && !GAME.firstNight {
                presentPriestView()
                
            } else if player?.roleType == .Cupid && !((player?.rolePowerUsed)!) {
                presentCupidView()
                
            } else if player?.roleType == .Spellcaster && !((player?.hasActedTonight)!) {
                presentSpellcasterView()
                
            } else if player?.roleType == .VirginiaWoolf && !((player?.hasActedTonight)!) {
                presentVirginiasView()
                
            } else if player?.roleType == .Troublemaker && !((player?.hasActedTonight)!) && !(player?.rolePowerUsed)! && !GAME.firstNight {
                presentTroublemakerView()
                
            } else if player?.roleType == .Witch && !(player?.rolePowerUsed)! && !GAME.firstNight {
                
                if (player?.playersIneligibleForEffect[.Protection] == nil) {
                    presentWitchView()
                } else if (player?.playersIneligibleForEffect[.Poison] == nil) {
                    presentWitchView()
                }
        
            }
        }
    }
    
    private func clearSubview() {
        for subUIView in containerView.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
    }
    
    private func presentAssignPlayer() {
        let localizedActionView = AssignPlayer(frame: actionViewFrame, withRole: role!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentBodyguardView() {
        let localizedActionView = BodyguardView(frame: actionViewFrame, withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentWerewolfAssassination() {
        let localizedActionView = WerewolfAssassination(frame: actionViewFrame)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentSeerView() {
        let localizedActionView = SeerInspection(frame: actionViewFrame)
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentZombieView() {
        let localizedActionView = ZombieLobotomy(frame: actionViewFrame, withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentBlobView() {
        let localizedActionView = BlobAbsorbtion(frame: actionViewFrame)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentJoinCultView() {
        let localizedActionView = JoinCultView(frame: actionViewFrame)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentSorceressView() {
        let localizedActionView = SorceressView(frame: actionViewFrame)
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentPriestView() {
        let localizedActionView = PriestView(frame: actionViewFrame, withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentCupidView() {
        let localizedActionView = CupidView(frame: actionViewFrame, withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentSpellcasterView() {
        let localizedActionView = SpellcasterView(frame: actionViewFrame, withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentVirginiasView() {
        let localizedActionView = VirginiasView(frame: actionViewFrame, withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentTroublemakerView() {
        let localizedActionView = TroublemakerView(frame: actionViewFrame, withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    private func presentWitchView() {
        let localizedActionView = WitchView(frame: actionViewFrame, withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
}
