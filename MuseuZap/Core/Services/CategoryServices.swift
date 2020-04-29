//
//  CategoryServices.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

/// Services Layer for Category Entity.
/// Independent from adopted database.
/// Error Handling + doing aditional treatment to data.
class CategoryServices {

    /// Used Data Access Object
    var categoryDAO: CategoryDAOProtocol

    // Dependency Injection in order to make a testable class
    required init(dao: CategoryDAOProtocol) {
        self.categoryDAO = dao
    }

    // MARK: - Create

    /// Function responsible for storing an Category
    /// - parameters:
    ///     - category: Category to be Saved
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.create)
    func createCategory(category: Category, _ completion: (_ error: Error?) -> Void) {
        do {
            // Save information
            try categoryDAO.create(category)
        } catch let error as DatabaseErrors {
            completion(error)
        } catch {
            completion(error)
            print("Unexpected error: \(error).")
        }
    }

    // MARK: - Read

    /// Function responsible for getting all categories
    /// - parameters:
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during getting an object from database  (DatabaseErrors.read)
    func getAllCategories(_ completion: @escaping (_ errorMessage: Error?,
                                                   _ entity: [Category]?) -> Void) {
        // Error to be returned in case of failure
        var raisedError: DatabaseErrors?
        var categories: [Category]?

        do {
            // Save information
            categories = try categoryDAO.readAll()
            completion(nil, categories)
        } catch let error as DatabaseErrors {
            // Error here shall be treated properly
            raisedError = error
            completion(raisedError, nil)
        } catch {
            completion(error, nil)
            print("Unexpected error: \(error).")
        }
    }

    // MARK: - Update

    /// Function responsible for updating all category records
    /// - parameters:
    ///     - category: Category to be updated
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.update)
    func updateAllCategories(_ completion: (_ error: Error?) -> Void) {
        do {
            // Save information
            try categoryDAO.updateContext()
            completion(nil)
        } catch let error as DatabaseErrors {
            completion(error)
        } catch {
            completion(error)
            print("Unexpected error: \(error).")
        }
    }

    // MARK: - Delete

    /// Function responsible for deleting an Category
    /// - parameters:
    ///     - category: category to be deleted
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.delete)
    func deleteCategory(category: Category, _ completion: (_ error: Error?) -> Void) {
        do {
            // Save information
            try categoryDAO.delete(category)
            completion(nil)
        } catch let error as DatabaseErrors {
            completion(error)
        } catch {
            completion(error)
            print("Unexpected error: \(error).")
        }
    }

}
