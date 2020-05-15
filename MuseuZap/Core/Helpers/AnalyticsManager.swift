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
    static func share(fileType: String, fileName: String) {
        Analytics.logEvent(AnalyticsEventShare, parameters: [
        AnalyticsParameterContentType: fileType,
        AnalyticsParameterItemID: fileName
        ])
    }
}
