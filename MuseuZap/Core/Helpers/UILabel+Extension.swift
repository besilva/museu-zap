//
//  UILabel+Extension.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 24/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

extension UILabel {
    var dynamicFont: UIFont {
        set {
            self.numberOfLines = 0
            
            if #available(iOS 10.0, *) {
                // Real-time size update
                self.adjustsFontForContentSizeCategory = true
            }
            
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            self.font = fontMetrics.scaledFont(for: newValue)
        }
        
        get {
            return self.font
        }
    }
}
