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
    @IBOutlet weak var eliminateButton: PMSuperButton!

    @IBOutlet weak var pickerView: UIPickerView!
    
    
    // MARK: - Variables
    
    var chosenPlayer: Player!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
        chosenPlayer = GAME.livingActors[0]
        
        pickerView.delegate = self
        pickerView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eliminatePlayerPressed(_ sender: Any) {
        eliminatePlayer(player: chosenPlayer)
        self.dismiss(animated: true, completion: nil)
    }
    
    func eliminatePlayer(player: Player) {
        GAME.eliminatePlayer(victim: player)
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
        chosenPlayer = GAME.livingActors[row]
    }
}