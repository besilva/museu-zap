//
//  PrivateCategoryCell.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit
import UIKit

class PrivateCategoryCell: CategoryCell {
    override func render() {
        super.render()
        self.layer.masksToBounds = false
        self.iconImageView.tintColor = UIColor.Default.power
    }

    override func layoutSubviews() {
        //        Adds shadow
        self.contentView.layer.cornerRadius = 16
        self.contentView.layer.masksToBounds = false

        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        self.layer.masksToBounds = false
    }
}
