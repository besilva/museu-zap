//
//  CategoryCellViewModel.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import DatabaseKit

class CategoryCellViewModel {
    let category: AudioCategory
    
    init(category: AudioCategory) {
        self.category = category
    }
}
