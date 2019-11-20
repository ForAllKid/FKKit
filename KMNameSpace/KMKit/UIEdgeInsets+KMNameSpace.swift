//
//  UIEdgeInsets+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/20.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension UIEdgeInsets: KMKitNamespaceWrappable {

}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == UIEdgeInsets {
    
    var horizontal: CGFloat {
        return kmWrappedValue.left + kmWrappedValue.right
    }
    
    var vertical: CGFloat {
        return kmWrappedValue.top + kmWrappedValue.bottom
    }
    
}
