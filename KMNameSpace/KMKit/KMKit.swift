//
//  KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/15.
//  Copyright © 2019 KM. All rights reserved.
//


import Foundation


public struct KMKit {
    
}



public protocol KMKitCompatible {
    associatedtype KMKitWrapperType
    var km: KMKitWrapperType { get }
    static var KM: KMKitWrapperType.Type { get }
}

public extension KMKitCompatible {
    var km: KMKitWrapper<Self> {
        return KMKitWrapper(value: self)
    }
    
    static var KM: KMKitWrapper<Self>.Type {
        return KMKitWrapper.self
    }
}

public protocol KMKitTypeWrapperProtocol {
    associatedtype KMKitWrappedType
    var kmWrappedValue: KMKitWrappedType { get }
    init(value: KMKitWrappedType)
}

public final class KMKitWrapper<KMKitWrapperType>: KMKitTypeWrapperProtocol {
    public let kmWrappedValue: KMKitWrapperType
    public init(value: KMKitWrapperType) {
        self.kmWrappedValue = value
    }
}

