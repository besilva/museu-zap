//
//  ExploreViewModel.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 05/06/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import DatabaseKit

class ExploreViewModel: ListViewModel {

    override func retrieveAllAudios() {
        self.audioServices.getAllAudiosWith(isPrivate: false) { (error, audios) in
            if let audios = audios {
                // Assign teste Array
                self.audios = audios
                // Get array is only called in Init and when refresh, so no problem to leave these delegate calls here
                self.delegate?.stopLoading()
                self.delegate?.endRefreshing()
            } else {
                // GetAll audios
                // Display here some frendiler message based on Error Type (database error or not)
                print("Error retrieving all audios")
                print(error ?? "Some default error value")
            }
        }
    }
}
