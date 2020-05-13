//
//  AsyncOperation.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 12/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest

struct AsyncOperation<Value> {
    let queue: DispatchQueue = .main
    let closure: () -> Value

    func perform(then handler: @escaping (Value) -> Void) {
        queue.async {
            let value = self.closure()
            handler(value)
        }
    }
}

struct AwaitError: LocalizedError {

    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
