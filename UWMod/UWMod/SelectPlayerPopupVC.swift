//
//  SelectPlayerPopupVC.swift
//  UWMod
//
//  Created by roux buciu on 2017-08-10.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

enum SelectPlayerReason {
    case Default
    case AssignPlayer
    case BodyguardSelectProtectee
    case PriestSelectProtectee
    case CupidLovestrike
    case SilencePlayer
    case WerewolfElimination
    case VillageElimination
    case ZombieLobotomization
    case RoleClarification
    case BlobAbsorbtion
    case JoinTheCult
    case VirginiaIsInTown
}

class SelectPlayerPopupVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mainCardView:            UIView!
    @IBOutlet weak var headerView:              UIView!
    @IBOutlet weak var headerTitleLabel:        OldTan!
    @IBOutlet weak var selectButton:            PMSuperButton!
    
    @IBOutlet weak var tableView:               UITableView!
    
    
    // MARK: - Variables
    
    let textCellIdentifier                  = "selectPlayerCell"
    var headerTitle                         = "Select Player"
    var availablePlayers: [Player]          = []
    var chosenPlayer:                       Player?

    
    // Passed values
    var popupTitle:                         String?
    var role:                               Role?
    var reason: SelectPlayerReason          = .Default
    var activePlayer:                      Player?
    
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate                  = self
        tableView.dataSource                = self
        tableView.allowsMultipleSelection   = false
        
        mainCardView.layer.cornerRadius         = STYLE.CornerRadius
        mainCardView.backgroundColor            = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        
        if popupTitle != nil {
            headerTitle = popupTitle!
        }
        
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        populateAvailablePlayerList()
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        populateAvailablePlayerList()
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button functions
    
    @IBAction func selectPlayer(_ sender: Any) {
        if chosenPlayer != nil {
            
            GAME.setChosenPlayer(player: chosenPlayer!)
            
            if reason == .WerewolfElimination {
                showConfirmation(withEliminatingRoleType: .Werewolf, withActingPlayer: nil, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
                
            } else if reason == .AssignPlayer {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: nil, withReason: reason, withRole: role!, withAlternateTitle: nil, withAlternateText: nil)
            
            } else if reason == .BodyguardSelectProtectee {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: activePlayer, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
                
            } else if reason == .PriestSelectProtectee {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: activePlayer, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
            
            } else if reason == .VillageElimination {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: nil, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
                
            } else if reason == .ZombieLobotomization {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: activePlayer, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
                
            } else if reason == .RoleClarification {
                let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
                let roleClarification = storyboard.instantiateViewController(withIdentifier: "roleClarificationPopupVC") as! RoleClarificationPopupVC
                self.present(roleClarification, animated: true, completion: nil)
        
            } else if reason == .BlobAbsorbtion {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: nil, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
                
            } else if reason == .JoinTheCult {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: nil, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
                
            } else if reason == .CupidLovestrike {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: activePlayer, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
                
            } else if reason == .SilencePlayer {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: activePlayer, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
                
            } else if reason == .VirginiaIsInTown {
                showConfirmation(withEliminatingRoleType: nil, withActingPlayer: activePlayer, withReason: reason, withRole: nil, withAlternateTitle: nil, withAlternateText: nil)
                
            }
            
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
            let errorView = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            errorView.alertName = "Error"
            errorView.alertText = "Please select a player."
            errorView.modalTransitionStyle = .crossDissolve
            
            self.present(errorView, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.notify()
        })
    }
    
    
    // MARK: - Functions
    
    func showConfirmation(withEliminatingRoleType roletype: RoleType?, withActingPlayer ac: Player?, withReason reason: SelectPlayerReason?, withRole role: Role?, withAlternateTitle title: String?, withAlternateText text: String?) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let confirm = storyboard.instantiateViewController(withIdentifier: "confirmationPopup") as! ConfirmationPopup
        
        if roletype != nil      { confirm.eliminatedByType = roletype }
        if reason != nil        { confirm.reason = reason }
        if ac != nil            { confirm.actingPlayer = ac }
        if role != nil          { confirm.role = role }
        if title != nil         { confirm.alternateHeaderTitle = title }
        if text != nil          { confirm.alternateAlertText = text }
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(confirm, animated: true, completion: nil)
        
    }
    
    private func populateAvailablePlayerList() {
        
        switch reason {
        case .Default:
            populateLivingPlayers()
            
        case .AssignPlayer:
            populateFirstNightPlayers()
            
        case .BodyguardSelectProtectee:
            populateForProtection()
            
        case .WerewolfElimination:
            populateWerewolfTargets()
            
        case .VillageElimination:
            populateLivingPlayers()
            
        case .ZombieLobotomization:
            populateZombieTargets()
            
        case .RoleClarification:
            populateRolesInGame()
         
        case .BlobAbsorbtion:
            populateNonBlobPlayers()
            
        case .JoinTheCult:
            populateNonCultPlayers()
        
        case .PriestSelectProtectee:
            populateForProtection()
            
        case .CupidLovestrike:
            populatePotentialLovebirds()
            
        case .SilencePlayer:
            populatePlayersToSilence()
            
        case .VirginiaIsInTown:
            populatePeopleToIntimidate()
            
        }
        
    }
    
    private func populateLivingPlayers() {
        availablePlayers.removeAll()
        
        for player in GAME.livingActors {
                availablePlayers.append(player)
        }
        
        availablePlayers.sort(by: { $0.name < $1.name } )
    }

    private func notify() {
        
        let nc = NotificationCenter.default
        
        switch reason {
        case .Default:
            break
            
        case .AssignPlayer:
            nc.post(name: NSNotification.Name(rawValue: AssignPlayerFailureNotification), object: nil)
            
        case .BodyguardSelectProtectee:
            nc.post(name: NSNotification.Name(rawValue: BodyguardProtectingFailureNotification), object: nil)
            
        case .PriestSelectProtectee:
            nc.post(name: NSNotification.Name(rawValue: PriestProtectFailureNotification), object: nil)
            
        case .WerewolfElimination:
            nc.post(name: NSNotification.Name(rawValue: EliminationByWerewolfFailureNotification), object: nil)
            
        case .VillageElimination:
            break
            
        case .ZombieLobotomization:
            nc.post(name: NSNotification.Name(rawValue: ZombieLobotomyFailureNotification), object: nil)
            
        case .BlobAbsorbtion:
            nc.post(name: NSNotification.Name(rawValue: BlobAbsorbtionFailureNotification), object: nil)
            
        case .JoinTheCult:
            nc.post(name: NSNotification.Name(rawValue: JoinCultFailureNotification), object: nil)
            
        case .CupidLovestrike:
            nc.post(name: NSNotification.Name(rawValue: JoinCultFailureNotification), object: nil)
            
        case .SilencePlayer:
            nc.post(name: NSNotification.Name(rawValue: SpellcasterSilenceFailureNotification), object: nil)
            
        case .VirginiaIsInTown:
            nc.post(name: NSNotification.Name(rawValue: VirginiaIntimidationFailureNotification), object: nil)
            
        case .RoleClarification:
            break
        }
    }
}

extension SelectPlayerPopupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return availablePlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        if reason == .RoleClarification {
            cell.textLabel?.text    = availablePlayers[row].roleName
        } else {
            cell.textLabel?.text    = availablePlayers[row].name
        }
        cell.textLabel?.textColor   = STYLE.Brown
        cell.textLabel?.font        = STYLE.RegBoldTableView
        cell.selectionStyle         = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        chosenPlayer = availablePlayers[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        chosenPlayer = nil
    }
    
}

extension SelectPlayerPopupVC {
    
    // FIRST NIGHT!
    func populateFirstNightPlayers() {
        availablePlayers.removeAll()
        
        for player in GAME.availablePlayers {
            if !player.isAssigned {
                availablePlayers.append(player)
            }
        }
        if GAME.playersAreAssignedNumbers {
            availablePlayers.sort(by: { $0.gameID < $1.gameID } )
        } else {
            availablePlayers.sort(by: { $0.name < $1.name } )
        }
    }
}

extension SelectPlayerPopupVC {
    
    // PROTECTION!
    func populateForProtection() {
        availablePlayers.removeAll()
        availablePlayers   = unprotectedPlayersList()
    }

    func unprotectedPlayersList() -> [Player] {
        var unprotectedPlayersList: [Player] = []

        for player in GAME.livingActors {
            if (activePlayer?.canAffect(player: player, forCondition: .Protection))! && player !== activePlayer {
                unprotectedPlayersList.append(player)
            }
        }

        //unprotectedPlayersList.sort(by: { $0.name < $1.name })
        
        return unprotectedPlayersList
    }
}

extension SelectPlayerPopupVC {
    
    // WEREWOLF ELIMINATION
    func populateWerewolfTargets() {
        availablePlayers.removeAll()
        
        for player in GAME.livingActors {
            if !GAME.wolfRoles.contains(player.roleType) {
                availablePlayers.append(player)
            }
        }
        
        //availablePlayers.sort(by: { $0.name < $1.name } )
    }
}

extension SelectPlayerPopupVC {
    
    // ZOMBIE LOBOTOMIZATION
    func populateZombieTargets() {
        availablePlayers.removeAll()
        
        for player in GAME.livingActors {
            if (activePlayer?.canAffect(player: player, forCondition: .Lobotomy))! && (player !== activePlayer) {
                availablePlayers.append(player)
            }
        }
        
        //availablePlayers.sort(by: { $0.name < $1.name } )
    }
}

extension SelectPlayerPopupVC {
    
    // BLOB ABSORBTION
    func populateNonBlobPlayers() {
        availablePlayers.removeAll()
        
        var playerRoster:           [Player]!
        
        if GAME.firstNight {
            playerRoster            = GAME.availablePlayers
        } else {
            playerRoster            = GAME.livingActors
        }
        
        for player in playerRoster {
            if !player.team.contains(.TeamBlob) {
                availablePlayers.append(player)
            }
        }
        
        //availablePlayers.sort(by: { $0.name < $1.name } )
    }
}

extension SelectPlayerPopupVC {
    
    // CULT LEADER BRAINWASHING!
    func populateNonCultPlayers() {
        availablePlayers.removeAll()
        
        let array:      [Player]
        
        if GAME.firstNight {
            array = GAME.availablePlayers
        } else {
            array = GAME.livingActors
        }
        
        for player in array {
            if !(player.team.contains(.TeamCult)) && player !== activePlayer {
                availablePlayers.append(player)
            }
        }
        
        //availablePlayers.sort(by: { $0.name < $1.name } )
    }
}

extension SelectPlayerPopupVC {
    
    // CUPID!
    func populatePotentialLovebirds() {
        availablePlayers.removeAll()
        
        for player in GAME.availablePlayers {
            if !(player.isAffectedBy(condition: .Lovestruck)) {
                availablePlayers.append(player)
            }
        }
        
        //availablePlayers.sort(by: { $0.name < $1.name } )
    }
}


extension SelectPlayerPopupVC {
    
    // PROTECTION!
    func populatePlayersToSilence() {
        availablePlayers.removeAll()
        availablePlayers = playersToSilence()
    }
    
    func playersToSilence() -> [Player] {
        var possiblePlayers: [Player] = []
        
        for player in GAME.livingActors {
            if (activePlayer?.canAffect(player: player, forCondition: .Silence))! {
                possiblePlayers.append(player)
            }
        }
        
        //unprotectedPlayersList.sort(by: { $0.name < $1.name })
        
        return possiblePlayers
    }
}

extension SelectPlayerPopupVC {
    
    // Virginia Woolf!
    func populatePeopleToIntimidate() {
        availablePlayers.removeAll()
        
        for player in GAME.availablePlayers {
            if !(player.isAffectedBy(condition: .Dependent)) && player !== activePlayer {
                availablePlayers.append(player)
            }
        }
        
        //availablePlayers.sort(by: { $0.name < $1.name } )
    }
}

extension SelectPlayerPopupVC {
    
    // ROLE CLARIFICATION
    func populateRolesInGame() {
        availablePlayers.removeAll()
        
        var villagerCount = 0
        var vampireCount = 0
        var werewolfCount = 0
        var masonCount = 0
        
        for player in GAME.availablePlayers {
            if player.roleType == .Werewolf {
                if werewolfCount == 0 {
                    availablePlayers.append(player)
                    werewolfCount += 1
                }
                
            } else if player.roleType == .Villager {
                if villagerCount == 0 {
                    availablePlayers.append(player)
                    villagerCount += 1
                }
                
            } else if player.roleType == .Vampire {
                if vampireCount == 0 {
                    availablePlayers.append(player)
                    vampireCount += 1
                }
            
            } else if player.roleType == .Mason {
                if masonCount == 0 {
                    availablePlayers.append(player)
                    masonCount += 1
                }
                
            } else {
                availablePlayers.append(player)
            }
            
        }
        
        availablePlayers.sort(by: { $0.roleName < $1.roleName } )
    }
}













