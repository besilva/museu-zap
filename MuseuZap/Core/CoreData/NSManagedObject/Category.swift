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
    convenience init(intoContext managedContext: NSManagedObjectContext? = nil) {
        // To test this entity, another managedObjectContext is passed to the Entity
        let currentManagedObjectContext: NSManagedObjectContext
        if let context = managedContext {
            currentManagedObjectContext = context
        } else {
            currentManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        }

        // Create entity description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Category", in: currentManagedObjectContext)

        // Call super
        self.init(entity: entityDescription!, insertInto: currentManagedObjectContext)
    }
}

extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var audios: Set<Audio>?

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

    // MARK: - Properties

/// Used to reduce clutter for View
struct CategoryProperties {

    init(from category: Category) {
        self.name = category.categoryName ?? " - "
        
        if let audios = category.audios {
            for audio in audios {
                self.audios?.append(audio.audioName)
            }
        } else {
            self.audios = nil
        }

    }

    var name: String
    var audios: [String]?
}
