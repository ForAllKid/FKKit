//
//  CALayer+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import QuartzCore
import UIKit

extension CALayer: KMKitNamespaceWrappable {}


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: CALayer {
    
    var snapshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(kmWrappedValue.bounds.size, kmWrappedValue.isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        kmWrappedValue.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    

    var transformDepth: CGFloat {
        kmWrappedValue.transform.m34
    }
    
    
    var contentMode: UIView.ContentMode {
        get {
            CALayer.CAGravityToUIViewContentMode(gravity: kmWrappedValue.contentsGravity)
        }
    }
}


private extension CALayer {
    
    static func CAGravityToUIViewContentMode(gravity: CALayerContentsGravity) -> UIView.ContentMode {

        let dict: [CALayerContentsGravity: UIView.ContentMode] = [
            .center:           .center,
            .top:              .top,
            .bottom:           .bottom,
            .left:             .left,
            .right:            .right,
            .topLeft:          .topLeft,
            .topRight:         .topRight,
            .bottomLeft:       .bottomLeft,
            .bottomRight:      .bottomRight,
            .resize:           .scaleToFill,
            .resizeAspect:     .scaleAspectFit,
            .resizeAspectFill: .scaleAspectFill
        ]
        return dict[gravity] ?? .scaleToFill

    }
    
}
