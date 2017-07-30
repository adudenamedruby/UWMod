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
    @IBOutlet weak var backButton: PMSuperButton!
    @IBOutlet weak var forwardButton: PMSuperButton!
    
    let transition = CircularTransition()
    var players: [Player]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainCardView.layer.cornerRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGameButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        let storyboard: UIStoryboard = UIStoryboard(name: "NightPhase", bundle: nil)
        let newView = storyboard.instantiateViewController(withIdentifier: "NightPhase") as! NightVC
        //self.present(newView, animated: true, completion: nil)
        self.view.window!.rootViewController?.present(newView, animated: true, completion: nil)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.players?.removeAll()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "returnToPlayerSelect"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension RoleSelectVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = forwardButton.center
        transition.circleColour = UIColor.black
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = backButton.center
        transition.circleColour = UIColor.black
        return transition
    }
}
