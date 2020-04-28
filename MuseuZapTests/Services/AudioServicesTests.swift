////
////  AudioServicesTests.swift
////  MuseuZapTests
////
////  Created by Ivo Dutra on 06/04/20.
////  Copyright © 2020 Bernardo. All rights reserved.
////
//
//import XCTest
//@testable import MuseuZap
//import CoreData
//
//// TODO: TEST from services
//
//    // MARK: - AudioServicesMockHelper
//
//// ShouldError: BooleanLiteralType
////
//// If
//
//class AudioServicesMockHelper {
//
//    lazy var managedObjectModel: NSManagedObjectModel = {
//            let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
//            return managedObjectModel
//    }()
//
//    lazy var mockPersistantContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "MuseuZap", managedObjectModel: self.managedObjectModel)
//        let description = NSPersistentStoreDescription()
//        description.type = NSInMemoryStoreType
//        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
//
//        container.persistentStoreDescriptions = [description]
//        container.loadPersistentStores { (description, error) in
//            // Check if the data store is in memory
//            precondition( description.type == NSInMemoryStoreType )
//
//            // Check if creating container wrong
//            if let error = error {
//                fatalError("Create an in-mem coordinator failed \(error)")
//            }
//        }
//        return container
//    }()
//
//    func initStubs() {
//        // Contex is RAM Memory insted of the own App Database
//        let context = mockPersistantContainer.viewContext
//        // Get entity, then generatehow  an object from it
//        guard let entity1 = NSEntityDescription.entity(forEntityName: "Audio", in: context),
//            let entity2 = NSEntityDescription.entity(forEntityName: "Category", in: context)
//        else {
//            fatalError("Could not find entities")
//        }
//
//        for i in 1...3 {
//            let audio = Audio(entity: entity1, insertInto: context)
//            let category = Category(entity: entity2, insertInto: context)
//
//            category.categoryName = "Category \(i)"
//
//            audio.audioName = "Mock v.\(i)"
//            audio.audioPath = "/Mocks/MuseuZap/Audio\(i)"
//            audio.isPrivate = true
//
//            category.addToAudios(audio)
//            print("print for breakpoint")
//
//        }
//
//        do {
//            try mockPersistantContainer.viewContext.save()
//        } catch {
//            print("create fakes error \(error)")
//        }
//
//    }
//
//}
//
//    // MARK: - Audio Services
//
//class AudioServicesTests: XCTestCase {
//
//    var sut: AudioServices!
//    var coreDataHelper: CoreDataTestHelper!
//
//    override func setUp() {
//        // This method is called before the invocation of each test method in the class.
//        coreDataHelper = CoreDataTestHelper()
////        sut = AudioServices
//        _ = coreDataHelper.initStubs()
//    }
//
//    override func tearDown() {
//        // This method is called after the invocation of each test method in the class.
//        sut = nil
//        // Audio should be flushed first because category cannot be nil
//        coreDataHelper.flushData(from: "Audio")
//        coreDataHelper.flushData(from: "Category")
//        coreDataHelper = nil
//    }
//
//    // MARK: - Create
//
//    /// Creates a new Element (first without viewContext) and asserts if error is nil
//    func testCreate() {
//
//        // Ai o workaround seria depender do banco mas é justamente isso que a gente não quer.
//        // Já que to aqui, como dar o throuugh correto no Erro?
//
//        let category = Category(container: coreDataHelper.mockPersistantContainer)
//        let audio = Audio(container: coreDataHelper.mockPersistantContainer)
//        var databaseError: Error?
//
//        category.categoryName = "Mock Category"
////        category.audios = [audio]
//
//        audio.audioName = "Mock audio create"
//        audio.audioPath = "/Mocks/Path/"
//        audio.isPrivate = false
//        audio.category = category // Era pra ser equivalente ao owner!! Mas assim da categoria não valida
////        category.addToAudios(audio)
//
//        do {
//            try sut.create(audio)
//        } catch {
//            databaseError = error
//            print(error)
//            print(databaseError ?? "databaseError Create")
//        }
//
//        XCTAssertNil(databaseError, "databaseError Create")
//    }
//
//    // MARK: - Read
////
////    /// Read mocked database, count should be igual to 2
////    func testReadAll() {
////        var errorDatabase: Error?
////        var array = [Teste]()
////
////        do {
////            try array = sut.readAll()
////        } catch {
////            errorDatabase = error
////            print(errorDatabase ?? "databaseError read")
////        }
////
////        XCTAssertEqual(array.count, 2, "initStubs create only 2 item not \(array.count)!")
////        XCTAssertNil(errorDatabase, "databaseError read")
////    }
////
////    // MARK: - Update
////
////    /// Update saves the current context. Change the context and see if it was saved
////    func testUpdate() {
////        var errorDatabase: Error?
////        var array = [Teste]()
////        var element: Teste?
////
////        do {
////            try array = sut.readAll()
////            element = array[0]
////        } catch {
////            errorDatabase = error
////            print(errorDatabase ?? "databaseError read")
////        }
////
////        guard let item = element else { return }
////
////        do {
////            item.titulo = "item updated"
////            try sut.updateContext()
////        } catch {
////            errorDatabase = error
////            print(errorDatabase ?? "databaseError update")
////        }
////
////        XCTAssertEqual(item.titulo, "item updated", "Database was not updated")
////        XCTAssertNil(errorDatabase, "databaseError update")
////    }
////
////    // MARK: - Delete
////
////    /// Fetches the Elements, delete one and see if newArray count is one
////    func testDelete() {
////        var errorDatabase: Error?
////        var array = [Teste]()
////        var newArray = [Teste]()
////
////        do {
////           try array = sut.readAll()
////        } catch {
////           errorDatabase = error
////           print(errorDatabase ?? "databaseError1 read")
////        }
////
////        let element = array[0]
////
////        do {
////           try sut.delete(element)
////        } catch {
////           errorDatabase = error
////           print(errorDatabase ?? "databaseError1 delete")
////        }
////
////        do {
////           try newArray = sut.readAll()
////        } catch {
////           errorDatabase = error
////           print(errorDatabase ?? "databaseError2 read")
////        }
////
////        XCTAssertEqual(newArray.count, 1, "Database should have only one record")
////        XCTAssertNil(errorDatabase, "databaseError update")
////    }
////
////    /// Fetches the Elements, delete all and see if newArray count is zero
////    func testDeleteAll() {
////        var errorDatabase: Error?
////        var array = [Teste]()
////        var newArray = [Teste]()
////
////        do {
////           try array = sut.readAll()
////        } catch {
////           errorDatabase = error
////           print(errorDatabase ?? "databaseError1 read")
////        }
////
////        let element = array[0]
////
////        do {
////           try sut.deleteAll(element)
////        } catch {
////           errorDatabase = error
////           print(errorDatabase ?? "databaseError1 delete")
////        }
////
////        do {
////           try newArray = sut.readAll()
////        } catch {
////           errorDatabase = error
////           print(errorDatabase ?? "databaseError2 read")
////        }
////
////        XCTAssertEqual(newArray.count, 0, "Database should have no records")
////        XCTAssertNil(errorDatabase, "databaseError update")
////    }
//}
