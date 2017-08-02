//
//  RoleExplanationVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-02.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class RoleExplanationVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var headerCardView: UIView!
    @IBOutlet weak var firstLetterLabel: OldTextRedLabel!
    @IBOutlet weak var remainingTitleLabel: OldTextTanLabel!
    @IBOutlet weak var backButton: PMSuperButton!
    @IBOutlet weak var scrollTextView: UITextView!
    
    
    // MARK: - Variables
    
    var alertInfo: BasicAlertObject!
    
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerCardView.backgroundColor = STYLE.Brown
        
        firstLetterLabel.text = alertInfo.title.firstLetter()
        remainingTitleLabel.text = alertInfo.title.restOfString()
        scrollTextView.text = alertInfo.text
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
