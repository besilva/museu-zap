//
//  CategoryCellViewModel.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import DatabaseKit

class CategoryCellViewModel {
    private let category: AudioCategory
    var backgroundColor: UIColor?
    var icon: UIImage?
    var title: String {
        return category.categoryName
    }
    
    var opacity: CGFloat {
        if #available(iOS 13.0, *) {
            switch UITraitCollection.current.userInterfaceStyle {
            case .dark:
                return 0.2
            default:
                return 0.1
            }
        } else {
            return 0.1
        }
    }
    
    init(category: AudioCategory) {
        self.category = category
        
        if let identifier = category.identifier,
            let color = UIColor(named: identifier),
            let icon = UIImage(named: identifier) {
            self.backgroundColor = color
            self.icon = icon
        }
        
    }
    
}
