//
//  EndGamePopupVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-06.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class EndGamePopupVC: UIViewController {

    @IBOutlet weak var mainAlertView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: OldTan!
    @IBOutlet weak var alertTextLabel: RegBrown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainAlertView.layer.cornerRadius = STYLE.CornerRadius
        mainAlertView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        let headerTitle = "End Game?"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        alertTextLabel.text = "Are you sure you want to end the game?"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
