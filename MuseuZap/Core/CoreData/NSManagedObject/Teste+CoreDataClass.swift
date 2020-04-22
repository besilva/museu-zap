//
//  Teste+Teste+CoreDataClass.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 22/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import CoreData

/// NSManagedObject for Teste Entity.
/// Properties can be accessed through teste.titulo instead of "set value for..".
/// Codegen set to manual
public class Teste: NSManagedObject {

}

extension Teste {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teste> {
        return NSFetchRequest<Teste>(entityName: "Teste")
    }

    @NSManaged public var titulo: String?
    @NSManaged public var subtitulo: String?

}
