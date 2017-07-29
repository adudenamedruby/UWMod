//
//  RoleSelectVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-28.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class RoleSelectVC: UIViewController {
    
    @IBOutlet weak var mainCardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainCardView.layer.cornerRadius = 10

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
