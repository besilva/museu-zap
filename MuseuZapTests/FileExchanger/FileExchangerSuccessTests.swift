//
//  FileExchangerSuccessTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import MuseuZap

class FileExchangerSuccessTests: XCTestCase {

    var sut: FileExchanger!
    var fileName: String!
    var fileURL: URL!

    override func setUp() {
        // This method is called before the invocation of each test method in the class.

        // For test purposes, appGroupFolder will be a folder inside the Temp Directory
        sut = FileExchanger()
        sut.appGroupFolderURL = FileManager.default.temporaryDirectory

        fileName = "FileExchangerTests.txt"
        fileURL = sut.appGroupFolderURL.appendingPathComponent(fileName)
        createFileAtTempDir()
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        deleteFilesAtTempDir()
        sut = nil
    }

    // Create a mock file at temp directory
    func createFileAtTempDir() {
        let content = "Some mock text..."

        do {
            try content.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print(error)
        }
    }

    func deleteFilesAtTempDir() {
        do {
            let list = try FileManager.listAllFilesFrom(folder: sut.appGroupFolderURL)

            if !list.isEmpty {
                for file in list {
                    do {
                        try FileManager.default.removeItem(at: file)
                    } catch {
                        print(error)
                    }
                }
            } else {
                print("LIST SHOULD NOT BE EMPTY")
            }
        } catch {
        }

    }

    // MARK: - List

    /// Test if folder has the file created in setUp()
    func testListAllFilesInApplicationGroupFolder() {
        var list = [URL]()
        XCTAssertNoThrow(try list = sut.listAllFilesInApplicationGroupFolder())

        XCTAssertEqual(list.count, 1, "There should be exactly 1 element")

        let file = list.first!

        XCTAssertEqual("FileExchangerTests.txt", file.lastPathComponent, "The name of the file should be FileExchangerTests.txt")
    }

    // MARK: - Copy

    // Copies the "FileExchangerTests.txt" to the same folder with another name. Checks count and name
    // If snapshot tests fail, this test will too
    func testCopyAudioToGroupFolder() {
        let newFile = "CopiedFile.txt"

        do {
            _ = try sut.copyAudioToGroupFolder(sourceURL: fileURL, destinationName: newFile)
        } catch { 
            XCTFail("No errors should be Produced when copying")
        }

        var newList = [URL]()
        XCTAssertNoThrow(try newList = sut.listAllFilesInApplicationGroupFolder())

        XCTAssertEqual(newList.count, 2, "There should be exactly 2 elements")

        let copiedFile = newList.last!

        XCTAssertEqual("CopiedFile.txt", copiedFile.lastPathComponent, "The name of the file should be CopiedFile.txt")
    }
}
