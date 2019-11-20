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

extension Int: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType == Int {
    
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


extension Int8: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType == Int8 {
    
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


extension Int16: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType == Int16 {
    
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


extension Int32: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType == Int32 {
    
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



extension Int64: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType == Int64 {
    
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



extension UInt: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType == UInt {
    
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


extension UInt8: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType == UInt8 {
    
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


extension UInt16: KMKitCompatible {}
public extension KMKitWrapper where KMKitWrapperType == UInt16 {
    
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


extension UInt32: KMKitCompatible {}
public extension KMKitWrapper where KMKitWrapperType == UInt32 {
    
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


extension UInt64: KMKitCompatible {}
public extension KMKitWrapper where KMKitWrapperType == UInt64 {
    
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


extension Float: KMKitCompatible { }
public extension KMKitWrapper where KMKitWrapperType == Float {
    
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


extension CGFloat: KMKitCompatible { }
public extension KMKitWrapper where KMKitWrapperType == CGFloat {
    
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

extension Double: KMKitCompatible { }
public extension KMKitWrapper where KMKitWrapperType == Double {
    
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

extension Bool: KMKitCompatible {}
public extension KMKitWrapper where KMKitWrapperType == Bool {
    
    
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
