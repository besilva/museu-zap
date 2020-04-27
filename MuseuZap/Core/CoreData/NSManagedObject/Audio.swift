//
//  Audio.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//
//

import Foundation
import CoreData

/// NSManagedObject for Teste Entity.
/// Properties can be accessed through object properties a class instead of "set value for..".
/// Codegen set to manual
public class Audio: NSManagedObject {
    convenience init(container: NSPersistentContainer? = nil) {
        let managedObjectContext: NSManagedObjectContext
        if let container = container {
            managedObjectContext = container.viewContext
        } else {
            managedObjectContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        }
        // Get context
        // Self.objectID USAR COMO ID

        // Create entity description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Audio", in: managedObjectContext)

        // Call super
        self.init(entity: entityDescription!, insertInto: nil)
    }
}

extension Audio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Audio> {
        return NSFetchRequest<Audio>(entityName: "Audio")
    }

    @NSManaged public var audioName: String
    @NSManaged public var audioPath: String
    @NSManaged public var isPrivate: Bool
    @NSManaged public var belongsTo: Category?

}
