//
//  UiViewControllerExtension.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import Firebase

protocol ViewController: UIViewController, NavigationDelegate {

    var delegate: NavigationDelegate? {get set}
    var screenName: String { get }
    dynamic func setScreenName(analytics: AnalyticsProtocol) -> Bool

}

extension ViewController {

    @discardableResult
    func setScreenName(analytics: AnalyticsProtocol = FirebaseAnalytics.shared) -> Bool {
        analytics.setScreenName(name: self.screenName, screenClass: NSStringFromClass(Self.self))
        return true
    }

    /// Height of status bar + navigation bar (if navigation bar exist)
    var navBarHeight: CGFloat {
        let navigationHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
        return UIApplication.shared.statusBarFrame.size.height + navigationHeight
        
    }
}
