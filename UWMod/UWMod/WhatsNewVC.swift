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
        
        let headerTitle                     = "What's New"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        textView.text = "Hey!\n\nThanks very much for purchasing The Secret Werewolf!\n\nWhat's new? Well, this is version 1.0, so.... everything! I hope you'll have an amazing time using the app to play whatever version of Werewolf you like to play. Take a few minutes to check out available roles and the FAQ, both found in the Extras menu. Finally, try playing a small game of Werewolf at first, so you get an idea of how the app functions.\n\nMay you live through the night,\nRoux"
        
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
