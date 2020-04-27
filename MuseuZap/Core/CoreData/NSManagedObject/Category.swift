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
        self.init(entity: entityDescription!, insertInto: nil)
    }
}

extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var has: NSSet?

}

// MARK: Generated accessors for has
extension Category {

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: Audio)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: Audio)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSSet)

}
