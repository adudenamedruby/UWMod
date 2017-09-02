//
//  ExtrasMenuVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-09-01.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class ExtrasMenuVC: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var cardBackView:        UIView!
    @IBOutlet weak var mainCardView:        UIView!
    @IBOutlet weak var headerView:          UIView!
    @IBOutlet weak var headerTitleLabel:    OldTan!
    
    @IBOutlet weak var rolesButten:         PMSuperButton!
    
    // MARK: - VARIABLES
    
    let transition                          = CircularTransition()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardBackView.layer.cornerRadius     = STYLE.CornerRadius
        mainCardView.backgroundColor        = STYLE.Tan
        headerView.backgroundColor          = STYLE.Brown
        
        let headerTitle                     = "Extras"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
    }
    
    
    // MARK: - NAVIGATION

    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aboutSegue" {
            let secondVC                    = segue.destination as! AboutVC
            secondVC.transitioningDelegate  = self
            secondVC.modalPresentationStyle = .custom
        } else if segue.identifier == "gameHelpSegue" {
            let secondVC                    = segue.destination as! HelpVC
            secondVC.transitioningDelegate  = self
            secondVC.modalPresentationStyle = .custom
        } else if segue.identifier == "menuRoleHelpSegue" {
            let secondVC                    = segue.destination as! MenuRoleHelpVC
            secondVC.transitioningDelegate  = self
            secondVC.modalPresentationStyle = .custom
        }
    }
}

extension ExtrasMenuVC: UIViewControllerTransitioningDelegate {
    
    // MARK: - Transition setup
    
    // Setup the presenting animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode               = .present
        transition.startingPoint                = cardBackView.center
        transition.circleColour                 = headerView.backgroundColor!
        return transition
    }
    
    // Setup the dismissing animation
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode               = .dismiss
        transition.startingPoint                = cardBackView.center
        transition.circleColour                 = headerView.backgroundColor!
        return transition
    }
    
}

