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
    var DAO: CategoryDAOProtocol

    // Dependency Injection in order to make a testable class
    required init(dao: CategoryDAOProtocol) {
        self.DAO = dao
    }

    // MARK: - Create

    /// Function responsible for storing an Category
    /// - parameters:
    ///     - category: Category to be Saved
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.create)
    func createCategory(category: Category, _ completion: ((_ error: Error?) -> Void)?) {
        do {
            // Save information
            try DAO.create(category)
        } catch let error {
            if let closureError = completion {
                closureError(error)
            } else {
                print(error)
            }
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
            categories = try DAO.readAll()
            completion(nil, categories)
        } catch let error as DatabaseErrors {
            // Error here shall be treated properly
            raisedError = error
            completion(raisedError, nil)
        } catch {
            print("Unexpected error: \(error).")
        }
    }

    // MARK: - Update

    /// Function responsible for updating all category records
    /// - parameters:
    ///     - category: Category to be updated
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.update)
    func updateAllCategories(errorCompletion: ((_ error: Error?) -> Void)?) {
        do {
            // Save information
            try DAO.updateContext()
        } catch let error {
            if let closureError = errorCompletion {
                closureError(error)
            } else {
                print(error)
            }
        }
    }

    // MARK: - Delete

    /// Function responsible for deleting an Category
    /// - parameters:
    ///     - category: category to be deleted
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (DatabaseErrors.delete)
    func deleteCategory(category: Category, _ completion: ((_ error: Error?) -> Void)?) {
        do {
            // Save information
            try DAO.delete(category)
        } catch let error {
            if let closureError = completion {
                closureError(error)
            } else {
                print(error)
            }
        }
    }

}
