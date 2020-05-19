//
//  Stack.swift
//  MVVM-POC
//
//  Created by Bernardo Silva on 03/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

struct Stack<Element> {
    fileprivate var array: [Element] = []
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    mutating func push(_ elements: Element...) {
        for element in elements {
            self.push(element)
        }
    }
    
    mutating func pop() -> Element? {
        return array.popLast()
    }
    
    func peek() -> Element? {
        return array.last
    }
}
