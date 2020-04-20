/*
Copyright © 2020 MuseuZap. All rights reserved.

Abstract:
Services Layer. Independent from adopted database
Error Handling + doing aditional treatment to data

*/

import Foundation
import UIKit

/// CoreData Services base class
protocol Services {

    /// Entity Type
    associatedtype Entity

    /// Perfom a Fetch request to get all elements for a Entity Type
    /// - Returns: All objects for that Entity
//    func fetch(

//    static func getAllDiseases(_ completion: @escaping (_ errorMessage: Error?,
//    _ ocurrence: [DiseaseOccurrence]?) -> Void) {)

}
