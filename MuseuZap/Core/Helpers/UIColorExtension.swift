//
//  UIColorExtension.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 23/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

extension UIColor {
    struct Default {
        static let background: UIColor = {
            if #available(iOS 13, *) {
                return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                    if UITraitCollection.userInterfaceStyle == .dark {
                        /// Return the color for Dark Mode
                        return UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1.0)
                    } else {
                        /// Return the color for Light Mode
                        return UIColor.white
                    }
                }
            } else {
                /// Return a fallback color for iOS 12 and lower.
                 return UIColor.white
            }
        }()
        static let lightBackground = UIColor(named: "light-bg")
        static let lightGray = UIColor(named: "light-gray")
        static let label = UIColor(named: "label")
        static let lightLabel = UIColor(named: "light-label")
        static let power = UIColor(named: "power")
    }
}
