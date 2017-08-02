//
//  MenuVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-28.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit
import SpriteKit

class MenuVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainCardView: UIView!
    @IBOutlet weak var brownView: UIView!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        
        mainCardView.backgroundColor = UIColor.WerewolfTheme.LightTan
        brownView.backgroundColor = UIColor.WerewolfTheme.ChocolateBrown

        //presentSmoke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Animation for effect
    
    // Create smoke particles at the bottom of the screen
    func presentSmoke() {
        let sk: SKView = SKView()
        sk.frame = mainView.bounds
        sk.backgroundColor = .clear
        mainCardView.addSubview(sk)
        
        let scene: SKScene = SKScene(size: mainView.bounds.size)
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .clear
        
        let particles = SKEmitterNode(fileNamed: "screenSmoke.sks")
        particles?.position = CGPoint(x: 0, y: 200)
        
        scene.addChild(particles!)
        sk.presentScene(scene)
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
        }
    }
}
