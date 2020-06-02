//
//  MyAudiosViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 01/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit
import UIKit

protocol MyAudiosViewModelProtocol {
    var categoryServices: AudioCategoryServices { get set }
    var categories: [AudioCategory] { get set }
    var navigationDelegate: NavigationDelegate? { get set }
}

class MyAudiosViewModel: ListViewModel {
    var categories: [AudioCategory] = []
    var categoryServices: AudioCategoryServices
    internal weak var navigationDelegate: NavigationDelegate?
    
    init(categoryServices: AudioCategoryServices) {
        
    }
}
