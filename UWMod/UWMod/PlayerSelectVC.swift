//
//  PlayerSelectVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-28.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class PlayerSelectVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mainCard: UIView!
    @IBOutlet var headerView: UIView!
    
    @IBOutlet weak var addPlayersButton: UIButton!
    @IBOutlet weak var forwardButton: PMSuperButton!
    
    @IBOutlet weak var playerNumberLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    let defaults = UserDefaults.standard
    let transition = CircularTransition()
    let textCellIndentifier = "PlayerNameCell"

    var savedPlayers: [String] = ["Ted Alspach"]
    var villageSize: Int = 0
    var selectedPlayers: [String] = []
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true

        mainCard.layer.cornerRadius = STYLE.CornerRadius
        mainCard.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
                
        NotificationCenter.default.addObserver(self, selector: #selector(loadPlayers),
                                               name: NSNotification.Name(rawValue: "reloadTable"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(emptySelectedPlayers),
                                              name: NSNotification.Name(rawValue: "returnToPlayerSelect"),
                                              object: nil)
        
        loadPlayers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPlayers()
        villageSize = 0
        playerNumberLabel.text = "0"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Player list names
    
    func loadPlayers() {
        if let temp = defaults.object(forKey: PLAYERS) as? [String] {
            self.savedPlayers = temp.sorted()
        }
        
        tableView.reloadData()
    }
    
    func removePlayerName(player: String) {
        
        if var tempPlayers = defaults.object(forKey: PLAYERS) as? [String] {
            
            if tempPlayers.contains(player) {
                let playerIndex = tempPlayers.index(of: player)
                tempPlayers.remove(at: playerIndex!)
            }
            
            defaults.set(tempPlayers, forKey: PLAYERS)
        }
    }
    
    func emptySelectedPlayers() {
        self.selectedPlayers.removeAll()
    }
    
    // MARK: - Navigation and data passing
    
    @IBAction func goToSelectRolesButton(_ sender: Any) {
        self.selectedPlayers = findSelectedPlayers()
    }
    
    func findSelectedPlayers() -> [String] {
        var playerNames: [String] = []
        let selectedIndexPaths = tableView.indexPathsForSelectedRows ?? []
        if selectedIndexPaths.count > 1 {
            for indexPath in selectedIndexPaths {
                let cell = tableView.cellForRow(at: indexPath)
                let text: String = (cell?.textLabel?.text)!
                playerNames.append(text)
            }
        }
        
        playerNames.sort()
        
        return playerNames
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if ((identifier == "selectRoleSegue") && (self.selectedPlayers.count < 3)) {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Alerts", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            vc.alertName = "Warning"
            vc.alertText = "You need at least three people to play a game of Ultimate Werewolf."
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectRoleSegue" {
            let secondVC = segue.destination as! RoleSelectVC
            secondVC.players = selectedPlayers
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
        } else if segue.identifier == "addPlayerSegue" {
            let secondVC = segue.destination as! AddPlayerVC
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
        }
    }
}


extension PlayerSelectVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIndentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = savedPlayers[row]
        cell.textLabel?.textColor = STYLE.Brown
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        villageSize += 1
        playerNumberLabel.text = String(villageSize)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        villageSize -= 1
        playerNumberLabel.text = String(villageSize)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removePlayerName(player: self.savedPlayers[indexPath.row])
            loadPlayers()
        }
    }
}

extension PlayerSelectVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = forwardButton.center
        transition.circleColour = UIColor.black
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = addPlayersButton.center
        transition.circleColour = UIColor.black
        return transition
    }
}
