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
    @IBOutlet weak var titleFirstLetterLabel: UILabel!
    @IBOutlet weak var titleRemainingLabel: UILabel!
    @IBOutlet weak var playerNameLabel: RegBrown!
    @IBOutlet weak var roleDescritpionLabel: UILabel!
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var popupOuterView: UIView!
    @IBOutlet weak var popupInnerView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var darknessView: UIView!
    
    var player: Player?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardBorder.layer.cornerRadius = STYLE.CornerRadius
        cardBorder.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        popupInnerView.layer.cornerRadius = STYLE.CornerRadius
        popupInnerView.backgroundColor = STYLE.Tan
        popupOuterView.layer.cornerRadius = STYLE.CornerRadius
        popupOuterView.backgroundColor = STYLE.Beige
        resetHelpView()
    }
    
    func configureCell() {
        roleIconImage.image = player?.role.image
        titleFirstLetterLabel.text = player?.role.name.firstLetter()
        titleRemainingLabel.text = player?.role.name.restOfString()
        roleDescritpionLabel.text = player?.role.description
        textView.text = player?.role.roleExplanation
        textView.setContentOffset(CGPoint.zero, animated: false)
        resetHelpView()
        loadPlayerName()
        
        if (GAME.firstNight && !(player?.playerAssigned)!) {
            assignPlayer()
        } else {
            clearSubview()
        }
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
    
    func clearSubview() {
        for subUIView in containerView.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
    }
    
    func assignPlayer() {
        let localizedActionView = AssignPlayer(frame: CGRect(x: 0, y: 0, width: 310, height: 140), withPlayer: player!)
        localizedActionView.delegate = self
        self.containerView.addSubview(localizedActionView)
    }
    
    func loadPlayerName() {
        if (player?.playerAssigned)! {
            playerNameLabel.text = "(\((player?.name)!))"
        } else {
            playerNameLabel.text = ""
        }
    }
    
    func updateCard() {
        configureCell()
    }
}
