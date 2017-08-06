//
//  ConfirmationPopup.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-05.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class ConfirmationPopup: UIViewController {

    @IBOutlet weak var mainAlertView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: OldTan!
    @IBOutlet weak var alertTextLabel: RegBrown!
    
    var player: Player!
    var eliminatedBy: RoleType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainAlertView.layer.cornerRadius = STYLE.CornerRadius
        mainAlertView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        let headerTitle = "Confirm Elimination"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        alertTextLabel.text = "Are you sure you want to eliminate \(player.name)?"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        GAME.prepareToEliminatePlayer(victim: player)
        
        let presentingVC = self.presentingViewController
        
        self.dismiss(animated: true, completion: {
            if self.eliminatedBy == .Werewolf {
                GAME.werewolfEliminationsPerNight -= 1
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "eliminationByWerewolf"), object: nil)
            }
            presentingVC!.dismiss(animated: false, completion: nil)
            
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
