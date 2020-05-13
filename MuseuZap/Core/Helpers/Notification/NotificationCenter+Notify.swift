//
//  NotificationCenter+Notify.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 13/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

extension NotificationCenter: Notify {

    public func postNotification(name: NSNotification.Name, object: Any?) {
        post(name: name, object: object)
    }
}
