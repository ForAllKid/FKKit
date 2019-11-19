//
//  UIView+resuable+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UICollectionReusableView {
    
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
    
}


extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
    
}
