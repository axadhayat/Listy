//
//  GradientView.swift
//
//  Created by Asad Hayat on 09/03/2022.
//

import UIKit

class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.85).cgColor,
                                              UIColor.black.cgColor,
                                              UIColor.black.cgColor]
    }
}
