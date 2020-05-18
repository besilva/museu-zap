//
//  FileManager+Extension.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 14/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

public extension FileManager {

    /// Method to list all Files in the givin Folder.
    /// Case empty, treat retuned value with .isEmpty
    static func listAllFilesFrom(folder: URL) throws -> [URL] {
        var list = [URL]()
        var isDir: Bool = false

        do {
            isDir = try folder.resourceValues(forKeys: [.isDirectoryKey]).isDirectory!
        } catch {
            print("Unknown error files \n", error)
            throw FileErrors.unknown
        }

        if isDir {
            do {
                list = try FileManager.default.contentsOfDirectory(at: folder,
                                                                   includingPropertiesForKeys: nil)
            } catch {
                print("COULD NOT LIST ITEMS in GROUP FOLDER FOR SOME REASON \n", error)
                throw FileErrors.listContents
            }
        } else {
            print("NOT A FOLDER\n")
            throw FileErrors.notAFolder
        }

        return list
    }

    /// Method to verify if a file existis at givin URL
    static func verifyIfFileExists(url: URL) throws {

        if !FileManager.default.fileExists(atPath: url.path) {
            throw FileErrors.invalidURL
        }
    }
}
