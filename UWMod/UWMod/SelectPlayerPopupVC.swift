//
//  SelectPlayerPopupVC.swift
//  UWMod
//
//  Created by roux buciu on 2017-08-10.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class SelectPlayerPopupVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mainCardView:            UIView!
    @IBOutlet weak var headerView:              UIView!
    @IBOutlet weak var headerTitleLabel:        OldTan!
    @IBOutlet weak var backButton:              UIButton!
    @IBOutlet weak var selectButton:            PMSuperButton!
    
    @IBOutlet weak var tableView:               UITableView!
    
    
    // MARK: - Variables

    let textCellIdentifier                  = "PlayerNameCell"
    var chosenPlayer:                       Player?
    //var players: [Player]                   = []
    
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate                  = self
        tableView.dataSource                = self
        tableView.allowsMultipleSelection   = false
        //populatePlayers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //populatePlayers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button functions
    
    @IBAction func selectPlayer(_ sender: Any) {
        if chosenPlayer != nil {
            // TODO: Add a notification here based on case to call back to the specific view?
            GAME.setChosenPlayer(player: chosenPlayer!)
            self.dismiss(animated: true, completion: nil)
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
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Functions
    
//    private func populatePlayers() {
//        players.removeAll()
//        
//        for player in GAME.livingActors {
//            players.append(player)
//        }
//        
//        players.sort(by: { $0.name < $1.name } )
//    }
    

}

extension SelectPlayerPopupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GAME.livingActors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = GAME.livingActors[row].name
        cell.textLabel?.textColor = STYLE.Brown
        cell.accessoryType = .checkmark
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        chosenPlayer = GAME.livingActors[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        chosenPlayer = nil
    }
    
}
