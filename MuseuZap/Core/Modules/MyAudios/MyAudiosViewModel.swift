//
//  MyAudiosViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 02/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import DatabaseKit
import UIKit

class MyAudiosViewModel: ListViewModel {
    var audiosWithoutCategories: [Audio] = []
    required init(audioServices: AudioServicesProtocol, audioCategoryServices: AudioCategoryServicesProtocol, delegate: ListViewModelDelegate) {
        super.init(audioServices: audioServices, audioCategoryServices: audioCategoryServices, delegate: delegate)
        retrieveAllCategoriesWith(isPrivate: true)
    }
    
    func getNoCategory() {
        AudioCategoryServices().getAllCategoriesWith(isPrivate: true) { (_, categories) in // error, categories
            if let categories = categories,
                let category = categories.first(where: { $0.categoryName == "Sem Categoria"}) {
                self.audiosWithoutCategories = Array(category.audios ?? [])
            }
            self.delegate?.endRefreshing()
        }
    }
    // TODO: Retrieve audios w/o categories here
    override func retrieveAllAudios() {
        getNoCategory()
    }
    
    override func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties {
        let element = audiosWithoutCategories[indexPath.row]
        return AudioProperties(from: element)
    }
}
