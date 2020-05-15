//
//  AnalyticsManager.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 15/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import Firebase

class AnalyticsManager {

    static func share(url: URL) {
        let fileName = url.deletingPathExtension().lastPathComponent
        if let fileType = url.lastPathComponent.split(separator: ".").last {
            Analytics.logEvent(AnalyticsEventShare, parameters: [
                AnalyticsParameterContentType: fileType,
                AnalyticsParameterItemID: fileName
            ])
        }
    }
    
    static func category(name: String) {
        Analytics.logEvent(AnalyticsEventViewItemList, parameters: [
            AnalyticsParameterItemCategory: name
        ])
    }
    
    static func customEvent(name: String, parameters: [String: Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
}
