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

        func insertTodoItem(subtitulo: String, titulo: String ) -> Teste? {
            let obj = NSEntityDescription.insertNewObject(forEntityName: "Teste", into: mockPersistantContainer.viewContext)

            obj.setValue(subtitulo, forKey: "subtitulo")
            obj.setValue(titulo, forKey: "titulo")

            return obj as? Teste
        }

        _ = insertTodoItem(subtitulo: "1", titulo: "2")

        do {
            try mockPersistantContainer.viewContext.save()
        } catch {
            print("create fakes error \(error)")
        }

    }

    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Teste")
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        // swiftlint:disable force_try
        try! mockPersistantContainer.viewContext.save()
        // swiftlint:enable force_try
    }
}

class TesteDAOTests: XCTestCase {

    var sut: TesteDAO!
    var coreDataHelper: CoreDataTestHelper!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataHelper = CoreDataTestHelper()
        sut = TesteDAO(container: coreDataHelper.mockPersistantContainer)
        coreDataHelper.initStubs()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        coreDataHelper.flushData()
        coreDataHelper = nil
    }

    func testFindAll() {
        var errorDatabase: Error?
        var array = [Teste]()

        do {
            try array = sut.findAll()
        } catch {
            errorDatabase = error
            print(errorDatabase ?? "nil")
        }

        XCTAssertEqual(array.count, 1, "nao deu 1 deu \(array.count)")
        XCTAssertNil(errorDatabase, "error nao nil!")
    }

    func testSave() {
        var entity = Teste(container: coreDataHelper.mockPersistantContainer)

        entity.subtitulo = "Bernardo é god"
        entity.titulo = "Bernardo tem paciencia"

        var errorDatabase: Error?

        do {
            try sut.save(entity)
        } catch {
            errorDatabase = error
            print(errorDatabase)
        }

        XCTAssertNil(errorDatabase, "nao rolou!")
    }
}
