//
//  MainGameVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-30.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class MainGameVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var forwardButton: PMSuperButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.alpha = 0
        self.forwardButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.titleLabel.fadeIn(completion: {
            (finished: Bool) -> Void in
            self.forwardButton.fadeIn()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueForward(_ sender: Any) {
        
        if GAME.currentDay < GAME.currentNight {
            let storyboard: UIStoryboard = UIStoryboard(name: "DayPhase", bundle: nil)
            let newView = storyboard.instantiateViewController(withIdentifier: "mainDayPhase") as! NightVC
            self.present(newView, animated: true, completion: nil)
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "NightPhase", bundle: nil)
            let newView = storyboard.instantiateViewController(withIdentifier: "mainNightPhase") as! NightVC
            self.present(newView, animated: true, completion: nil)
        }
    }
    
    
}
