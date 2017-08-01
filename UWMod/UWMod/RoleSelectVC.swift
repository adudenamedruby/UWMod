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
    @IBOutlet weak var roleCountLabel: UILabel!
    
    
    let transition = CircularTransition()
    let reuseIdentifier = "RoleCell"
    
    var gameBalance: Int = 0
    var players: [String]?
    var selectedRoles: [Role] = []
    var gameActors: [Player] = []
    
    
    // MARK: - View lifetime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        updateRoleCountLabel()
        
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
    
    func updateRoleCountLabel() {
        let roleCount = collectionView.indexPathsForSelectedItems?.count

        roleCountLabel.text = "\(roleCount!)/\(players!.count)"
    }
    
    // MARK: - Player prep for game start
    
    func createPlayers() {
        
        for role in self.selectedRoles {
            let newPlayer = Player(name: role.name, role: role)
            self.gameActors.append(newPlayer)
        }
        
    }
    
    
    // MARK: - Navigation Buttons
    
    @IBAction func startGameButton(_ sender: Any) {
        
        if (self.selectedRoles.count < (self.players?.count)!) {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Alerts", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            vc.alertName = "Warning"
            vc.alertText = "You do not have enough roles for the number of players in the game."
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            
        } else {
        
            createPlayers()
            GAME = Game(availableRoster: players!, availablePlayers: gameActors)
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let masterGameView = storyboard.instantiateViewController(withIdentifier: "MasterGameWindow") as! MainGameVC
            let presentingVC = self.presentingViewController
            let masterParentVC = presentingVC?.presentingViewController
            self.dismiss(animated: false, completion: { () -> Void   in
                presentingVC!.dismiss(animated: false, completion: { () -> Void in
                masterParentVC!.present(masterGameView, animated: false, completion: nil)
                })
            })
        }
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.players?.removeAll()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "returnToPlayerSelect"), object: nil)
        self.dismiss(animated: true, completion: nil)
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
        
        cell.firstLetter.text = ALL_GAME_ROLES[index].name.firstLetter()
        cell.remainingCharacters.text = ALL_GAME_ROLES[index].name.restOfString()
        cell.roleImage.image = ALL_GAME_ROLES[index].image
        cell.alpha = 0.5
        cell.configureCell()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
        updateGameBalance()
        
        let selectedIndexPaths = collectionView.indexPathsForSelectedItems
        
        updateRoleCountLabel()
        
        if (selectedIndexPaths?.count)! > (players?.count)! {
            let storyboard: UIStoryboard = UIStoryboard(name: "Alerts", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            vc.modalTransitionStyle = .crossDissolve
            vc.alertName = "Warning"
            vc.alertText = "You've selected more roles than there are players in the game."
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
        
        updateRoleCountLabel()
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
