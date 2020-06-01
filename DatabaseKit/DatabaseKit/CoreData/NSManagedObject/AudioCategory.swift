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

    // MARK: - Properties Struct

/// Used to reduce clutter for View
public struct CategoryProperties {

    // MARK: - Properties

    var name: String
    var audios: [String]?
    var identifier: String?
    var isPrivate: Bool

    // MARK: - Init

    init(from category: AudioCategory) {
        self.name = category.categoryName
        self.identifier = category.identifier
        self.isPrivate = category.isPrivate
        
        if let audios = category.audios {
            for audio in audios {
                self.audios?.append(audio.audioName)
            }
        } else {
            self.audios = nil
        }
    }
}

    // MARK: - Class

/// NSManagedObject for Teste Entity.
/// Properties can be accessed through object properties a class instead of "set value for..".
/// Codegen set to manual
@objc(AudioCategory)
public class AudioCategory: NSManagedObject {
    public convenience init(intoContext managedContext: NSManagedObjectContext? = nil) {
        // To test this entity, another managedObjectContext is passed to the Entity
        let currentManagedObjectContext: NSManagedObjectContext
        if let context = managedContext {
            currentManagedObjectContext = context
        } else {
            currentManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        }

        // Create entity description
        let entityDescription = NSEntityDescription.entity(forEntityName: Entities.audioCategory.rawValue, in: currentManagedObjectContext)

        // Call super
        self.init(entity: entityDescription!, insertInto: currentManagedObjectContext)
    }
}

extension AudioCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AudioCategory> {
        return NSFetchRequest<AudioCategory>(entityName: Entities.audioCategory.rawValue)
    }

    @NSManaged public var categoryName: String
    @NSManaged public var identifier: String?
    @NSManaged public var audios: Set<Audio>?
    @NSManaged public var isPrivate: Bool

}

// MARK: Generated accessors for audios
extension AudioCategory {

    @objc(addAudiosObject:)
    @NSManaged public func addToAudios(_ value: Audio)

    @objc(removeAudiosObject:)
    @NSManaged public func removeFromAudios(_ value: Audio)

    @objc(addAudios:)
    @NSManaged public func addToAudios(_ values: NSSet)

    @objc(removeAudios:)
    @NSManaged public func removeFromAudios(_ values: NSSet)

}
