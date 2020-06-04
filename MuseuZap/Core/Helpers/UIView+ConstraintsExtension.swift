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
//
//extension NSLayoutAnchor {
//    @discardableResult @objc func equal(to constraint: NSLayoutAnchor, constant: CGFloat) -> NSLayoutConstraint {
//        let constraint = self.constraint(equalTo: constraint, constant: constant)
//        constraint.isActive = true
//        return constraint
//    }
//
//}
//
//extension NSLayoutDimension {
//    @discardableResult @objc func equalTo(constant: CGFloat) -> NSLayoutConstraint {
//        return self.constraint(equalToConstant: constant)
//    }
//}

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}

extension UIView: AutoLayoutView {}
