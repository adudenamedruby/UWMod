//
//  AddPlayerVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-28.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class AddPlayerVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var nameField:           UITextField!
    @IBOutlet weak var mainCard:            UIView!
    @IBOutlet var headerView:               UIView!
    @IBOutlet weak var headerTitleLabel:    OldTan!
    @IBOutlet var statusLabel: RegBrownSmall!
    
    @IBOutlet var addPlayerButton: UIButton!
    
    // MARK: - Variables
    
    let standardDefaults                    = UserDefaults.standard
    var savedPlayers:                       [String]?
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCard.backgroundColor                = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        mainCard.layer.cornerRadius             = STYLE.CornerRadius
        
        let headerTitle                         = "Add Player"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)
        
        statusLabel.text                        = ""
        addPlayerButton.titleLabel?.textColor   = STYLE.Tan
        addPlayerButton.layer.cornerRadius      = STYLE.CornerRadius
        
        nameField.delegate                      = self
        nameField.autocorrectionType            = UITextAutocorrectionType.yes
        
        savedPlayers = standardDefaults.object(forKey: PLAYERS) as? [String] ?? [String]()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Keyboard Functions
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height/2
            }
        }
    }

    
    // MARK: - Notifications
    
    func notifyTable() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ReloadTableForNewPlayersNotification), object: nil)
    }
    
    
    // MARK: - Button functionality
    
    @IBAction func savePlayerButton(_ sender: Any) {
        if let textEntry = nameField.text, !textEntry.isEmpty {
            let text = textEntry.trimmingCharacters(in: .whitespacesAndNewlines)
            
            savedPlayers?.append(text)
            standardDefaults.set(savedPlayers, forKey: PLAYERS)
            statusLabel.text = "Added \(text) to players."
            statusLabel.alpha = 1
            statusLabel.fadeOut(duration: 1, delay: 1)
            nameField.text = ""
            
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainAlert") as! AlertsVC
            vc.alertName = "Error"
            vc.alertText = "Please enter a name."
            vc.modalTransitionStyle = .crossDissolve
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        notifyTable()
        self.dismiss(animated: true, completion: nil)
    }

}

extension AddPlayerVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            return true
        }

        let characterSetNotAllowed = CharacterSet(charactersIn: "1234567890[]!@#$%^&*()){}|\\?+/=_\",<>:;")
        if let _ = string.rangeOfCharacter(from: characterSetNotAllowed, options: .caseInsensitive) {
            // They are trying to add caracters not allowed.
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
