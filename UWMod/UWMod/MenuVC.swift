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
    
    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainCardView: UIView!
    @IBOutlet weak var brownView: UIView!
    @IBOutlet weak var bottomTitle: OldMenuBottom!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        
        mainCardView.backgroundColor = STYLE.Tan
        brownView.backgroundColor = STYLE.Brown
        
        let bottomString = "Werewolf"
        bottomTitle.attributedText = bottomString.colourFirstCharacter(withStringFont: STYLE.OldMenuBottomFont!, withColour: STYLE.Red)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        transition.startingPoint = aboutButton.center
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
        if segue.identifier == "aboutSegue" {
            let secondVC = segue.destination as! AboutVC
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
        } else if segue.identifier == "helpSegue" {
            let secondVC = segue.destination as! HelpVC
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
        }
    }

}
