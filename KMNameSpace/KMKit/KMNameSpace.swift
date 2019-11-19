//
//  KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/15.
//  Copyright © 2019 KM. All rights reserved.
//


import Foundation

public protocol KMKitNamespaceWrappable {
    associatedtype KMKitWrapperType
    var km: KMKitWrapperType { get }
    static var KM: KMKitWrapperType.Type { get }
}

public extension KMKitNamespaceWrappable {
    var km: KMKitNamespaceWrapper<Self> {
        return KMKitNamespaceWrapper(value: self)
    }
    
    static var KM: KMKitNamespaceWrapper<Self>.Type {
        return KMKitNamespaceWrapper.self
    }
}

public protocol KMKitTypeWrapperProtocol {
    associatedtype KMKitWrappedType
    var kmWrappedValue: KMKitWrappedType { get }
    init(value: KMKitWrappedType)
}

public struct KMKitNamespaceWrapper<KMKitNameSpaceWrapperType>: KMKitTypeWrapperProtocol {
    public let kmWrappedValue: KMKitNameSpaceWrapperType
    public init(value: KMKitNameSpaceWrapperType) {
        self.kmWrappedValue = value
    }
}

