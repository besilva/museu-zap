//
//  AudioDAO.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import CoreData
import UIKit

/// Data Access Object for Audio Entity
class AudioDAO: DAOCoreData {
    typealias Entity = Audio
    var container: NSPersistentContainer!

    required init(container: NSPersistentContainer) {
        self.container = container
    }

    convenience init() {
    // Use the default container for production environment
        self.init(container: CoreDataManager.sharedInstance.persistentContainer)
    }
}
