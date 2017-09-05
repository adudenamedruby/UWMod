//
//  MenuVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-28.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit
import SpriteKit

class MenuVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet var mainView:                     UIView!
    @IBOutlet var mainCardView:                 UIView!
    @IBOutlet weak var brownView:               UIView!
    @IBOutlet weak var bottomTitle:             OldMenuBottom!
    
    
    // MARK: - Variables
    
    let transition                              = CircularTransition()
    var p1: Person! = nil
    var p2: Person! = nil
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCardView.layer.cornerRadius         = STYLE.CornerRadius
        
        mainCardView.backgroundColor            = STYLE.Tan
        brownView.backgroundColor               = STYLE.Brown
        
        let bottomString = "Werewolf"
        bottomTitle.attributedText = bottomString.styleTitleLabel(withStringFont: STYLE.OldMenuBottomFont!, withColour: STYLE.Red)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        whatsNewPresentationCheck()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func whatsNewPresentationCheck() {
        let defaults = UserDefaults.standard
        let hasPerformedCheck = defaults.bool(forKey: HasPerformedWhatsNewCheck)
        
        if !hasPerformedCheck {
            defaults.set(true, forKey: HasPerformedWhatsNewCheck)
            let hasPresentedPopup = defaults.bool(forKey: HasPresentedWhatsNewPopup)
            
            if !hasPresentedPopup {
                defaults.set(true, forKey: HasPresentedWhatsNewPopup)
                
                presentWhatsNewPopup()
            }
        }
    }
    
    func presentWhatsNewPopup() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newView = storyboard.instantiateViewController(withIdentifier: "whatsNewVC") as! WhatsNewVC
        self.present(newView, animated: true, completion: nil)
    }
    
    // MARK: - Buttons
    
    @IBAction func startGameButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newView = storyboard.instantiateViewController(withIdentifier: "playerSelect") as! PlayerSelectVC
        newView.transitioningDelegate = self
        newView.modalPresentationStyle = .custom
        self.present(newView, animated: true, completion: nil)
    }
    
    // MARK: - Transition setup
    
    // Setup the presenting animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = mainCardView.center
        transition.circleColour = brownView.backgroundColor!
        return transition
    }
}

extension MenuVC: UIViewControllerTransitioningDelegate {
    
    // Setup the dismissing animation
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = aboutButton.center
        transition.circleColour = brownView.backgroundColor!
        return transition
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "extrasSegue" {
            let secondVC                    = segue.destination as! ExtrasMenuVC
            secondVC.transitioningDelegate  = self
            secondVC.modalPresentationStyle = .custom
        } else if segue.identifier == "gameSettingsSegue" {
            let secondVC                    = segue.destination as! GameSettingsVC
            secondVC.transitioningDelegate  = self
            secondVC.modalPresentationStyle = .custom
        }
    }

}
