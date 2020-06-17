//
//  UIView+ConstraintsExtension.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol AutoLayoutView {
    func setupConstraints(completion: (UIView) -> Void, activateAll activate: Bool)
}
extension AutoLayoutView where Self: UIView {
    
    func setupConstraints(completion: (UIView) -> Void, activateAll activate: Bool = false) {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        completion(self)
        if activate {
            self.constraints.forEach { (constraint) in
                constraint.isActive = true
            }
        }
    }
    
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}

extension UIView: AutoLayoutView {}
