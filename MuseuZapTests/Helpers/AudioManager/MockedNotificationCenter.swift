//
//  MockedNotificationCenter.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 14/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import XCTest
@testable import Blin

class MockedNotificationCenter: NotificationCenter {
    
    override func post(name: NSNotification.Name, object: Any?) {
        // Do nothing
    }
}
