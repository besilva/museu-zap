//
//  SnapshotContainer.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 06/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class SnapshotContainer<View: UIView>: UIView {
    let view: View
    
    init(_ view: View, width: CGFloat) {
        self.view = view
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
