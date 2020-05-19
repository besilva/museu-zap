//
//  XCTestCase+Extension.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 12/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest

extension XCTestCase {
    func await<T>(_ function: (@escaping (T) -> Void) -> Void) throws -> T {
        let expectation = self.expectation(description: "Async call")
        var result: T?

        function() { value in
            result = value
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)

        guard let unwrappedResult = result else {
            throw AwaitError(title: "Test Case error", description: "Async call error", code: 504)
        }

        return unwrappedResult
    }
}
