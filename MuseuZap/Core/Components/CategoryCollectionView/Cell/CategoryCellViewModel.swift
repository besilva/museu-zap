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
    var audiosText: String
    
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
        
        if let identifier = category.assetIdentifier,
            let color = UIColor(named: identifier),
            let icon = UIImage(named: identifier) {
            self.backgroundColor = color
            self.icon = icon
        }
        self.audiosText = CategoryCellViewModel.generateAudiosText(audios: category.audios?.count)
    }
    
    static func generateAudiosText(audios: Int?) -> String {
        guard let audios = audios, audios > 0 else { return "Sem audios" }
        switch audios {
        case 1:
            return "\(audios) audio"
        default:
            return "\(audios) audios"
        }
    }
    
}
