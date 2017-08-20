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
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var mainCardView:            UIView!
    @IBOutlet var headerView:                   UIView!
    @IBOutlet weak var headerTitleLabel:        OldTan!
    
    @IBOutlet weak var teamChoiceControl:       UISegmentedControl!
    @IBOutlet weak var backButton:              PMSuperButton!
    @IBOutlet weak var forwardButton:           PMSuperButton!
    
    @IBOutlet weak var collectionView:          UICollectionView!
    
    @IBOutlet weak var teamBalanceLabel:        UILabel!
    @IBOutlet weak var roleCountLabel:          UILabel!
    
    
    // MARK: - Variables
    
    let transition                              = CircularTransition()
    let reuseIdentifier                         = "RoleCell"
    
    var gameBalance: Int                        = 0
    var suggestedWerewolves: Int                = 0
    var selectedRoles: [Role]                   = []
    
    var selectedVillageRoles: [Role]            = []
    var selectedVillageIndexPaths: [IndexPath]  = []
    var selectedWerewolfRoles: [Role]           = []
    var selectedWerewolfIndexPaths: [IndexPath] = []
    var selectedOtherRoles: [Role]              = []
    var selectedOtherIndexPaths: [IndexPath]    = []

    
    var passedPlayers: [Player]?
    
    
    // MARK: - View lifetime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCardView.layer.cornerRadius         = STYLE.CornerRadius
        mainCardView.backgroundColor            = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        let headerTitle                         = "Select Role"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        collectionView.delegate                 = self
        collectionView.dataSource               = self
        collectionView.allowsMultipleSelection  = true
        
        teamBalanceLabel.text = suggestRoles()
        
        updateRoleCountLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Role selection
    
    
    @IBAction func selectRoleAffiliation(_ sender: Any) {
        collectionView.reloadData()
        
        // select the cells.
        if teamChoiceControl.selectedSegmentIndex == 0 {
            for index in selectedVillageIndexPaths {
                collectionView.selectItem(at: index, animated: false, scrollPosition: .top)
            }
            
        } else if teamChoiceControl.selectedSegmentIndex == 1 {
            for index in selectedWerewolfIndexPaths {
                collectionView.selectItem(at: index, animated: false, scrollPosition: .top)
            }
            
        } else if teamChoiceControl.selectedSegmentIndex == 2 {
            for index in selectedOtherIndexPaths {
                collectionView.selectItem(at: index, animated: false, scrollPosition: .top)
            }
        }
    }
    
    
    func suggestRoles() -> String {

        let numberOfPlayers = (passedPlayers?.count)!
        var numberOfWerewolves: Int
        
        if numberOfPlayers < 4 {
            numberOfWerewolves = 1
        } else {
            numberOfWerewolves = numberOfPlayers / 5
        }
        
        let numberOfVillagers = numberOfPlayers - numberOfWerewolves - 1
        
        let suggestion = "Suggested roles: 1 Seer \(numberOfVillagers) Villagers \(numberOfWerewolves) Werewolves"
        
        return suggestion
    }
    
    func updateRoles() {
        selectedVillageRoles                        = []
        selectedWerewolfRoles                       = []
        selectedOtherRoles                          = []
        
        for indexPath in selectedVillageIndexPaths {
            selectedVillageRoles.append(VILLAGE_ROLES[indexPath.row])
        }
        
        for indexPath in selectedWerewolfIndexPaths {
            selectedWerewolfRoles.append(WEREWOLF_ROLES[indexPath.row])
        }
        
        for indexPath in selectedOtherIndexPaths {
            selectedOtherRoles.append(OTHER_ROLES[indexPath.row])
        }
        
        self.selectedRoles.removeAll()
        self.selectedRoles = selectedVillageRoles + selectedWerewolfRoles + selectedOtherRoles
    }
    
    func updateGameBalance() {
        
        updateRoles()
        gameBalance = 0
        for role in selectedRoles {
            gameBalance = gameBalance + role.impact
        }
        
        if gameBalance < -30 {
            teamBalanceLabel.text = "The Village will not win."
            
        } else if gameBalance <= -20 {
            teamBalanceLabel.text = "The Village is greatly disadvantaged."
            
        } else if gameBalance <= -11 {
            teamBalanceLabel.text = "The Village is moderately disadvantaged."
            
        } else if gameBalance <= -5 {
            teamBalanceLabel.text = "The Village is slightly disadvantaged."
            
        } else if gameBalance <= 4 && gameBalance >= -4 {
            teamBalanceLabel.text = "Neither team has the advantage."
            
        } else if gameBalance > 30 {
            teamBalanceLabel.text = "The Village is heavily favoured."
            
        } else if gameBalance > 20 {
            teamBalanceLabel.text = "The Village is greatly favoured."
            
        } else if gameBalance > 11 {
            teamBalanceLabel.text = "The Village is moderately favoured."
            
        } else {
            teamBalanceLabel.text = "The Village is slightly favoured."
        }
    }
    
    func updateRoleCountLabel() {
        let roleCount = totalNumberOfSelectedRoles()

        roleCountLabel.text = "\(roleCount)/\(passedPlayers!.count)"
    }
    
    func totalNumberOfSelectedRoles() -> Int {
        let tempArray: [IndexPath] = selectedVillageIndexPaths + selectedWerewolfIndexPaths + selectedOtherIndexPaths
        
        return tempArray.count
    }
    
    
    // MARK: - Navigation Buttons
    
    @IBAction func startGameButton(_ sender: Any) {
        
        if (self.selectedRoles.count < (self.passedPlayers?.count)!) {
            // Make sure there are an equal number of roles and players.
            let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            vc.alertName = "Warning"
            vc.alertText = "You do not have enough roles for the number of players in the game."
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            
        } else if (self.selectedRoles.count > (self.passedPlayers?.count)!) {
            // Make sure there are an equal number of roles and players.
            let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            vc.alertName = "Warning"
            vc.alertText = "You have too many roles for the selected number of players in the game."
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            
        } else {
            // Begin the game
            GAME = Game(availableRoster: selectedRoles, availablePlayers: passedPlayers!, withSettings: SETTINGS)
            
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
        self.passedPlayers?.removeAll()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ReturnToPlayerSelectNotification), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}


extension RoleSelectVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if teamChoiceControl.selectedSegmentIndex == 0 {
            return VILLAGE_ROLES.count
            
        } else if teamChoiceControl.selectedSegmentIndex == 1 {
            return WEREWOLF_ROLES.count
            
        } else if teamChoiceControl.selectedSegmentIndex == 2 {
            return OTHER_ROLES.count
        }
        
        return ALL_GAME_ROLES.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RoleSelectionCell
        
        let row = indexPath.row
        
        if teamChoiceControl.selectedSegmentIndex == 0 {
            cell.roleName = VILLAGE_ROLES[row].name
            cell.roleIcon = VILLAGE_ROLES[row].image
            
            if selectedVillageIndexPaths.contains(indexPath) {
                cell.alpha = 1
            } else {
                cell.alpha = 0.5
            }
            
        } else if teamChoiceControl.selectedSegmentIndex == 1 {
            cell.roleName = WEREWOLF_ROLES[row].name
            cell.roleIcon = WEREWOLF_ROLES[row].image
            
            if selectedWerewolfIndexPaths.contains(indexPath) {
                cell.alpha = 1
            } else {
                cell.alpha = 0.5
            }
            
        } else if teamChoiceControl.selectedSegmentIndex == 2 {
            cell.roleName = OTHER_ROLES[row].name
            cell.roleIcon = OTHER_ROLES[row].image
            
            if selectedOtherIndexPaths.contains(indexPath) {
                cell.alpha = 1
            } else {
                cell.alpha = 0.5
            }
            
        } else {
            cell.roleName = ALL_GAME_ROLES[row].name
            cell.roleIcon = ALL_GAME_ROLES[row].image
        }
        
        cell.configureCell()
        // Select the cell.
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
        
        if teamChoiceControl.selectedSegmentIndex == 0 {
            if !selectedVillageIndexPaths.contains(indexPath) {
                selectedVillageIndexPaths.append(indexPath)
            }
            
        } else if teamChoiceControl.selectedSegmentIndex == 1 {
            if !selectedWerewolfIndexPaths.contains(indexPath) {
                selectedWerewolfIndexPaths.append(indexPath)
            }
            
        } else if teamChoiceControl.selectedSegmentIndex == 2 {
            if !selectedOtherIndexPaths.contains(indexPath) {
                selectedOtherIndexPaths.append(indexPath)
            }
        }

        updateRoleCountLabel()
        updateGameBalance()
        
        if (totalNumberOfSelectedRoles()) > (passedPlayers?.count)! {
            let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            vc.modalTransitionStyle = .crossDissolve
            vc.alertName = "Warning"
            vc.alertText = "You've selected more roles than there are players in the game."
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
        
        if teamChoiceControl.selectedSegmentIndex == 0 {
            removeFromArray(indexPath:  indexPath, teamIndex: 0)
            
        } else if teamChoiceControl.selectedSegmentIndex == 1 {
            removeFromArray(indexPath:  indexPath, teamIndex: 1)
            
        } else if teamChoiceControl.selectedSegmentIndex == 2 {
            removeFromArray(indexPath:  indexPath, teamIndex: 2)
        }
        
        
        updateRoleCountLabel()
        updateGameBalance()
    }
    
    func removeFromArray(indexPath: IndexPath, teamIndex: Int) {
        
        if teamIndex == 0 {
            if selectedVillageIndexPaths.contains(indexPath) {
                let arrIndx = selectedVillageIndexPaths.index(of: indexPath)
                selectedVillageIndexPaths.remove(at: arrIndx!)
            }
            
        } else if teamIndex == 1 {
            if selectedWerewolfIndexPaths.contains(indexPath) {
                let arrIndx = selectedWerewolfIndexPaths.index(of: indexPath)
                selectedWerewolfIndexPaths.remove(at: arrIndx!)
            }
            
        } else if teamIndex == 2 {
            if selectedOtherIndexPaths.contains(indexPath) {
                let arrIndx = selectedOtherIndexPaths.index(of: indexPath)
                selectedOtherIndexPaths.remove(at: arrIndx!)
            }
        }
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
