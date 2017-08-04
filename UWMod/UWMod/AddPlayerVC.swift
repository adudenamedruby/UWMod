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
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mainCard: UIView!
    @IBOutlet var headerView: UIView!
    
    
    // MARK: - Variables
    
    let standardDefaults = UserDefaults.standard
    var savedPlayers: [String]?
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCard.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        mainCard.layer.cornerRadius = STYLE.CornerRadius
        
        nameField.delegate = self
        
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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
    }
    
    
    // MARK: - Button functionality
    
    @IBAction func savePlayerButton(_ sender: Any) {
        if let text = nameField.text, !text.isEmpty {
            savedPlayers?.append(text)
            standardDefaults.set(savedPlayers, forKey: PLAYERS)
            notifyTable()
            self.dismiss(animated: true, completion: {})

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
        self.dismiss(animated: true, completion: nil)
    }

}

extension AddPlayerVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            return true
        }
        
        let characterSetAllowed = CharacterSet.alphanumerics
        if let rangeOfCharactersAllowed = string.rangeOfCharacter(from: characterSetAllowed, options: .caseInsensitive) {
            // make sure it's all of them
            let validCharacterCount = string.characters.distance(from: rangeOfCharactersAllowed.lowerBound, to: rangeOfCharactersAllowed.upperBound)
            return validCharacterCount == string.characters.count
        } else  {
            // none of the characters are from the allowed set
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
