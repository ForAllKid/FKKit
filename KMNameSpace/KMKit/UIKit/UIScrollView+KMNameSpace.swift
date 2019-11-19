//
//  UIScrollView+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit


extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIScrollView {
    
    
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: kmWrappedValue.contentSize.height - kmWrappedValue.bounds.size.height)
        kmWrappedValue.setContentOffset(bottomOffset, animated: animated)
    }

    func scrollToTop(animated: Bool = true) {
        kmWrappedValue.setContentOffset(CGPoint.zero, animated: animated)
    }
    
}


