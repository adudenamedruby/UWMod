//
//  DayVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-28.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class DayVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var daytimeBackground: UIImageView!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var endDayTitleLabel: OldTan!
    
    @IBOutlet weak var voteButton: PMSuperButton!
    @IBOutlet weak var lynchButton: UIButton!
    @IBOutlet weak var endDayButton: UIButton!
    
    @IBOutlet weak var dayContainerView: UIView!
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: OldTan!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Variables
    
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()

        endDayTitleLabel.alpha = 0
        forwardButton.alpha = 0
        backButton.alpha = 0
        daytimeBackground.alpha = 0
        
        voteButton.alpha = 0
        lynchButton.alpha = 0
        endDayButton.alpha = 0
        
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        let headerTitle = "Day Phase"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!,
                                                                      withColour: STYLE.Red)
        let endDayLabel = "End Day Phase?"
        endDayTitleLabel.attributedText = endDayLabel.styleTitleLabel(withStringFont: STYLE.OldStandardFont!,
                                                                      withColour: STYLE.Red)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        daytimeBackground.alpha = 1
        
        fadeButtonsIn()
    }
    
    
    // MARK: - Button functionality

    @IBAction func lynchPressed(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let lynchView = storyboard.instantiateViewController(withIdentifier: "selectPlayerPopupVC") as! SelectPlayerPopupVC
        lynchView.popupTitle = "Who to Lynch?"
        lynchView.reason = .VillageElimination
        
        self.present(lynchView, animated: true, completion: nil)
    }
    
    @IBAction func voteTrackerPressed(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let counterView = storyboard.instantiateViewController(withIdentifier: "voteCounterPopup") as! VoteCounterVC
        counterView.modalTransitionStyle = .crossDissolve
        self.present(counterView, animated: true, completion: nil)
    }

    @IBAction func endDayPressed(_ sender: Any) {
        fadeButtonsOut()
        fadeDayEndControlsIn()
    }
    
    @IBAction func endGameButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let endGameConfirm = storyboard.instantiateViewController(withIdentifier: "gameMenuPopupVC") as! GameMenuPopupVC
        endGameConfirm.modalTransitionStyle = .crossDissolve
        self.present(endGameConfirm, animated: true, completion: nil)
    }
    
    @IBAction func finishDayButton(_ sender: Any) {
        GAME.finishDay()
        self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueDayButton(_ sender: Any) {
        fadeDayEndControlsOut()
        fadeButtonsIn()
    }
    
    private func fadeDayEndControlsIn() {
        self.dayContainerView.fadeOut(duration: 1, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.endDayTitleLabel.fadeIn(duration: 1, delay: 0)
            self.forwardButton.fadeIn(duration: 1, delay: 0)
            self.backButton.fadeIn(duration: 1, delay: 0)
        })
    }
    
    private func fadeDayEndControlsOut() {
        self.endDayTitleLabel.fadeOut(duration: 1, delay: 0)
        self.backButton.fadeOut(duration: 1, delay: 0)
        self.forwardButton.fadeOut(duration: 1, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.dayContainerView.fadeIn(duration: 1, delay: 0)
        })
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 75.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Register ALL the nibs that will be loaded into the tableView here
        tableView.register(UINib(nibName: "GeneralInfo", bundle: nil),
                           forCellReuseIdentifier: "generalInfoCell")
        tableView.register(UINib(nibName: "Graveyard", bundle: nil),
                           forCellReuseIdentifier: "graveyardCell")
        tableView.register(UINib(nibName: "WerewolfTeamCell", bundle: nil),
                           forCellReuseIdentifier: "werewolfTeamCell")
        tableView.register(UINib(nibName: "VillageTeamCell", bundle: nil),
                           forCellReuseIdentifier: "villageTeamCell")
        tableView.register(UINib(nibName: "ZombieCell", bundle: nil),
                           forCellReuseIdentifier: "zombieCell")
        tableView.register(UINib(nibName: "BlobCell", bundle: nil),
                           forCellReuseIdentifier: "blobCell")
        tableView.register(UINib(nibName: "JoinCultCell", bundle: nil),
                           forCellReuseIdentifier: "joinCultCell")
        tableView.register(UINib(nibName: "SweetheartCell", bundle: nil),
                           forCellReuseIdentifier: "sweetheartCell")
        tableView.register(UINib(nibName: "SpellcasterCell", bundle: nil),
                           forCellReuseIdentifier: "spellcasterCell")
    }
    
    private func fadeButtonsIn() {
        voteButton.fadeIn()
        lynchButton.fadeIn()
        endDayButton.fadeIn()
    }
    
    private func fadeButtonsOut() {
        voteButton.fadeOut()
        lynchButton.fadeOut()
        endDayButton.fadeOut()
    }
}

extension DayVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GAME.daytimeInfoCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = selectCell(indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func selectCell(indexPath: IndexPath) -> UITableViewCell {
        
        let currentType = GAME.daytimeInfoCards[indexPath.row]
        
        if currentType == .GeneralInfoCard {
            let cell = tableView.dequeueReusableCell(withIdentifier: "generalInfoCell", for: indexPath) as! GeneralInfo
            cell.configureCell()
            return cell
            
        } else if currentType == .VillageTeamCard {
            let cell = tableView.dequeueReusableCell(withIdentifier: "villageTeamCell", for: indexPath) as! VillageTeamCell
            cell.villageTeamPlayers = GAME.fetchPlayersWithTeamType(fromList: GAME.livingActors, ofTeamType: .TeamVillage, withRole: true)
            cell.configureCell()
            return cell
            
        } else if currentType == .WerewolfTeamCard {
            let cell = tableView.dequeueReusableCell(withIdentifier: "werewolfTeamCell", for: indexPath) as! WerewolfTeamCell
            cell.werewolfTeamPlayers = GAME.fetchPlayersWithTeamType(fromList: GAME.livingActors, ofTeamType: .TeamWerewolf, withRole: true)
            cell.configureCell()
            return cell
            
        } else if currentType == .GraveyardCard {
            let cell = tableView.dequeueReusableCell(withIdentifier: "graveyardCell", for: indexPath) as! Graveyard
            cell.deadPlayers = GAME.fetchAllPlayers(fromList: GAME.deadActors, withRole: true)
            cell.configureCell()
            return cell
            
        } else if currentType == .ZombieTeamCard {
            let cell = tableView.dequeueReusableCell(withIdentifier: "zombieCell", for: indexPath) as! ZombieCell
            cell.playersAffectedByZombie = GAME.fetchPlayersAffectedByEffect(fromList: GAME.livingActors, affectedBy: .Lobotomy, withRole: false, separatedByComma: true)
            cell.configureCell()
            return cell
            
        } else if currentType == .BlobTeamCard {
            let cell = tableView.dequeueReusableCell(withIdentifier: "blobCell", for: indexPath) as! BlobCell
            
            var originalPlayer: Player!
            
            for player in GAME.availablePlayers {
                if player.roleType == .TheBlob {
                    originalPlayer = player
                }
            }
            
            cell.originalBlob = originalPlayer
            cell.blobTeamMembers = GAME.fetchPlayersWithTeamType(fromList: GAME.livingActors, ofTeamType: .TeamBlob)
            cell.configureCell()
            return cell
            
        } else if currentType == .CultTeamCard {
            let cell = tableView.dequeueReusableCell(withIdentifier: "joinCultCell", for: indexPath) as! JoinCultCell
            
            var originalPlayer: Player!
            
            for player in GAME.availablePlayers {
                if player.roleType == .CultLeader {
                    originalPlayer = player
                    break
                }
            }
            
            cell.cultLeader = originalPlayer
            cell.cultMembers = GAME.fetchPlayersWithTeamType(fromList: GAME.livingActors, ofTeamType: .TeamCult, excludingRole: .CultLeader)
            cell.configureCell()
            return cell
            
        } else if currentType == .LovebirdTeamCard {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sweetheartCell", for: indexPath) as! SweetheartCell
            cell.configureCell()
            return cell
            
        } else if currentType == .SpellcasterSilenceCard {
            let cell = tableView.dequeueReusableCell(withIdentifier: "spellcasterCell", for: indexPath) as! SpellcasterCell
            cell.configureCell()
            return cell
        
        }
        
        return UITableViewCell()
    }
    
}
