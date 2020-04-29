//
//  DAOCoreDataProtocolTests
//  MuseuZapTests
//
//  Created by Ivo Dutra on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap
import CoreData

    // MARK: - DAO

class DAOTests: XCTestCase {

    var sut: AudioDAO!
    var coreDataHelper: CoreDataTestHelper!
    /// A Category Entity Object used to help to test AudioDAO, already saved in context
    var collaborator: MuseuZap.Category!

    override func setUp() {
        // This method is called before the invocation of each test method in the class.
        coreDataHelper = CoreDataTestHelper()
        sut = AudioDAO(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        collaborator = coreDataHelper.initStubs()
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        sut = nil
        // Audio should be flushed first because category cannot be nil
        coreDataHelper.flushData(from: "Audio")
        coreDataHelper.flushData(from: "Category")
        coreDataHelper = nil
    }

    // MARK: - Create

    /// Creates a new Element (first without viewContext) and asserts if error is nil
    func testCreate() {
        let audio = Audio(intoContext: coreDataHelper.mockPersistantContainer.viewContext)
        var databaseError: Error?

        audio.audioName = "Mock audio create"
        audio.audioPath = "/Mocks/Path/"
        audio.duration = 5.44
        audio.isPrivate = false

        collaborator.addToAudios(audio)

        do {
            try sut.create(audio)
        } catch {
            databaseError = error
            print(databaseError ?? "databaseError Create")
        }

        XCTAssertNil(databaseError, "databaseError Create")
    }

    // MARK: - Read

    /// Read mocked database, count should be igual to 3
    func testReadAll() {
        var databaseError: Error?
        var audioArray = [Audio]()

        do {
            try audioArray = sut.readAll()
        } catch {
            databaseError = error
            print(databaseError ?? "databaseError read")
        }

        XCTAssertEqual(audioArray.count, 3, "initStubs create only 3 item not \(audioArray.count)!")
        XCTAssertNil(databaseError, "databaseError read")
    }

    // MARK: - Update

    /// Update saves the current context. Change the context and see if it was saved
    func testUpdate() {
        var databaseError: Error?
        var audioArray = [Audio]()
        var element: Audio?

        do {
            try audioArray = sut.readAll()
            element = audioArray[0]
        } catch {
            databaseError = error
            print(databaseError ?? "databaseError read")
        }

        guard let item = element else { return }

        do {
            item.audioName = "Mock Name updated"
            try sut.updateContext()
        } catch {
            databaseError = error
            print(databaseError ?? "databaseError update")
        }

        XCTAssertEqual(item.audioName, "Mock Name updated", "Database was not updated")
        XCTAssertNil(databaseError, "databaseError update")
    }

    // MARK: - Delete

    /// Fetches the Elements, delete one and see if newArray count is two
    func testDelete() {
        var databaseError: Error?
        var audioArray = [Audio]()
        var newArray = [Audio]()

        do {
           try audioArray = sut.readAll()
        } catch {
           databaseError = error
           print(databaseError ?? "databaseError1 read")
        }

        let element = audioArray[0]

        do {
           try sut.delete(element)
        } catch {
           databaseError = error
           print(databaseError ?? "databaseError1 delete")
        }

        do {
           try newArray = sut.readAll()
        } catch {
           databaseError = error
           print(databaseError ?? "databaseError2 read")
        }

        XCTAssertEqual(newArray.count, 2, "Database should have only two records")
        XCTAssertNil(databaseError, "databaseError update")
    }

    /// Fetches the Elements, delete all and see if newArray count is zero
    func testDeleteAll() {
        var databaseError: Error?
        var array = [Audio]()
        var newArray = [Audio]()

        do {
           try array = sut.readAll()
        } catch {
           databaseError = error
           print(databaseError ?? "databaseError1 read")
        }

        let element = array[0]

        do {
           try sut.deleteAll(element)
        } catch {
           databaseError = error
           print(databaseError ?? "databaseError1 delete")
        }

        do {
           try newArray = sut.readAll()
        } catch {
           databaseError = error
           print(databaseError ?? "databaseError2 read")
        }

        XCTAssertEqual(newArray.count, 0, "Database should have no records")
        XCTAssertNil(databaseError, "databaseError update")
    }

    // MARK: - PREDICATE

    // Test method with NSpredicate to fetch only isPrivate=true audios
    func testPredicatePrivate() {
        var databaseError: Error?
        var privateAudios = [Audio]()

        do {
            try privateAudios = sut.fetchAudiosWith(isPrivate: true)
        } catch {
            databaseError = error
            print(databaseError ?? "databaseError read")
        }

        XCTAssertEqual(privateAudios.count, 1, "initStubs create only 1 private audio not \(privateAudios.count)!")
        XCTAssertNil(databaseError, "databaseError read")
    }

    // Test method with NSpredicate to fetch only isPrivate=true audios
    func testPredicatePublic() {
        var databaseError: Error?
        var publicAudios = [Audio]()

        do {
            try publicAudios = sut.fetchAudiosWith(isPrivate: false)
        } catch {
            databaseError = error
            print(databaseError ?? "databaseError read")
        }

        XCTAssertEqual(publicAudios.count, 2, "initStubs create exactly 2 public audios not \(publicAudios.count)!")
        XCTAssertNil(databaseError, "databaseError read")
    }
}

    // MARK: - CoreDataTestHelper

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

    func initStubs() -> MuseuZap.Category {
        // Contex is RAM Memory insted of the own App Database
        let context = mockPersistantContainer.viewContext
        var collaborator: MuseuZap.Category!

        // For predicate method - public audios
        for i in 1...2 {
            let audio = Audio(intoContext: mockPersistantContainer.viewContext)
            let category: MuseuZap.Category = MuseuZap.Category(intoContext: mockPersistantContainer.viewContext)

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
        let category: MuseuZap.Category = MuseuZap.Category(intoContext: context)

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
