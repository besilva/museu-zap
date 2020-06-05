//
//  UIImageView+Extension.swift
//  MuseuZap
//
//  Created by Ivo Dutra on 28/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

extension UIImage {
    struct Default {
        static let playIcon = UIImage(named: "play.fill")
        static let playIconHighlights = UIImage(named: "play-highlights")
        static let pauseIcon = UIImage(named: "pause.fill")
        static let pauseIconHighlights = UIImage(named: "pause-highlights")
    }

    struct Highlights {
        static let armando = UIImage(named: "Seu Armando")
        static let ivan = UIImage(named: "Ivan tentando vender queijos")
        static let galinha = UIImage(named: "Tres conchada de galinha")
    }
}

public extension UIImage {
    /// Using view.layer.cornerRadius turns only background (the layer) with cornerRadius. An image from imageView needs to be also drawn with this.
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
       let maxRadius = min(size.width, size.height) / 2
       let cornerRadius: CGFloat
       if let radius = radius, radius > 0 && radius <= maxRadius {
           cornerRadius = radius
       } else {
           cornerRadius = maxRadius
       }
       UIGraphicsBeginImageContextWithOptions(size, false, scale)
       let rect = CGRect(origin: .zero, size: size)
       UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
       draw(in: rect)
       let image = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return image
    }
}
