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
    @IBOutlet weak var playerNameLabel: RegularTextBrownLabel!
    @IBOutlet weak var roleDescritpionLabel: UILabel!
    
    var player: Player?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardBorder.layer.cornerRadius = STYLE.CornerRadius
        cardBorder.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
    }
    
    func configureCell() {
        roleIconImage.image = player?.role.image
        titleFirstLetterLabel.text = player?.role.name.firstLetter()
        titleRemainingLabel.text = player?.role.name.restOfString()
        roleDescritpionLabel.text = player?.role.description
        loadPlayerName()
        
        if (GAME.firstNight && !(player?.playerAssigned)!) {
            assignPlayer()
        } else {
            clearSubview()
        }
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
