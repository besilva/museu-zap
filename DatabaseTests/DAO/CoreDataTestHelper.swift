//
//  CoreDataTestHelper.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 29/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import CoreData
@testable import Database

    // MARK: - CoreDataTestHelper

/// Mocks the persistant Container and Current managedObject
/// Contex is RAM Memory insted of the own App Database
class CoreDataTestHelper {

    lazy var managedObjectModel: NSManagedObjectModel = {
            let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
            return managedObjectModel
    }()

    lazy var mockPersistantContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MuseuZap", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

    func initStubs() -> Database.AudioCategory {
        // Contex is RAM Memory insted of the own App Database
        let context = mockPersistantContainer.viewContext
        var collaborator: Database.AudioCategory!

        // For predicate method - public audios
        for i in 1...2 {
            let audio = Audio(intoContext: mockPersistantContainer.viewContext)
            let category: Database.AudioCategory = Database.AudioCategory(intoContext: mockPersistantContainer.viewContext)

            category.categoryName = "Category \(i)"

            audio.audioName = "Mock v.\(i)"
            audio.audioPath = "/Mocks/MuseuZap/Audio\(i)"
            audio.duration = 5.44
            audio.isPrivate = false

            category.addToAudios(audio)

            collaborator = category
        }

        // For predicate method - Private Audio
        let audio = Audio(intoContext: context)
        let category: Database.AudioCategory = Database.AudioCategory(intoContext: context)

        category.categoryName = "Category Private"
        category.addToAudios(audio)

        audio.audioName = "Mock v. Private"
        audio.audioPath = "/Mocks/MuseuZap/Audio/private"
        audio.isPrivate = true
        audio.duration = 5.44

        // Initialize collaborator
        collaborator = category

        do {
            try mockPersistantContainer.viewContext.save()
        } catch {
            print("CREATE init Stubs ERROR \n \(error)")
        }

        return collaborator
    }

    func flushData(from entity: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: entity)

        do {
            let objs = try mockPersistantContainer.viewContext.fetch(fetchRequest)

            for case let obj as NSManagedObject in objs {
                mockPersistantContainer.viewContext.delete(obj)
            }
        } catch {
            print("FLUSH DATA init Stubs ERROR \n \(error)")
        }

        do {
            try mockPersistantContainer.viewContext.save()
        } catch {
            print("FLUSH DATA init Stubs ERROR \n \(error)")
        }
    }
}
