//
//  RoleClarificationPopupVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-13.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class RoleClarificationPopupVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainCardView:            UIView!
    @IBOutlet weak var headerView:              UIView!
    @IBOutlet weak var headerTitleLabel:        OldBrownRole!
    @IBOutlet weak var roleDescriptionLabel:    UITextView!
    @IBOutlet weak var roleImage:               UIImageView!
    
    
    // MARK: - Variables
    var player:                                 Player!
    var roleInfo:                               Role!
    
    // MARK - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCardView.layer.cornerRadius         = STYLE.CornerRadius
        mainCardView.backgroundColor            = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        player                                  = GAME.useChosenPlayer()
        roleInfo                                = player.role
        
        let headerTitle = "\(roleInfo.name)"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldRoleFont!, withColour: STYLE.Red)
        
        roleDescriptionLabel.attributedText = roleInfo.roleExplanation
        roleImage.image = roleInfo.image
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button functionality
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
