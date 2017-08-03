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
        tableView.register(UINib(nibName: "GeneralInfo", bundle: nil),
                           forCellReuseIdentifier: "generalInfoCell")

    }
}

extension DayVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "generalInfoCell", for: indexPath) as! GeneralInfo
            cell.configureCell()
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 320
        }
        
        return 100
    }
}
