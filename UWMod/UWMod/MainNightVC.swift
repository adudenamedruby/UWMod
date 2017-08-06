//
//  MainNightVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class MainNightVC: UIViewController, EndNightPotocol {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var endNightTitleLabel: OldTan!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerTitle = "End Night Phase?"
        endNightTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        forwardButton.alpha = 0
        backButton.alpha = 0
        endNightTitleLabel.alpha = 0

        let storyboard: UIStoryboard = UIStoryboard(name: "NightPhase", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "cardView") as! NightVC
        self.addChildViewController(collectionVC)
        collectionVC.endNightDelegate = self
        collectionVC.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
        self.containerView.addSubview(collectionVC.view)
        collectionVC.didMove(toParentViewController: self)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endNight() {
        self.containerView?.fadeOut(duration: 1, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.containerView.isHidden = true
        })
        
        fadeNightControlsIn()
    }
    
    @IBAction func acceptNightEnd(_ sender: Any) {
        GAME.finishNight()
        self.dismiss(animated: true, completion: {
            self.containerView.isHidden = false
            self.containerView.alpha = 1
        })
    }
    
    @IBAction func goBack(_ sender: Any) {
        fadeNightControlsOut()
    }
    
    func fadeNightControlsIn() {
        self.endNightTitleLabel.fadeIn(duration: 1, delay: 0)
        self.forwardButton.fadeIn(duration: 1, delay: 0)
        self.backButton.fadeIn(duration: 1, delay: 0)
    }
    
    func fadeNightControlsOut() {
        self.endNightTitleLabel.fadeOut(duration: 1, delay: 0)
        self.backButton.fadeOut(duration: 1, delay: 0)
        self.forwardButton.fadeOut(duration: 1, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.containerView.isHidden = false
            self.containerView.fadeIn()
        })
    }
}
