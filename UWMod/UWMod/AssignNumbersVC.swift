//
//  AssignNumbersVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-20.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class AssignNumbersVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainCard:            UIView!
    @IBOutlet var headerView:               UIView!
    @IBOutlet weak var headerTitleLabel:    OldTan!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var darknessView: UIView!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var setNumberButton: UIButton!
    
    @IBOutlet weak var forwardButton:       PMSuperButton!
    @IBOutlet weak var backButton:          PMSuperButton!
    
    
    
    // MARK: - Variables
    
    let transition                          = CircularTransition()
    let standardDefaults                    = UserDefaults.standard
    var savedPlayers                        = [Person]()
    
    var passedPlayers:                      [Player]!

    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate                      = self
        tableView.dataSource                    = self
        
        mainCard.backgroundColor                = STYLE.Tan
        headerView.backgroundColor              = STYLE.Brown
        mainCard.layer.cornerRadius             = STYLE.CornerRadius
        
        let headerTitle                         = "Assign Player Numbers"
        headerTitleLabel.attributedText = headerTitle.styleTitleLabel(withStringFont: STYLE.OldStandardFont!, withColour: STYLE.Red)

//        nameField.delegate                      = self
//        nameField.autocorrectionType            = UITextAutocorrectionType.yes

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
    
    
    // MARK: - Button functionality

    @IBAction func setNumberButtonPressed(_ sender: Any) {
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "assignNumbersToRoleSelectSegue" {
            let secondVC = segue.destination as! RoleSelectVC
            secondVC.passedPlayers              = passedPlayers
            secondVC.transitioningDelegate      = self
            secondVC.modalPresentationStyle     = .custom
        }
    }

}

extension AssignNumbersVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "numberAssignmentCell", for: indexPath)
        
        cell.textLabel?.text                = passedPlayers[indexPath.row].name
        cell.textLabel?.textColor           = STYLE.Brown
        
        cell.detailTextLabel?.text          = "\(passedPlayers[indexPath.row].gameID)"
        cell.detailTextLabel?.textColor     = STYLE.Brown
        cell.detailTextLabel?.alpha         = 0.7
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AssignNumbersVC: UITextFieldDelegate {

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

extension AssignNumbersVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = forwardButton.center
        transition.circleColour = UIColor.black
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = backButton.center
        transition.circleColour = UIColor.black
        return transition
    }
}
