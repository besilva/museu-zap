//  FileExchangerSuccessTests.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import Blin

class FileExchangerErrorTests: XCTestCase {

    var sut: FileExchanger!
    var fileName: String!
    var sourceURL: URL!

    override func setUp() {
        super.setUp()
        // This method is called before the invocation of each test method in the class.

        // For test purposes, appGroupFolder will be the Temp Directory
        sut = FileExchanger()

        fileName = "NonExistingFolder"
        sut.appGroupFolderURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    // MARK: - List

    /// Test if error produced is the correct one. Mocked applicationGroupFolder does not exists
    func testListAllFilesInApplicationGroupFolderError() {
        XCTAssertThrowsError(try _ = sut.listAllFilesInApplicationGroupFolder()) { error in
            XCTAssertEqual(error as? FileErrors, FileErrors.listContents)
        }
    }

    // MARK: - Copy

    /// Test if error produced is the correct one. SourceURL should be an non-Existing-Folder to produce error
    func testCopyAudioToGroupFolderError() {
        // SourceURL should be an non-Existing-Folder.
        // Destination name is not important
        XCTAssertThrowsError(try sut.copyAudioToGroupFolder(sourceURL: sut.appGroupFolderURL,
                                                            destinationName: "Not Important")) { error in
                XCTAssertEqual(error as? FileErrors, FileErrors.copy)
        }
    }
}
