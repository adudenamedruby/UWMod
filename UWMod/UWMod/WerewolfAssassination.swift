//
//  WerewolfAssassination.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-05.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class WerewolfAssassination: UIView {

    // MARK: - Initializers
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var killVillagerButton: PMSuperButton!
    
    
    weak var delegate: UpdateCardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        Bundle.main.loadNibNamed("WerewolfAssassination", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.backgroundColor = STYLE.Tan
    }
    
    @IBAction func killVillagerPressed(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Popups", bundle: nil)
        let lynchView = storyboard.instantiateViewController(withIdentifier: "eliminatePlayer") as! EliminatePlayerVC
        lynchView.modalTransitionStyle = .crossDissolve
        lynchView.eliminatedBy = .Werewolf
        lynchView.updateCardDelegate = delegate

        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        topVC?.present(lynchView, animated: true, completion: nil)
        
        delegate?.updateCard()
        
    }
}
