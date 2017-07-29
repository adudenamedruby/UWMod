//
//  AddPlayerVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-28.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class AddPlayerVC: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mainCard: UIView!
    
    let standardDefaults = UserDefaults.standard
    var savedPlayers: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        
        mainCard.layer.cornerRadius = 10
        savedPlayers = standardDefaults.object(forKey: PLAYERS) as? [String] ?? [String]()
        print(savedPlayers)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func notifyTable() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
    }
    
    @IBAction func savePlayerButton(_ sender: Any) {
        if let text = nameField.text, !text.isEmpty {
            savedPlayers?.append(text)
            standardDefaults.set(savedPlayers, forKey: PLAYERS)
            notifyTable()
        } else {
            let alert = UIAlertController(title: "Error!", message: "Cannot save an empty text field.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
        }
        
        self.dismiss(animated: true, completion: {})
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
