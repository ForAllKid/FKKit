//
//  CALayer+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import QuartzCore
import UIKit

extension CALayer: KMKitCompatible {}


public extension KMKitWrapper where KMKitWrapperType: CALayer {
    
    /// 获取截图
    var snapshot: UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(
            kmWrappedValue.bounds.size,
            kmWrappedValue.isOpaque,
            0
        )
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        kmWrappedValue.render(
            in: ctx
        )
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    

    var transformDepth: CGFloat {
        return kmWrappedValue.transform.m34
    }
    
    
    /// 映射UIView中对应的mode
    var contentMode: UIView.ContentMode {
        get {
            return CALayer.CAGravityToUIViewContentMode(gravity: kmWrappedValue.contentsGravity)
        }
    }
}


private extension CALayer {
    
    static func CAGravityToUIViewContentMode(gravity: CALayerContentsGravity) -> UIView.ContentMode {

        switch gravity {
            
            case .top:
                return .top
            case .left:
                return .left
            case .bottom:
                return .bottom
            case .right:
                return .right
            
            case .topLeft:
                return .topLeft
            case .topRight:
                return .topRight
            case .bottomLeft:
                return .bottomLeft
            case .bottomRight:
                return .bottomRight
            
            case .center:
                return .center
            
            case .resize:
                return .scaleToFill
            
            case .resizeAspect:
                return .scaleAspectFit
            
            case .resizeAspectFill:
                return .scaleAspectFill
            
            default:
                return .scaleToFill
        }

    }
    
}
