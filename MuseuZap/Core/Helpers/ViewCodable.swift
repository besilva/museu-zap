//
//  ViewCodable.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol ViewCodable {
    /// Use to setup delegates and things like delegates
    func configure()
    /// Use to add any UI components inside the view
    func setupHierarchy()
    /// Setup constraints to the view and the subviews
    func setupConstraints()
    /// Customize the UIComponents(fonts, colors)
    func render()
    /// Setup any acessibility to the view
    func setupAcessibilityIdentifiers()
    /// This method builds the view using all the other methods fom the protocol
    func setupView()
}

extension ViewCodable {
    func setupAcessibilityIdentifiers() {}
    
    func setupView() {
        configure()
        setupHierarchy()
        setupConstraints()
        render()
        setupAcessibilityIdentifiers()
    }
    
    func configure() {}
}
