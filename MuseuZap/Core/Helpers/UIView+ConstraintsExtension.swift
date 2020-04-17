//
//  UIView+ConstraintsExtension.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

protocol AutoLayoutView {
    func setupConstraints(completion: (UIView) -> Void)
}
extension AutoLayoutView where Self:UIView {
    func setupConstraints(completion: (UIView) -> Void) {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        completion(self)
    }
}
extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views{
            self.addSubview(view)
        }
    }
}

extension UIView: AutoLayoutView {}

