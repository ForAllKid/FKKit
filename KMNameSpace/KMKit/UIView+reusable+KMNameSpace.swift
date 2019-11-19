//
//  UIView+resuable+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UICollectionReusableView {
    
    /// UICollectionView的子视图的默认复用标识，默认为类名
    static var reuseIdentifier: String {
        String(describing: KMKitNameSpaceWrapperType.self)
    }
    
}


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UITableViewCell {
    
    /// UITableView的子视图的默认复用标识，默认为类名
    static var reuseIdentifier: String {
        String(describing: KMKitNameSpaceWrapperType.self)
    }
    
}


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UITableViewHeaderFooterView {
    
    /// UITableView的子视图的默认复用标识，默认为类名
    static var reuseIdentifier: String {
        String(describing: KMKitNameSpaceWrapperType.self)
    }
    
}
