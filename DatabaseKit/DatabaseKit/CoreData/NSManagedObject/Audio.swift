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

// MARK: - Properties Struct

/// Used to reduce clutter for View
public struct AudioProperties {

    // MARK: - Properties

    public var name: String
    public var path: String
    public var isPrivate: Bool
    public var duration: TimeInterval = 0
    public var category: String?

    // MARK: - Init

    public init(from audio: Audio) {
        self.name = audio.audioName
        self.path = audio.audioPath
        self.category = audio.category.categoryName
        self.duration = audio.duration
        self.isPrivate = audio.isPrivate
    }
}

    // MARK: - Class

/// NSManagedObject for Teste Entity.
/// Properties can be accessed through object properties a class instead of "set value for..".
/// Codegen set to manual
public class Audio: NSManagedObject {
    public convenience init(intoContext managedContext: NSManagedObjectContext? = nil) {
        // To test this entity, another managedObjectContext is passed to the Entity
        let currentManagedObjectContext: NSManagedObjectContext
        if let context = managedContext {
            currentManagedObjectContext = context
        } else {
            currentManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        }

        // Create entity description
        let entityDescription = NSEntityDescription.entity(forEntityName: Entities.audio.rawValue, in: currentManagedObjectContext)

        // Call super
        self.init(entity: entityDescription!, insertInto: currentManagedObjectContext)
    }
}

extension Audio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Audio> {
        return NSFetchRequest<Audio>(entityName: Entities.audio.rawValue)
    }

    @NSManaged public var audioName: String
    @NSManaged public var audioPath: String
    @NSManaged public var isPrivate: Bool
    @NSManaged public var duration: Double
    @NSManaged public var category: AudioCategory
}
