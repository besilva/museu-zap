//
//  Teste+Teste+CoreDataClass.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/// NSManagedObject for Teste Entity.
/// Properties can be accessed through teste.titulo instead of "set value for..".
/// Codegen set to manual
public class Teste: NSManagedObject {

    convenience init(container: NSPersistentContainer? = nil) {
        let managedObjectContext: NSManagedObjectContext
        if let container = container {
            managedObjectContext = container.viewContext
        } else {
            managedObjectContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        }
        // Get context
//        self.objectID USAR COMO ID

        // Create entity description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Teste", in: managedObjectContext)

        // Call super
        self.init(entity: entityDescription!, insertInto: nil)
    }
}

extension Teste {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teste> {
        return NSFetchRequest<Teste>(entityName: "Teste")
    }

    @NSManaged public var titulo: String?
    @NSManaged public var subtitulo: String?

}