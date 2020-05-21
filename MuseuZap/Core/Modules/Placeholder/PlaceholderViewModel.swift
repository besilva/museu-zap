//
//  PlaceholderViewModel.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol PlaceholderViewModelDelegate: class {
    func hide()
    func unhide()
}

protocol PlaceholderViewModelProtocol {
    var title: String { get set }
    var subtitle: String { get set }
    var actionMessage: String { get set }
    var actionURL: URL { get set }
    var iconAssetName: String { get set }
    var delegate: PlaceholderViewModelDelegate? { get set }
    func performAction() -> Void
}

class PlaceholderViewModel: PlaceholderViewModelProtocol {
    var title: String
    
    var subtitle: String
    
    var actionMessage: String
    
    var actionURL: URL

    var iconAssetName: String = "Folder.fill.badge.plus"
    
    var delegate: PlaceholderViewModelDelegate?

    init(title: String, subtitle: String, actionMessage: String, actionURL: URL, iconAssetName: String?) {
        self.title = title
        self.subtitle = subtitle
        if let assetName = iconAssetName {
            self.iconAssetName = assetName
        }
        self.actionMessage = actionMessage
        self.actionURL = actionURL
    }
    
    func performAction() {
        UIApplication.shared.open(self.actionURL)
    }
}
