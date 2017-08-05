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
    @IBOutlet weak var endDayTitleLabel: UIStackView!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var lynchButton: UIButton!
    @IBOutlet weak var endDayButton: UIButton!
    
    @IBOutlet weak var dayContainerView: UIView!
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var headerView: UIView!
    
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
        
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        daytimeBackground.alpha = 1
    }
    
    
    // MARK: - Navigation

    @IBAction func lynchPressed(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let lynchView = storyboard.instantiateViewController(withIdentifier: "eliminatePlayer") as! EliminatePlayerVC
        lynchView.modalTransitionStyle = .crossDissolve
        self.present(lynchView, animated: true, completion: nil)
    }
    
    @IBAction func endDayPressed(_ sender: Any) {
        fadeDayEndControlsIn()
    }
    
    @IBAction func finishDayButton(_ sender: Any) {
        GAME.finishDay()
        self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueDayButton(_ sender: Any) {
        fadeDayEndControlsOut()
    }
    
    func fadeDayEndControlsIn() {
        self.dayContainerView.fadeOut(duration: 1, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.endDayTitleLabel.fadeIn(duration: 1, delay: 0)
            self.forwardButton.fadeIn(duration: 1, delay: 0)
            self.backButton.fadeIn(duration: 1, delay: 0)
        })
    }
    
    func fadeDayEndControlsOut() {
        self.endDayTitleLabel.fadeOut(duration: 1, delay: 0)
        self.backButton.fadeOut(duration: 1, delay: 0)
        self.forwardButton.fadeOut(duration: 1, delay: 0, completion: {
            (finished: Bool) -> Void in
            self.dayContainerView.fadeIn(duration: 1, delay: 0)
        })
    }
    
    func setupTableView() {
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
        }
        
        return UITableViewCell()
    }
    
}
