//
//  TisprCardStackViewCell.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-24.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

open class TisprCardStackViewCell: UICollectionViewCell {
    
    override open func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        let center = layoutAttributes.center
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = center.y
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.8, 2.0, 1.0, 1.0)
        layer.add(animation, forKey: "position.y")

        super.apply(layoutAttributes)
    }
    
}
