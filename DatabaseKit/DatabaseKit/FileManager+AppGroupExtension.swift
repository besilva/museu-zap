//
//  FileManager+AppGroupExtension.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 03/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

public extension FileManager {
    static func sharedContainerURL() -> URL {
    return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.museuGroup")!
    }

    // TODO: seria legal listallfiles tb dar throw, pq existem diferentes tipos de erro que ela pode dar
    // Mas por hora FileErrors pertence só no museu zap? Pq não consigo usar ele aqui?

    /// Method to list all Files in the givin Folder.
    /// Case empty, treat retuned value with .isEmpty
    static func listAllFilesFrom(folder: URL) -> [URL] {
        var list = [URL]()
        var isDir: Bool = false

        do {
            isDir = try folder.resourceValues(forKeys: [.isDirectoryKey]).isDirectory!
        } catch {
        }

        if isDir {
            do {
                list = try FileManager.default.contentsOfDirectory(at: folder,
                                                                   includingPropertiesForKeys: nil)
            } catch {
                print("COULD NOT CREATE URL for FOLDER FOR SOME REASON \n", error)
            }
        } else {
            print("URL IS NOT A FOLDER")
        }

        return list
    }
}
