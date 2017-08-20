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
    @IBOutlet weak var mainCard:                UIView!
    @IBOutlet var headerView:                   UIView!
    @IBOutlet weak var headerTitleLabel:        OldTan!
    
    @IBOutlet weak var assignNumbersLabel:      RegBrown!
    @IBOutlet weak var assignNumbersButton:     UIButton!
    
    @IBOutlet weak var addPlayersButton:        UIButton!
    @IBOutlet weak var forwardButton:           PMSuperButton!
    
    @IBOutlet weak var playerNumberLabel:       UILabel!
    
    @IBOutlet weak var tableView:               UITableView!
    
    // MARK: - Variables
    
    let defaults                                = UserDefaults.standard
    let transition                              = CircularTransition()
    let textCellIndentifier                     = "PlayerNameCell"
    
    var shouldAssignNumbersToPlayers            = false

    var savedPlayers: [String:[Person]]         = [:]
    var savedPlayerSections: [String]           = []
    var villageSize: Int                        = 0
    var selectedPlayers: [IndexPath:Person]     = [:]
    var passedPlayers: [Player]                 = []
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate                      = self
        tableView.dataSource                    = self
        tableView.allowsMultipleSelection       = true
        tableView.sectionHeaderHeight           = 25
        tableView.sectionIndexBackgroundColor   = STYLE.Tan
        tableView.sectionIndexColor             = STYLE.Brown

        mainCard.layer.cornerRadius             = STYLE.CornerRadius
        mainCard.backgroundColor                = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        let headerTitle                         = "Select Players"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
                
        NotificationCenter.default.addObserver(self, selector: #selector(loadPlayers),
                                               name: NSNotification.Name(rawValue: ReloadTableForNewPlayersNotification),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetPlayerSelection),
                                              name: NSNotification.Name(rawValue: ReturnToPlayerSelectNotification),
                                              object: nil)
        
        loadPlayers()
        resetVillageSizeLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPlayers()
        resetVillageSizeLabel()
        shouldAssignNumbersToPlayers            = false
        updateNumberAssignmentSegment()
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
        
        var playersSavedToMemory: [Person]
        if let data = UserDefaults.standard.data(forKey: PLAYERS) {
            playersSavedToMemory = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Person] ?? [Person]()
            orderPlayers(playerNames: playersSavedToMemory)
        }
        tableView.reloadData()
    }
    
    private func orderPlayers(playerNames: [Person]) {
        savedPlayers.removeAll()
        savedPlayerSections.removeAll()
        
        // sort the array to be alphabetical
        let tempPlayers: [Person] = playerNames.sorted{ $0.firstName.localizedCaseInsensitiveCompare($1.firstName) == .orderedAscending }
        
        //sort the array into alphabetized, sectioned listt
        for person in tempPlayers {
            let firstLetter = person.firstName[0].capitalized
            if savedPlayers[firstLetter] != nil {
                savedPlayers[firstLetter]!.append(person)
            } else {
                savedPlayers[firstLetter] = [person]
            }
            
            if !savedPlayerSections.contains(firstLetter) {
                savedPlayerSections.append(firstLetter)
            }
        }
        
        savedPlayerSections.sort()
        
    }
    
    func removePlayerName(player: Person) {
        
        if let data = UserDefaults.standard.data(forKey: PLAYERS), var tempPlayers = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Person] {
            
            for tPlayer in tempPlayers {
                if tPlayer.personID == player.personID {
                    let playerIndex = tempPlayers.index(where: { $0 === tPlayer } )
                    tempPlayers.remove(at: playerIndex!)
                    break
                }
            }
            
            let data = NSKeyedArchiver.archivedData(withRootObject: tempPlayers)
            UserDefaults.standard.set(data, forKey: PLAYERS)
        }
    }
    
    func resetPlayerSelection() {
        self.selectedPlayers.removeAll()
        self.passedPlayers.removeAll()
        villageSize = 0
        playerNumberLabel.text = "0"
        shouldAssignNumbersToPlayers = false
        updateNumberAssignmentSegment()
        tableView.reloadData()
    }
    
    
    // MARK: - Assign Numbers
    
    @IBAction func assignButtonPressed(_ sender: Any) {
        
        if shouldAssignNumbersToPlayers {
            shouldAssignNumbersToPlayers        = false
        } else {
            shouldAssignNumbersToPlayers        = true
        }
        
        updateNumberAssignmentSegment()
    }
    
    private func updateNumberAssignmentSegment() {
        if shouldAssignNumbersToPlayers {
            assignNumbersButton.setImage(#imageLiteral(resourceName: "checkYes"), for: .normal)
            assignNumbersLabel.alpha            = 1
            assignNumbersButton.alpha           = 1
        } else {
            assignNumbersButton.setImage(#imageLiteral(resourceName: "checkNo"), for: .normal)
            assignNumbersLabel.alpha            = 0.5
            assignNumbersButton.alpha           = 0.5
        }
    }
    
    
    // MARK: - Navigation and data passing
    
    @IBAction func goToSelectRolesButton(_ sender: Any) {
        self.passedPlayers = createPlayersFromSelectedNames()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func createPlayersFromSelectedNames() -> [Player] {
        
        var tempArray: [Person] = []
        var tempPlayerArray: [Player] = []
        
        // Create a dictionary to find out if I need last initials for anyone.
        var firstNameDict: [String:Int] = [:]
        for (_, person) in selectedPlayers {
            if firstNameDict[person.firstName] != nil {
                firstNameDict[person.firstName]! += 1
            } else {
                firstNameDict[person.firstName] = 1
            }
            
            tempArray.append(person)
        }

        
        for person in tempArray {
            let newPlayer = Player(withIdentity: person, withTeamName: nil)
            
            if firstNameDict[person.firstName]! > 1 {
                newPlayer.setPlayerNameWithLastInitial()
            }
            
            tempPlayerArray.append(newPlayer)
        }
        
        return tempPlayerArray
    }
    
    func addSelectedPlayer(index: IndexPath, person: Person) {
        selectedPlayers[index] = person
    }
    
    func removeSelectedPlayer(index: IndexPath, person: Person) {
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
        return savedPlayerSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return savedPlayerSections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 27
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myHeaderView = UIView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: tableView.frame.size.width,
                                                height: 27))
        myHeaderView.backgroundColor = STYLE.Beige
        myHeaderView.layer.cornerRadius = STYLE.CornerRadius
        
        let label = UILabel(frame: CGRect(x: tableView.frame.size.width/2 ,
                                          y: 3,
                                          width: 50,
                                          height: 25))
        label.text = savedPlayerSections[section]
        label.textColor = STYLE.Brown
        label.font = STYLE.RegBoldFont
        
        myHeaderView.addSubview(label)
        
        return myHeaderView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPlayers[savedPlayerSections[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIndentifier, for: indexPath)
        
        let sectionTitle = savedPlayerSections[indexPath.section]
        let sectionPlayers = savedPlayers[sectionTitle]
        let sectionPlayer = sectionPlayers?[indexPath.row]
        
        //let row = indexPath.row
        cell.textLabel?.text = "\(sectionPlayer?.firstName ?? "") \(sectionPlayer?.lastName ?? "")"
        cell.textLabel?.textColor = STYLE.Brown
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        villageSize             += 1
        playerNumberLabel.text  = String(villageSize)
        
        let sectionTitle        = savedPlayerSections[indexPath.section]
        let sectionPlayers      = savedPlayers[sectionTitle]
        let player              = sectionPlayers?[indexPath.row]
        
        addSelectedPlayer(index: indexPath, person: player!)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        villageSize -= 1
        playerNumberLabel.text = String(villageSize)
        
        let sectionTitle        = savedPlayerSections[indexPath.section]
        let sectionPlayers      = savedPlayers[sectionTitle]
        let player              = sectionPlayers?[indexPath.row]
        
        removeSelectedPlayer(index: indexPath, person: player!)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let sectionTitle = savedPlayerSections[indexPath.section]
            let sectionPlayers = savedPlayers[sectionTitle]
            let sectionPlayer = sectionPlayers?[indexPath.row]
            
            removePlayerName(player: sectionPlayer!)
            loadPlayers()
        }
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return savedPlayerSections
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
