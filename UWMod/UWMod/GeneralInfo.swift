//
//  GeneralInfo.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-08-02.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class GeneralInfo: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var timeLabel: RegularTextBrownLabel!
    
    //MARK: - Variables
    
    
    //MARK: - View Lifecycle & Configuration
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outlineView.layer.cornerRadius = STYLE.CornerRadius
        outlineView.backgroundColor = STYLE.Brown
        mainCardView.layer.cornerRadius = STYLE.CornerRadius
        mainCardView.backgroundColor = STYLE.Tan
        headerView.backgroundColor = STYLE.Brown
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell() {
        
    }
    @IBAction func info(_ sender: Any) {
        
        print("I'mA live")
    }
}
