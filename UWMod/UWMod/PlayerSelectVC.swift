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
    @IBOutlet weak var headerTitleLabel: OldTan!
    
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
    var selectedPlayers: [Int:String] = [:]
    var passedPlayers: [Player] = []
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true

        mainCard.layer.cornerRadius = STYLE.CornerRadius
        mainCard.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        let headerTitle = "Select Players"
        headerTitleLabel.attributedText = headerTitle.colourFirstCharacter(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
                
        NotificationCenter.default.addObserver(self, selector: #selector(loadPlayers),
                                               name: NSNotification.Name(rawValue: "reloadTable"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetPlayerSelection),
                                              name: NSNotification.Name(rawValue: "returnToPlayerSelect"),
                                              object: nil)
        
        loadPlayers()
        resetVillageSizeLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPlayers()
        resetVillageSizeLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetVillageSizeLabel() {
        villageSize = 0
        playerNumberLabel.text = "0"
    }
    
    
    // MARK: - Player list names
    
    func loadPlayers() {
        resetVillageSizeLabel()
        if let temp = defaults.object(forKey: PLAYERS) as? [String] {
            self.savedPlayers = temp.sorted{$0.localizedCaseInsensitiveCompare($1) == .orderedAscending}
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
    
    func resetPlayerSelection() {
        self.selectedPlayers.removeAll()
        self.passedPlayers.removeAll()
        villageSize = 0
        playerNumberLabel.text = "0"
        tableView.reloadData()
    }
    
    // MARK: - Navigation and data passing
    
    @IBAction func goToSelectRolesButton(_ sender: Any) {
        self.passedPlayers = createPlayersFromSelectedNames()
    }
    
    func createPlayersFromSelectedNames() -> [Player] {
        
        var tempArray: [String] = []
        var tempPlayerArray: [Player] = []
        
        for (_, name) in selectedPlayers {
            tempArray.append(name)
        }
        
        for name in tempArray {
            let newPlayer = Player(name: name)
            tempPlayerArray.append(newPlayer)
        }
        
        return tempPlayerArray
    }
    
    func addSelectedPlayer(index: Int, name: String) {
        selectedPlayers[index] = name
    }
    
    func removeSelectedPlayer(index: Int, name: String) {
        selectedPlayers.removeValue(forKey: index)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if ((identifier == "selectRoleSegue") && (self.passedPlayers.count < 3)) {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            vc.alertName = "Warning"
            vc.alertText = "You need at least three people to play a game of Ultimate Werewolf."
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            
            return false
            
        } else if ((identifier == "selectRoleSegue") && (self.passedPlayers.count > 75)) {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            vc.alertName = "Warning"
            vc.alertText = "You can only play Ultimate Werewolf with a maximum of 75 people."
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectRoleSegue" {
            let secondVC = segue.destination as! RoleSelectVC
            secondVC.passedPlayers = passedPlayers
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
        
        //let cell = tableView.cellForRow(at: indexPath)
        let text = tableView.cellForRow(at: indexPath)?.textLabel?.text
        addSelectedPlayer(index: indexPath.row, name: text!)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        villageSize -= 1
        playerNumberLabel.text = String(villageSize)
        
        //let cell = tableView.cellForRow(at: indexPath)
        let text = tableView.cellForRow(at: indexPath)?.textLabel?.text
        removeSelectedPlayer(index: indexPath.row, name: text!)
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
