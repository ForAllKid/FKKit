//
//  CGColor+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation

import CoreImage

extension CGColor: KMKitNamespaceWrappable {}

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == CGColor {
    
    var ciColor: CIColor {
        return CIColor(cgColor: kmWrappedValue)
    }
    
    var rgba: (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
        
        var color = kmWrappedValue
        if color.colorSpace?.model != .rgb, #available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *) {
            color = color.converted(
                to: CGColorSpaceCreateDeviceRGB(),
                intent: .defaultIntent,
                options: nil
            ) ?? color
        }
        if let components = color.components, 4 == color.numberOfComponents {
            return (
                red:   UInt8(components[0] * 255.0),
                green: UInt8(components[1] * 255.0),
                blue:  UInt8(components[2] * 255.0),
                alpha: UInt8(components[3] * 255.0)
            )
        } else {
            return nil
        }
    }
    
    static func initWith(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> CGColor? {
        return CGColor(
            colorSpace: CGColorSpaceCreateDeviceRGB(),
            components: [red, green, blue, alpha]
        )
    }
    
    static func white(white: CGFloat = 1.0, alpha: CGFloat = 1.0) -> CGColor? {
        return initWith(
            red: white,
            green: white,
            blue: white,
            alpha: alpha
        )
    }
    
    static func black(black: CGFloat = 1.0, alpha: CGFloat = 1.0) -> CGColor? {
        let white: CGFloat = 1.0 - black
        return initWith(
            red: white,
            green: white,
            blue: white,
            alpha: alpha
        )
    }
}
