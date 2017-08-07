//
//  EliminatePlayerVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-02.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class EliminatePlayerVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: OldTan!
    @IBOutlet weak var eliminateButton: PMSuperButton!

    @IBOutlet weak var pickerView: UIPickerView!
    
    
    // MARK: - Variables
    
    var playerToBeKilled: Player!
    var eliminatedBy: RoleType?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        let headerTitle = "Player Elimination"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        playerToBeKilled = GAME.livingActors[0]
        
        pickerView.delegate = self
        pickerView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button functionality
    
    @IBAction func eliminatePlayerPressed(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let confirmView = storyboard.instantiateViewController(withIdentifier: "confirmationPopup") as! ConfirmationPopup
        confirmView.modalTransitionStyle = .crossDissolve
        
        confirmView.player = playerToBeKilled
        if (eliminatedBy != nil) {
            confirmView.eliminatedBy = eliminatedBy
        }
        self.present(confirmView, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension EliminatePlayerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GAME.livingActors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GAME.livingActors[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerToBeKilled = GAME.livingActors[row]
    }
}
