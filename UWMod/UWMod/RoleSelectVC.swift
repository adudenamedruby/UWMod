//
//  RoleSelectVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-28.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

enum RoleUpdateReason {
    case AddRole
    case RemoveRole
    case NoReason
}

class RoleSelectVC: UIViewController {
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var backButton: PMSuperButton!
    @IBOutlet weak var forwardButton: PMSuperButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var gameBalanceLabel: UILabel!
    @IBOutlet weak var teamBalanceLabel: UILabel!
    
    let transition = CircularTransition()
    let reuseIdentifier = "RoleCell"
    
    var gameBalance: Int = 0
    var players: [Player]?
    var selectedRoles: [Role] = []
    
    
    // MARK: - View lifetime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        gameBalanceLabel.text = String(gameBalance)
        self.mainCardView.layer.cornerRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Role selection
    
    func updateRoles() {
        var chosenRoles: [Role] = []
        let selectedIndexPaths = collectionView.indexPathsForSelectedItems
        for indexPath in selectedIndexPaths! {
            chosenRoles.append(ALL_GAME_ROLES[indexPath.row])
        }
        
        self.selectedRoles.removeAll()
        self.selectedRoles = chosenRoles
    }
    
    func updateGameBalance() {
        
        updateRoles()
        gameBalance = 0
        for role in selectedRoles {
            gameBalance = gameBalance + role.impact
        }
        
        gameBalanceLabel.text = String(gameBalance)
        
        if gameBalance < -15 {
            teamBalanceLabel.text = "The Village is greatly disadvantaged."
        } else if gameBalance < 0 {
            teamBalanceLabel.text = "The Village is at a disadvantage."
        } else if gameBalance == 0 {
            teamBalanceLabel.text = "Neither team has the advantage."
        } else if gameBalance > 15 {
            teamBalanceLabel.text = "The Village is heavily favoured."
        } else {
            teamBalanceLabel.text = "The Village has the advantage."
        }
    }
    
    
    // MARK: - Navigation Buttons
    
    @IBAction func startGameButton(_ sender: Any) {
        GAME = Game(availableRoles: self.selectedRoles,
                    availablePlayers: self.players!)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let masterGameView = storyboard.instantiateViewController(withIdentifier: "MasterGameWindow") as! MainGameVC
        let presentingVC = self.presentingViewController
        self.dismiss(animated: false, completion: { () -> Void   in
            presentingVC!.present(masterGameView, animated: false, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = masterGameView
        })
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.players?.removeAll()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "returnToPlayerSelect"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Label text manipulation
    
    func firstLetter(text: String) -> String {
        let index = text.index(text.startIndex, offsetBy: 0)
        
        return String(text[index])
    }
    
    func restOfString(text: String) -> String {
        let index = text.index(text.startIndex, offsetBy: 1)
        
        return text.substring(from: index)
    }
}

extension RoleSelectVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ALL_GAME_ROLES.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RoleSelectionCell

        
        let index = indexPath.row
        
        cell.firstLetter.text = firstLetter(text: ALL_GAME_ROLES[index].name)
        cell.remainingCharacters.text = restOfString(text: ALL_GAME_ROLES[index].name)
        cell.roleImage.image = ALL_GAME_ROLES[index].image
        cell.alpha = 0.5
        cell.configureCell()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
        updateGameBalance()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
        updateGameBalance()
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
