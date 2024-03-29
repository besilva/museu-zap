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
            let mock = AudioMock()
            _ = mock.addPublicCategories()
            completion(nil, [mock.category1, mock.category2]) 
        }
    }

}
