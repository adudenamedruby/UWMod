//
//  GameMenuPopupVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-13.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class GameMenuPopupVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainCardView:           UIView!
    @IBOutlet weak var headerView:              UIView!
    @IBOutlet weak var headerTitleLabel:        OldTan!
    @IBOutlet weak var alertTextLabel:          RegBrown!
    
    
    // MARK: - Variables
    
    
    // MARK - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCardView.layer.cornerRadius        = STYLE.CornerRadius
        mainCardView.backgroundColor           = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        let headerTitle = "Menu"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button functionality
    
    @IBAction func okButtonPressed(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let endGameConfirm = storyboard.instantiateViewController(withIdentifier: "endGamePopup") as! EndGamePopupVC
        endGameConfirm.modalTransitionStyle = .crossDissolve
        self.present(endGameConfirm, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
