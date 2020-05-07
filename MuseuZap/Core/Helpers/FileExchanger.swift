//
//  FileExchanger.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 07/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

// TODO: create file exchanger errors

/// Helper Class to exchange files between ShareExtension and out AppGroup using FileManager
public class FileExchanger {

    // MARK: - Properties

    /// A shared Folder between the Share Extension and this current Application.
    /// Share Extension can grab the audio at an external application, but it does not have access to this current Application, only to groupFolder
    let appGroupFolderURL = FileManager.sharedContainerURL()

    // MARK: - Methods

    /// Method that copies an AudioFile from an external application into Application Group folder
    func copyAudioToGroupFolder(sourceURL: URL, destinationName: String) throws {

        let destinationURL = appGroupFolderURL.appendingPathComponent(destinationName,
                                                                      isDirectory: false)

        do {
            try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
        } catch {
            print("NAO COPIOU")
            throw error
        }
    }

    /// Method to list all Files in Application Group, a shared Folder between the Share Extension and this Application
    func listAllFilesInApplicationGroupFolder() -> [URL] {
        var list = [URL]()

        do {
            list = try FileManager.default.contentsOfDirectory(at: appGroupFolderURL,
                                                               includingPropertiesForKeys: nil)
        } catch {
            print("COULD NOT CREATE URL for FOLDER FOR SOME REASON \n", error)
        }

        return list
    }

    /// Method to list all Files in the givin Folder.
    /// Case empty, treat retuned value with .isEmpty
    func listAllFilesFrom(folder: URL) -> [URL] {
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

// MARK: - Methods to use to create items in Document Folder (find through iPhone Files App)

// Extension is useful to debug
extension FileExchanger {
    // MARK: - Set Info.plist

    // Application supports iTunes file sharing
    // Supports opening documents in place

    var appDocumentPublicFolder: URL {
        return FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask).first!
    }

    func addSimpleFileToDocumentPublicFolder() {
        let file = "Example.txt"
        let content = "Some text..."

        let fileURL = appDocumentPublicFolder.appendingPathComponent(file)

        do {
            try content.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print(error)
        }
    }

}
