//
//  AboutVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var aboutCard: UIView!
    @IBOutlet weak var returnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        aboutCard.layer.cornerRadius = 10
        returnButton.layer.cornerRadius = 10
    }
    
    @IBAction func dismissAboutVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
