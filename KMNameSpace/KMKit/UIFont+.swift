//
//  UIFont+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension UIFont: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType: UIFont {
    
    /// 创建字体
    /// - Parameter size: 大小
    /// - Parameter isBlod: 是否使用粗体
    static func fontOfSize(_ size: CGFloat, isBlod: Bool = false) -> UIFont {
        if isBlod {
            return UIFont.boldSystemFont(ofSize: size)
        }
        return UIFont.systemFont(ofSize: size)
    }
    
}
