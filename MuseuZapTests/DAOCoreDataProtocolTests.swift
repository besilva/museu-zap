//
//  MuseuZapTests.swift
//  MuseuZapTests
//
//  Created by Bernardo Silva on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap
import CoreData

// TODO: TEST from services

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

    func initStubs() {

        func insertTodoItem(titulo: String, subtitulo: String ) -> Teste? {
            let obj = NSEntityDescription.insertNewObject(forEntityName: "Teste", into: mockPersistantContainer.viewContext)

            obj.setValue(titulo, forKey: "titulo")
            obj.setValue(subtitulo, forKey: "subtitulo")

            return obj as? Teste
        }

        _ = insertTodoItem(titulo: "titulo 1", subtitulo: "subtitulo 1")
        _ = insertTodoItem(titulo: "titulo 2", subtitulo: "subtitulo 2")

        do {
            try mockPersistantContainer.viewContext.save()
        } catch {
            print("create fakes error \(error)")
        }

    }

    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Teste")
        // swiftlint:disable force_try
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)

        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }

        try! mockPersistantContainer.viewContext.save()
        // swiftlint:enable force_try
    }
}

    // MARK: - DAO

class DAOTests: XCTestCase {

    var sut: TesteDAO!
    var coreDataHelper: CoreDataTestHelper!

    override func setUp() {
        // This method is called before the invocation of each test method in the class.
        coreDataHelper = CoreDataTestHelper()
        sut = TesteDAO(container: coreDataHelper.mockPersistantContainer)
        coreDataHelper.initStubs()
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        sut = nil
        coreDataHelper.flushData()
        coreDataHelper = nil
    }

    // MARK: - Create

    /// Creates a new Element and asserts if error is nil
    func testCreate() {
        let entity = Teste(container: coreDataHelper.mockPersistantContainer)

        entity.subtitulo = "Test Create subtitle"
        entity.titulo = "Test Create title"

        var errorDatabase: Error?

        do {
            try sut.create(entity)
        } catch {
            errorDatabase = error
            print(errorDatabase ?? "databaseError Create")
        }

        XCTAssertNil(errorDatabase, "databaseError Create")
    }

    // MARK: - Read

    /// Read mocked database, count should be igual to 2
    func testReadAll() {
        var errorDatabase: Error?
        var array = [Teste]()

        do {
            try array = sut.readAll()
        } catch {
            errorDatabase = error
            print(errorDatabase ?? "databaseError read")
        }

        XCTAssertEqual(array.count, 2, "initStubs create only 2 item not \(array.count)!")
        XCTAssertNil(errorDatabase, "databaseError read")
    }

    // MARK: - Update

    /// Update saves the current context. Change the context and see if it was saved
    func testUpdate() {
        var errorDatabase: Error?
        var array = [Teste]()
        var element: Teste?

        do {
            try array = sut.readAll()
            element = array[0]
        } catch {
            errorDatabase = error
            print(errorDatabase ?? "databaseError read")
        }

        guard let item = element else { return }

        do {
            item.titulo = "item updated"
            try sut.updateContext()
        } catch {
            errorDatabase = error
            print(errorDatabase ?? "databaseError update")
        }

        XCTAssertEqual(item.titulo, "item updated", "Database was not updated")
        XCTAssertNil(errorDatabase, "databaseError update")
    }

    // MARK: - Delete

    /// Fetches the Elements, delete one and see if newArray count is one
    func testDelete() {
        var errorDatabase: Error?
        var array = [Teste]()
        var newArray = [Teste]()

        do {
           try array = sut.readAll()
        } catch {
           errorDatabase = error
           print(errorDatabase ?? "databaseError1 read")
        }

        let element = array[0]

        do {
           try sut.delete(element)
        } catch {
           errorDatabase = error
           print(errorDatabase ?? "databaseError1 delete")
        }

        do {
           try newArray = sut.readAll()
        } catch {
           errorDatabase = error
           print(errorDatabase ?? "databaseError2 read")
        }

        XCTAssertEqual(newArray.count, 1, "Database should have only one record")
        XCTAssertNil(errorDatabase, "databaseError update")
    }
}
