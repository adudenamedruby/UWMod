//
//  MenuRoleHelpVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-31.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class MenuRoleHelpVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var mainCardView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: OldTan!
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Variables
    let availableRoles: [Role]    = [BEHOLDER,
                                     BODYGUARD,
                                     CULTLEADER,
                                     CUPID,
                                     CURSED,
                                     DISEASED,
                                     DREAMWOLF,
                                     GHOST,
                                     HUNTER,
                                     INSOMNIAC,
                                     LONE_WOLF,
                                     LYCAN,
                                     MAD_BOMBER,
                                     MASON_ONE,
                                     MAYOR,
                                     MINION,
                                     PACIFIST,
                                     PRIEST,
                                     SEER,
                                     SORCERESS,
                                     SPELLCASTER,
                                     TANNER,
                                     THE_BLOB,
                                     THE_COUNT,
                                     THING,
                                     TROUBLEMAKER,
                                     VILLAGE_IDIOT,
                                     VILLAGER_ONE,
                                     VIRGINIA_WOOLF,
                                     WEREWOLF_ONE,
                                     WITCH,
                                     WOLFCUB,
                                     WOLFMAN,
                                     ZOMBIE]
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        let headerTitle = "Available Roles"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MenuRoleHelpVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableRoles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuRoleHelpCell", for: indexPath)
        
        cell.textLabel?.text            = availableRoles[indexPath.row].name
        cell.textLabel?.font            = STYLE.RegBoldTableView
        cell.textLabel?.textColor       = STYLE.Brown
        cell.textLabel?.textAlignment   = .center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard              = UIStoryboard(name: "Popups", bundle: nil)
        let roleClarification       = storyboard.instantiateViewController(withIdentifier: "roleClarificationPopupVC") as! RoleClarificationPopupVC
        roleClarification.roleInfo  = availableRoles[indexPath.row]
        self.present(roleClarification, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
