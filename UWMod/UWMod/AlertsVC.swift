//
//  AlertsVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class AlertsVC: UIViewController {

    @IBOutlet weak var mainAlertView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var alertTitleFirstLetter: UILabel!
    @IBOutlet weak var alertTitleRemainingLabel: UILabel!
    @IBOutlet weak var alertTextLabel: UILabel!
    
    var alertName: String?
    var alertText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainAlertView.layer.cornerRadius = STYLE.CornerRadius
        mainAlertView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        alertTitleFirstLetter.text = alertName?.firstLetter()
        alertTitleFirstLetter.textColor = STYLE.Red
        alertTitleRemainingLabel.text = alertName?.restOfString()
        alertTitleRemainingLabel.textColor = STYLE.Tan
        
        alertTextLabel.text = alertText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
