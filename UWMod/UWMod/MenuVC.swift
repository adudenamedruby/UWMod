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
    @IBOutlet weak var brownView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sk: SKView = SKView()
        sk.frame = mainView.bounds
        sk.backgroundColor = .clear
        bottomView.addSubview(sk)
        
        let scene: SKScene = SKScene(size: mainView.bounds.size)
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .clear
        
        let particles = SKEmitterNode(fileNamed: "screenSmoke.sks")
        particles?.position = CGPoint(x: 0, y: 200)
        
        scene.addChild(particles!)
        sk.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = aboutButton.center
        transition.circleColour = brownView.backgroundColor!
        return transition
    }
    
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
        } else if segue.identifier == "startGameSegue" {
            let secondVC = segue.destination as! PlayerSelectVC
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
        }
    }
}
