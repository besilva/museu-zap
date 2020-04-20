//
//  Teste+CoreDataProperties.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 19/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//
//

import Foundation
import CoreData

extension Teste {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teste> {
        return NSFetchRequest<Teste>(entityName: "Teste")
    }

    @NSManaged public var titulo: String?
    @NSManaged public var subtitulo: String?

}
