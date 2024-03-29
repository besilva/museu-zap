//
//  CategoryCollectionViewModel.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 22/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import DatabaseKit

protocol CategoryCollectionViewModelDelegate: class {
    func reloadCollectionData()
}

protocol CategoryCollectionViewModelProtocol {
    var categories: [AudioCategory] {get set}
    var service: AudioCategoryServicesProtocol {get}
    var delegate: CategoryCollectionViewModelDelegate? {get set}
}

class CategoryCollectionViewModel: CategoryCollectionViewModelProtocol {
    
    var categories: [AudioCategory]
    var service: AudioCategoryServicesProtocol
    weak var delegate: CategoryCollectionViewModelDelegate?
    
    init(service: AudioCategoryServicesProtocol) {
        self.service = service
        categories = []
        retrieveAllCategories()
    }
    
    func retrieveAllCategories() {
        service.getAllCategoriesWith(isPrivate: false) { (error, categories) in
            if let error = error {
                print(error)
            } else if let categories = categories {
                self.categories = categories
                self.delegate?.reloadCollectionData()
            }
        }
    }
}
