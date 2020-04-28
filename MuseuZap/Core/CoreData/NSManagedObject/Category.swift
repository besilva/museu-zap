//
//  Category.swift
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
@objc(Category)
public class Category: NSManagedObject {
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
        let entityDescription = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext)

        // Call super
        self.init(entity: entityDescription!, insertInto: managedObjectContext)
    }
}

extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var audios: NSSet?

}

// MARK: Generated accessors for audios
extension Category {

    @objc(addAudiosObject:)
    @NSManaged public func addToAudios(_ value: Audio)

    @objc(removeAudiosObject:)
    @NSManaged public func removeFromAudios(_ value: Audio)

    @objc(addAudios:)
    @NSManaged public func addToAudios(_ values: NSSet)

    @objc(removeAudios:)
    @NSManaged public func removeFromAudios(_ values: NSSet)

}
