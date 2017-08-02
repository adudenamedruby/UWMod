//
//  MainNightVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class MainNightVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard: UIStoryboard = UIStoryboard(name: "NightPhase", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "cardView") as! NightVC
        self.addChildViewController(collectionVC)
        collectionVC.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
        self.containerView.addSubview(collectionVC.view)
        collectionVC.didMove(toParentViewController: self)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
