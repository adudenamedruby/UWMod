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
    
    
    // MARK: - Variables
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
}
