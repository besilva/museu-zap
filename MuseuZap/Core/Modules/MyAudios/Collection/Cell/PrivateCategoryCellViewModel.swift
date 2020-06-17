//
//  PrivateCategoryCellViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 03/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit
import UIKit

class PrivateCategoryCellViewModel: CategoryCellViewModel {
    override var opacity: CGFloat { return 1 }
    override init(category: AudioCategory) {
        super.init(category: category)
        let color = UIColor.Default.lightBackground
        self.backgroundColor = color
        self.category = category
    }
}
