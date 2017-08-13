//
//  AboutVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

class AboutVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var aboutCard:           UIView!
    @IBOutlet var headerView:               UIView!
    @IBOutlet weak var headerTitleLabel:    OldTan!
    @IBOutlet var bottomView:               UIView!
    @IBOutlet weak var returnButton:        UIButton!
    @IBOutlet weak var textLabel:           RegBrown!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        aboutCard.layer.cornerRadius        = STYLE.CornerRadius
        headerView.backgroundColor          = UIColor.WerewolfTheme.ChocolateBrown
        bottomView.backgroundColor          = UIColor.WerewolfTheme.LightTan
        
        let headerTitle                     = "About UWMod"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        let version : AnyObject! = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as AnyObject
        let build : AnyObject! = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as AnyObject

        textLabel.text = "App Design & Development\n\nSpecial thanks: Ted Alspach & Bezier Games for the use of the Ultimate Werewolf property (all role explanation and rules © Bezier Games); Andrei Pitsko for TisprCardStack; Dimitrios Alexis for help with iconography & design\n\nVersion: \(version!) (b\(build!))\nCopyright © 2017 ACME|labs"
        
    }
    
    @IBAction func dismissAboutVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
