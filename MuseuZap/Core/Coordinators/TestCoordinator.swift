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
    
    typealias T = UINavigationController
    var rootViewController: UINavigationController
    
    required init(rootViewController: UINavigationController = UINavigationController()) {
        self.rootViewController = rootViewController
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
            print("sharing!")
            let audioURL = URL(fileURLWithPath: audioPath)        
            do {
                let audioFile = try AVAudioFile(forReading: audioURL)
                let ac = UIActivityViewController(activityItems: [audioFile], applicationActivities: nil)
                self.rootViewController.present(ac, animated: true)
            } catch {
                print("Error loading audio file: \(audioURL.path)")
                print(error)
            }
        default:
            break
        }
    }
}
	
