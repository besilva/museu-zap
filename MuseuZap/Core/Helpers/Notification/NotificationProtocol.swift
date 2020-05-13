//
//  Notification.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 13/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

/// Turn NotificationCenter singleton possible to unit test
public protocol Notify {
    func postNotification(name: NSNotification.Name, object: Any?)
}
