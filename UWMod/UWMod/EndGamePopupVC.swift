//
//  EndGamePopupVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-06.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class EndGamePopupVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainAlertView:           UIView!
    @IBOutlet weak var headerView:              UIView!
    @IBOutlet weak var headerTitleLabel:        OldTan!
    @IBOutlet weak var alertTextLabel:          RegBrown!
    
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainAlertView.layer.cornerRadius        = STYLE.CornerRadius
        mainAlertView.backgroundColor           = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        let headerTitle                         = "End Game?"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        alertTextLabel.text                     = "Are you sure you want to end the game?"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button functions
    
    @IBAction func noButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let masterGameView = storyboard.instantiateViewController(withIdentifier: "mainMenu") as! MenuVC
        let presentingVC = self.presentingViewController
        let masterParentVC = presentingVC?.presentingViewController
        self.dismiss(animated: false, completion: { () -> Void   in
            presentingVC!.dismiss(animated: false, completion: { () -> Void in
                masterParentVC!.present(masterGameView, animated: false, completion: {
                    GAME.endGameAndReset()
                })
            })
        })
    }
}
