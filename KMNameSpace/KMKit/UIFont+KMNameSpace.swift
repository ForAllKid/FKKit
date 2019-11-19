//
//  UIFont+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension UIFont: KMKitNamespaceWrappable {}


extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIFont {
    
    /// 包一层 便于后期更换
    static func fontOfSize(_ size: CGFloat, isBlod: Bool = false) -> UIFont {
        if isBlod {
            return UIFont.boldSystemFont(ofSize: size)
        }
        return UIFont.systemFont(ofSize: size)
    }
    
}
