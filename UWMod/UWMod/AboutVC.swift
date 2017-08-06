//
//  AboutVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var aboutCard: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: OldTan!
    @IBOutlet var bottomView: UIView!
    @IBOutlet weak var returnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        aboutCard.layer.cornerRadius = STYLE.CornerRadius
        headerView.backgroundColor = UIColor.WerewolfTheme.ChocolateBrown
        bottomView.backgroundColor = UIColor.WerewolfTheme.LightTan
        
        let headerTitle = "About UWMod"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
    }
    
    @IBAction func dismissAboutVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
