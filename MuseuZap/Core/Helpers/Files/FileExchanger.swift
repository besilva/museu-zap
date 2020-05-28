//
//  FileExchanger.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 07/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

// TODO: FileExchanger deveria estar em MuseuZap? Só esta sendo utulziada pela shareExtension, mas a shareExtension no momento não tem tests

/// Helper Class to exchange files between ShareExtension and out AppGroup using FileManager
public class FileExchanger {

    // MARK: - Properties

    /// A shared Folder between the Share Extension and this current Application.
    /// Share Extension can grab the audio at an external application, but it does not have access to this current Application, only to groupFolder
    var appGroupFolderURL = FileManager.sharedContainerURL()

    // MARK: - Methods

    /// Method that copies an AudioFile from an external application into Application Group folder.
    /// - Parameters:
    ///   - sourceURL: External Audio File URL
    ///   - destinationName: Contains the new Audio name given by the user + extension
    /// - Throws: FileErrors.copy
    /// - Returns: The correct URL from the Audio File that the application can use ( Audio entity - audio.audioPath )
    func copyAudioToGroupFolder(sourceURL: URL, destinationName: String) throws -> URL? {

        let destinationURL = appGroupFolderURL.appendingPathComponent(destinationName,
                                                                      isDirectory: false)

        do {
            try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
        } catch {
            print("DID NOT COPIED", error)
            throw FileErrors.copy
        }

        return destinationURL
    }

    /// Method to list all Files in Application Group, a shared Folder between the Share Extension and this Application
    func listAllFilesInApplicationGroupFolder() throws -> [URL] {
        var list = [URL]()

        do {
            list = try FileManager.default.contentsOfDirectory(at: appGroupFolderURL,
                                                               includingPropertiesForKeys: nil)
            list = list.filter { (url) -> Bool in
                // ERRO: retorna true para path Data/Application/AE48D155-7E45-47D4-98F0-B0ECAE366213/tmp/CustomCellSnapshotTests
                var isDirectory: ObjCBool = false
                let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
                
                switch (exists, isDirectory.boolValue) {
                case (true, false): return true
                default: return false
                }
            }
        } catch {
            print("COULD NOT LIST ITEMS in GROUP FOLDER FOR SOME REASON \n", error)
            throw FileErrors.listContents
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
