//
//  AudioCategoryServicesMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 01/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit

class AudioCategoryServicesMock: AudioCategoryServicesProtocol {
    func createCategory(category: AudioCategory, _ completion: (Error?) -> Void) {
    }

    func getAllCategories(_ completion: @escaping (Error?, [AudioCategory]?) -> Void) {
    }

    func updateAllCategories(_ completion: (Error?) -> Void) {
    }

    func deleteCategory(category: AudioCategory, _ completion: (Error?) -> Void) {
    }
    
    func getAllCategoriesWith(isPrivate bool: Bool, _ completion: @escaping (Error?, [AudioCategory]?) -> Void) {
        if !bool {
            completion(nil, addPublicCategories())
        }
    }
    
    private func addPublicCategories() -> [AudioCategory] {
        let category1 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category1.categoryName = "Engraçados"
        category1.identifier = "funny"
        category1.isPrivate = false
        
        let category2 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category2.categoryName = "Clássicos do Zap"
        category2.identifier = "classic"
        category2.isPrivate = false
        
        return [category1, category2]
    }
}
