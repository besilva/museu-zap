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
    required init(audioServices: AudioServicesProtocol, audioCategoryServices: AudioCategoryServicesProtocol, delegate: ListViewModelDelegate) {
        super.init(audioServices: audioServices, audioCategoryServices: audioCategoryServices, delegate: delegate)
        retrieveAllCategoriesWith(isPrivate: true)
    }
}
