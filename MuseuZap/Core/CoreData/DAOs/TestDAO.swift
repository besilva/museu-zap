//
//  TesteDAO.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import CoreData
import UIKit

// Data Access Object for Teste Entity
class TesteDAO: DAOCoreData {
  typealias Entity = Teste
  var container: NSPersistentContainer!
  required init(container: NSPersistentContainer) {
    self.container = container
  }
  convenience init() {
    // Use the default container for production environment
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      fatalError("Can not get shared app delegate")
    }
    self.init(container: appDelegate.persistentContainer)
  }
}
