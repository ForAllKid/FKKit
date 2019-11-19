//
//  Data+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation



extension Data {
    
    enum ImageFormat {
        
        case Unknow
        case JPEG
        case PNG
        case GIF
        case TIFF
        case WebP
        case HEIC
        case HEIF
    }
    
}

extension Data: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Data {
    
    func getImageFormat() -> Data.ImageFormat  {
        var buffer = [UInt8](repeating: 0, count: 1)
        kmWrappedValue.copyBytes(to: &buffer, count: 1)
        
        switch buffer {
            case [0xFF]: return .JPEG
            case [0x89]: return .PNG
            case [0x47]: return .GIF
            case [0x49],[0x4D]: return .TIFF
            case [0x52] where kmWrappedValue.count >= 12:
                if let str = String(data: kmWrappedValue[0...11], encoding: .ascii), str.hasPrefix("RIFF"), str.hasSuffix("WEBP") {
                    return .WebP
            }
            case [0x00] where kmWrappedValue.count >= 12:
                if let str = String(data: kmWrappedValue[8...11], encoding: .ascii) {
                    let HEICBitMaps = Set(["heic", "heis", "heix", "hevc", "hevx"])
                    if HEICBitMaps.contains(str) {
                        return .HEIC
                    }
                    let HEIFBitMaps = Set(["mif1", "msf1"])
                    if HEIFBitMaps.contains(str) {
                        return .HEIF
                    }
            }
            default: break;
        }
        return .Unknow
    }
}



