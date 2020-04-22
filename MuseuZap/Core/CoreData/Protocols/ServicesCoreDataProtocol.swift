//
//  ServicesCoreDataProtocol.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import UIKit

/// CoreData Services Layer base class.
/// Independent from adopted database.
/// Error Handling + doing aditional treatment to data.
protocol ServicesCoreData {

    /// Entity Type
    associatedtype Entity

    /// Perfom a Fetch request to get all elements for a Entity Type
    /// - Returns: All objects for that Entity
//    func fetch(

//    static func getAllDiseases(_ completion: @escaping (_ errorMessage: Error?,
//    _ ocurrence: [DiseaseOccurrence]?) -> Void) {)
}
