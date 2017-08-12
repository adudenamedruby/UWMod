//
//  AlertsVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class AlertsVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainAlertView:           UIView!
    @IBOutlet weak var headerView:              UIView!
    @IBOutlet weak var headerTitleLabel:        OldTan!
    @IBOutlet weak var alertTextLabel:          RegBrown!
    
    
    // MARK: - Variables
    
    var alertName:                              String?
    var alertText:                              String?
    var withNotification:                       String?
    
    
    // MARK - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainAlertView.layer.cornerRadius        = STYLE.CornerRadius
        mainAlertView.backgroundColor           = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        headerTitleLabel.attributedText = alertName?.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        alertTextLabel.text                     = alertText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button functionality
    
    @IBAction func okButtonPressed(_ sender: Any) {
        if withNotification != nil {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: withNotification!), object: nil)
        }
        
        self.dismiss(animated: true, completion: nil)
    }

}
