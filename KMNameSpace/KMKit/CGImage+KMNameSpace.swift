//
//  CGImage+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation


import CoreGraphics

#if canImport(CoreImage)
import CoreImage
#endif

#if canImport(UIKit)
import UIKit
#endif

extension CGImage: KMKitNamespaceWrappable { }
public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == CGImage {
    
    #if canImport(CoreImage)
    var ciImage: CIImage {
        return CIImage(cgImage: kmWrappedValue)
    }
    #endif
    
    #if canImport(UIKit)
    var uiImage: UIImage {
        return UIImage(cgImage: kmWrappedValue)
    }
    #endif
    
    var grayscale: CGImage? {
        guard let context = CGContext(
            data: nil,
            width: kmWrappedValue.width,
            height: kmWrappedValue.height,
            bitsPerComponent: 8,
            bytesPerRow: 4 * kmWrappedValue.width,
            space: CGColorSpaceCreateDeviceGray(),
            bitmapInfo: CGImageAlphaInfo.none.rawValue
            ) else {
                return nil
        }
        context.draw(kmWrappedValue, in: CGRect(origin: .zero, size: CGSize(width: kmWrappedValue.width, height: kmWrappedValue.height)))
        return context.makeImage()
    }
    
    func binarization(threshold: CGFloat = 0.5, foregroundColor: CGColor = CGColor.KM.white()!, backgroundColor: CGColor = CGColor.KM.black()!) -> CGImage? {
        let dataSize = kmWrappedValue.width * kmWrappedValue.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let backgroundPixel = backgroundColor.km.rgba,
            let foregroundPixel = foregroundColor.km.rgba,
            let context = CGContext(
                data: &pixelData,
                width: kmWrappedValue.width,
                height: kmWrappedValue.height,
                bitsPerComponent: 8,
                bytesPerRow: 4 * kmWrappedValue.width,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) else {
                return nil
        }
        
        context.draw(kmWrappedValue, in: CGRect(x: 0, y: 0, width: kmWrappedValue.width, height: kmWrappedValue.height))
        for x in 0 ..< kmWrappedValue.width {
            for y in 0 ..< kmWrappedValue.height {
                let offset = 4 * (x + y * kmWrappedValue.width)
                // RGBA
                let alpha: CGFloat = CGFloat(pixelData[offset + 3]) / 255.0
                let rgb: CGFloat = CGFloat(pixelData[offset + 0]) + CGFloat(pixelData[offset + 1]) + CGFloat(pixelData[offset + 2])
                let intensity = rgb / 3.0 / 255.0 * alpha + (1.0 - alpha)
                let finalPixel = intensity > threshold ? backgroundPixel : foregroundPixel
                pixelData[offset + 0] = finalPixel.red
                pixelData[offset + 1] = finalPixel.green
                pixelData[offset + 2] = finalPixel.blue
                pixelData[offset + 3] = finalPixel.alpha
            }
        }
        return context.makeImage()
    }
    
}
