//
//  WhatsNewVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-09-02.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class WhatsNewVC: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var aboutCard: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var headerTitleLabel: OldTan!
    
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        aboutCard.layer.cornerRadius        = STYLE.CornerRadius
        headerView.backgroundColor          = UIColor.WerewolfTheme.ChocolateBrown
        bottomView.backgroundColor          = UIColor.WerewolfTheme.LightTan
        
        let version = CurrentAppVersion as! String
        let headerTitle                     = "What's New (\(version))"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        textView.text = "- Fixed a minor bug where the Witch couldn't save herself at night.\n- Fixed a few timer related bugs in the day view.\n- You can now add a player without giving them a last name.\n- Modified the Seer's card at night: now, instead of showing all players, it only shows players relevant to the Seer. If not there, then that player is assumed to be a villager.... of some sort.\n- Adjusted a few variables for better game balance."
        
        textView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    @IBAction func darknessDismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
