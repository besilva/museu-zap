//
//  TestCoordinator.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 08/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import AVFoundation

class TestCoordinator: BaseCoordinator {

    var rootViewController: UINavigationController
    var analyticsManager: AnalyticsManager
    
    init(rootViewController: UINavigationController = UINavigationController(),
         analyticsManager: AnalyticsManager = AnalyticsManager()) {
        self.rootViewController = rootViewController
        self.analyticsManager = analyticsManager
    }
    
    func startFlow() {
        let listController = ListViewController()
        listController.delegate = self
        self.rootViewController.pushViewController(listController, animated: true)
    }
    
    func handleNavigation(action: Action) {
        switch action {
        case .back:
            self.rootViewController.dismiss(animated: true)
        case .share(let audioPath):
            let audioURL = URL(fileURLWithPath: audioPath)

            if !audioURL.isFileURL {
                print(FileErrors.invalidURL)
            } else {
                do {
                    try AudioManager.shared.verifyIfURLIsAudioFile(url: audioURL)
                    let ac = UIActivityViewController(activityItems: [audioURL], applicationActivities: nil)
                    self.rootViewController.present(ac, animated: true)
                    analyticsManager.analytics.share(url: audioURL)
                } catch {
                    print("Error loading audioURL to share")
                    print(error)
                }
            }
        default:
            break
        }
    }
}
