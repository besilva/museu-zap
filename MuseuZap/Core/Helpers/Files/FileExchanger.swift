//
//  FileExchanger.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 07/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

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
                                                               includingPropertiesForKeys: [URLResourceKey.fileSizeKey])
        } catch {
            print("COULD NOT LIST ITEMS in GROUP FOLDER FOR SOME REASON \n", error)
            throw FileErrors.listContents
        }

        return list
    }

}
