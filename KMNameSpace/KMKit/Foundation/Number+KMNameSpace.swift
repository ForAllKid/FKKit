//
//  Number+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/15.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation
import CoreGraphics

#if os(iOS)
import UIKit
#endif


// MARK: - Int  Int8  Int16  Int32  Int64   UInt  UInt8  UInt16  UInt32  UInt64

extension Int: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Int {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
    
}


extension Int8: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Int8 {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
    
}


extension Int16: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Int16 {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
    
}


extension Int32: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Int32 {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
    
}



extension Int64: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Int64 {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
    
}



extension UInt: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == UInt {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }

    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
    
}


extension UInt8: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == UInt8 {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
    
}


extension UInt16: KMKitNamespaceWrappable {}
extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == UInt16 {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
    
}


extension UInt32: KMKitNamespaceWrappable {}
extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == UInt32 {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
    
}


extension UInt64: KMKitNamespaceWrappable {}
extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == UInt64 {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
}


// MARK: - Float


extension Float: KMKitNamespaceWrappable { }
public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Float {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
}





// MARK: - CGFloat


extension CGFloat: KMKitNamespaceWrappable { }
public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == CGFloat {
    
    #if os(iOS)
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    static let screenMinEdge: CGFloat = Swift.min(screenWidth, screenHeight)
    #endif
    
    static let navigationBarHeight: CGFloat = 44
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var double: Double {
        Double(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
}


// MARK: - Double

extension Double: KMKitNamespaceWrappable { }
public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Double {
    
    // Convert
    var bool: Bool {
        0 != kmWrappedValue
    }
    
    var cgFloat: CGFloat {
        CGFloat(kmWrappedValue)
    }
    
    var float: Float {
        Float(kmWrappedValue)
    }
    
    var int: Int {
        Int(kmWrappedValue)
    }
    
    var int8: Int8 {
        Int8(kmWrappedValue)
    }
    
    var int16: Int16 {
        Int16(kmWrappedValue)
    }
    
    var int32: Int32 {
        Int32(kmWrappedValue)
    }
    
    var int64: Int64 {
        Int64(kmWrappedValue)
    }
    
    var uInt: UInt {
        UInt(kmWrappedValue)
    }
    
    var uInt8: UInt8 {
        UInt8(kmWrappedValue)
    }
    
    var uInt16: UInt16 {
        UInt16(kmWrappedValue)
    }
    
    var uInt32: UInt32 {
        UInt32(kmWrappedValue)
    }
    
    var uInt64: UInt64 {
        UInt64(kmWrappedValue)
    }
}


// MARK: - Bool

extension Bool: KMKitNamespaceWrappable {}
extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Bool {
    
    
    /// false.int -> 0
    /// true.int -> 1
    var int: Int {
        kmWrappedValue ? 1 : 0
    }

    /// false.string -> "false"
    /// true.string -> "true"
    var string: String {
        kmWrappedValue ? "true" : "false"
    }

}
