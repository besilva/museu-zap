/*
Copyright © 2020 MuseuZap. All rights reserved.

Abstract:
NSManagedObject for Teste Entity
Properties can be accessed through teste.titulo instead of "set value for.."
Codegen set to manual

*/

import Foundation
import CoreData
//
//protocol TesteProtocol {
//    @NSManaged public var titulo: String { get set }
//    @NSManaged public var subtitulo: String { get set }
//}

public class Teste: NSManagedObject {

    // TODO: INIT feito para testar. É assim?
//    init(titulo: String, subtitulo: String) {
//        super.init()
//        self.titulo = titulo
//        self.subtitulo = subtitulo
//    }
}

extension Teste {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teste> {
        return NSFetchRequest<Teste>(entityName: "Teste")
    }

    @NSManaged public var titulo: String?
    @NSManaged public var subtitulo: String?

}
