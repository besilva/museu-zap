//
//  HeaderCategoryDetailViewModel.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 05/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import DatabaseKit

class HeaderCategoryDetailViewModel {
    let category: AudioCategory
    
    lazy var title: String = {
        return category.categoryName
    }()
    
    lazy var audioCount: String = {
        guard let audios = self.category.audios, audios.count > 0 else { return "Sem audios" }
        switch audios.count {
        case 1:
            return "\(audios.count) áudio"
        default:
            return "\(audios.count) áudios"
        }
    }()
    
    init(category: AudioCategory) {
        self.category = category
    }
}
