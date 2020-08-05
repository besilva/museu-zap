//
//  Unzip.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 05/08/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import ZIPFoundation
import Foundation

/*
 chat adicionado em resource


 */

class Unzip {

    var fileExchanger: FileExchanger
    var zipResourceURL: URL?
    var zipGroupURL: URL?
    var unzipedFolderURL: URL?

    init() {
        fileExchanger = FileExchanger()

        guard let urls = Bundle.main.urls(forResourcesWithExtension: "zip", subdirectory: nil) else { return }
        print("\n\n\n\n\n\n", urls)

        zipResourceURL = urls[0]

        moveZipToGroupFolder()

        unzipAtGroupFolder()


        
    }

    // MARK: - unzip

    func unzipAtGroupFolder() {
        let fileManager = FileManager.default
        // Now url from appGroup
        guard let source = zipGroupURL else { return }
        let unzipedFolderName = source.deletingPathExtension().lastPathComponent + "-unziped"
        let destinationURL = fileExchanger.appGroupFolderURL.appendingPathComponent(unzipedFolderName)

        do {
            try fileManager.createDirectory(at: destinationURL,
                                            withIntermediateDirectories: true,
                                            attributes: nil)

            try fileManager.unzipItem(at: source, to: destinationURL)
        } catch {
            print("Extraction of ZIP archive failed with error:\(error)")
        }

        print(fileExchanger.listAllFilesIn(url: URL(fileURLWithPath: destinationURL.path)))
        // CÓDIGO É SÍNCRONO
        unzipedFolderURL = destinationURL

        print(unzipedFolderURL)
    }

    // MARK: - move to group

    func moveZipToGroupFolder() {

        guard let source = zipResourceURL else { return }
        let destinationName = source.lastPathComponent

        do {
            // Não é audio mas rola tb
            zipGroupURL = try fileExchanger.copyAudioToGroupFolder(sourceURL: source,
                                                     destinationName: destinationName)
        } catch {
            print("erroo")
        }

        do {
            print(try fileExchanger.listAllFilesInApplicationGroupFolder())
        } catch {
            print("nao listoooo")
        }
    }

}
