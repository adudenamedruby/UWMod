//
//  NightCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class NightCell: TisprCardStackViewCell, UpdateCardDelegate {
    
    @IBOutlet weak var cardBorder: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var roleIconImage: UIImageView!
    @IBOutlet weak var roleTitleLabel: OldBrownRole!
    @IBOutlet weak var playerNameLabel: RegBrown!
    @IBOutlet weak var roleDescritpionLabel: UILabel!
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var popupOuterView: UIView!
    @IBOutlet weak var popupInnerView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var darknessView: UIView!
    @IBOutlet weak var headerTitleLabel: OldTan!
    
    var player: Player?
    var role: Role?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCard),
                                               name: NSNotification.Name(rawValue: "eliminationByWerewolf"),
                                               object: nil)
        
        cardBorder.layer.cornerRadius = STYLE.CornerRadius
        cardBorder.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        let headerTitle = "Role Help"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        popupInnerView.layer.cornerRadius = STYLE.CornerRadius
        popupInnerView.backgroundColor = STYLE.Tan
        popupOuterView.layer.cornerRadius = STYLE.CornerRadius
        popupOuterView.backgroundColor = STYLE.Beige
        resetHelpView()
    }
    
    func configureCell() {
        
        if GAME.firstNight {
            player = nil
            magicallyAssignLastPlayer()
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
    
    func fadePopupIn() {
        darknessView.isHidden = false
        darknessView.fadeIn(duration: 0.2, delay: 0)

        popupOuterView.isHidden = false
        popupOuterView.fadeIn(duration: 0.2, delay: 0)
    }
    
    func fadePopupOut() {
        popupOuterView.fadeOut(duration: 0.2, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.popupOuterView.isHidden = true
        })

        darknessView.fadeOut(duration: 0.2, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.darknessView.isHidden = true
        })
    }
    
    func resetHelpView() {
        popupOuterView.isHidden = true
        popupOuterView.alpha = 0
        darknessView.isHidden = true
        darknessView.alpha = 0
    }
    
    func loadPlayerName() {
        if player != nil {
            playerNameLabel.text = "(\((player?.name)!))"
        } else {
            playerNameLabel.text = ""
        }
    }
    
    func checkPlayerForLife() {
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
    
    func setupCardTextBasedOnPlayerOrRole() {
        
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
            roleIconImage.image = player?.role.image
            let roleTitle = player?.role.name
            roleTitleLabel.attributedText = roleTitle?.styleTitleLabel(withStringFont: STYLE.OldRoleFont!, withColour: STYLE.Red)
            roleDescritpionLabel.text = player?.role.description
            textView.text = player?.role.roleExplanation
            
        } else {
            roleIconImage.image = role?.image
            let roleTitle = role?.name
            roleTitleLabel.attributedText = roleTitle?.styleTitleLabel(withStringFont: STYLE.OldRoleFont!, withColour: STYLE.Red)
            roleDescritpionLabel.text = role?.description
            textView.text = role?.roleExplanation
        }
        
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func unassignedPlayerList() -> [Player] {
        var unassignedPlayerList: [Player] = []
        
        for player in GAME.availablePlayers {
            if !player.isAssigned {
                unassignedPlayerList.append(player)
            }
        }
        
        return unassignedPlayerList
    }
    
    func magicallyAssignLastPlayer() {
        let unassignedPlayers = unassignedPlayerList()
        if unassignedPlayers.count == 1 {
            // if there's only one player left unassigned, the assign him to the last role
            player = unassignedPlayers[0]
            player?.assignRole(role: GAME.availableRoster.last!)
            GAME.addPlayerToLivingActors(player: player!)
        }
    }
    
    func updateCard() {
        configureCell()
    }
    
    
    // MARK: - Manage & load specific subviews
    
    func loadSubviews() {
        clearSubview()
        
        if (GAME.firstNight && player == nil) {
            presentAssignPlayer()
            
        } else if (player?.isAlive)! {
         
            if player?.role.type == .Werewolf {
                if !GAME.firstNight && GAME.werewolfEliminationsPerNight != 0 {
                    presentWerewolfAssassination()
                }
            } else if player?.role.type == .Bodyguard && !((player?.hasActedTonight)!) {
                presentBodyguardView()
            }
        }
    }
    
    func clearSubview() {
        for subUIView in containerView.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
    }
    
    func presentAssignPlayer() {
        let localizedActionView = AssignPlayer(frame: CGRect(x: 0, y: 0, width: 310, height: 140), withRole: role!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    func presentBodyguardView() {
        let localizedActionView = BodyguardView(frame: CGRect(x: 0, y: 0, width: 310, height: 140), withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    func presentWerewolfAssassination() {
        let localizedActionView = WerewolfAssassination(frame: CGRect(x: 0, y: 0, width: 310, height: 140))
        self.containerView.addSubview(localizedActionView)
    }
}
