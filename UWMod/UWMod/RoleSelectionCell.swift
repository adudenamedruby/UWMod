//
//  RoleSelectionCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-30.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

class RoleSelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageBackgroundViewTop: UIView!
    @IBOutlet weak var imageBackgroundView: UIView!
    
    @IBOutlet weak var roleImage: UIImageView!
    @IBOutlet weak var remainingCharacters: UILabel!
    
    var roleName: String!
    var roleIcon: UIImage!
    
    
    func configureCell() {
        borderView.layer.cornerRadius = STYLE.CornerRadius
        mainView.layer.cornerRadius = STYLE.CornerRadius
        imageBackgroundViewTop.layer.cornerRadius = STYLE.CornerRadius
        
        borderView.backgroundColor = STYLE.Brown
        mainView.backgroundColor = STYLE.Tan
        imageBackgroundViewTop.backgroundColor = STYLE.Brown
        imageBackgroundView.backgroundColor = STYLE.Brown
        
        let attributedText = NSMutableAttributedString(string: roleName,
                                                       attributes: [NSFontAttributeName:STYLE.RegStandardFont!])
        attributedText.addAttribute(NSForegroundColorAttributeName,
                                    value: STYLE.Red,
                                    range: NSRange(location:0,length:1))
        
        remainingCharacters.attributedText = attributedText
        roleImage.image = roleIcon
    }
}
