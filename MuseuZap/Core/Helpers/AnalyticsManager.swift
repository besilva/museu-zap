//
//  AnalyticsManager.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 15/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import Firebase

protocol AnalyticsProtocol {
    func share(url: URL)
    func category(name: String)
    func customEvent(name: String, parameters: [String: Any]?)
    func setScreenName(name: String?, screenClass: String?)
}

class AnalyticsManager {
    var analytics: AnalyticsProtocol
    
    init(analytics: AnalyticsProtocol = FirebaseAnalytics.shared) {
        self.analytics = analytics
    }
}

class FirebaseAnalytics: AnalyticsProtocol {

    static let shared = FirebaseAnalytics()
    
    private init() {}
    
    func share(url: URL) {
        let fileName = url.deletingPathExtension().lastPathComponent
        if let fileType = url.lastPathComponent.split(separator: ".").last {
            Analytics.logEvent(AnalyticsEventShare, parameters: [
                AnalyticsParameterContentType: fileType,
                AnalyticsParameterItemID: fileName
            ])
        }
    }
    
    func category(name: String) {
        Analytics.logEvent(AnalyticsEventViewItemList, parameters: [
            AnalyticsParameterItemCategory: name
        ])
    }
    
    func customEvent(name: String, parameters: [String: Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
    func setScreenName(name: String?, screenClass: String?) {
        Analytics.setScreenName(name, screenClass: screenClass)
    }
}
