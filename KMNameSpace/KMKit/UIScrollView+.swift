//
//  UIScrollView+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit


public extension KMKitWrapper where KMKitWrapperType: UIScrollView {
    
    
    /// 滚动到底部
    /// - Parameter animated: 是否需要动画
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: kmWrappedValue.contentSize.height - kmWrappedValue.bounds.size.height)
        kmWrappedValue.setContentOffset(bottomOffset, animated: animated)
    }

    /// 滚动到顶部
    /// - Parameter animated: 是否需要动画
    func scrollToTop(animated: Bool = true) {
        kmWrappedValue.setContentOffset(CGPoint.zero, animated: animated)
    }
    
}


public extension KMKitWrapper where KMKitWrapperType: UIScrollView {
    
    /// 获取UIScrollView(包含子类)的截图，整个contentSize
    var contentSnapshot: UIImage? {
        // Original Source: https://gist.github.com/thestoics/1204051
        UIGraphicsBeginImageContextWithOptions(kmWrappedValue.contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = kmWrappedValue.frame
        kmWrappedValue.frame = CGRect(
            origin: kmWrappedValue.frame.origin,
            size: kmWrappedValue.contentSize
        )
        kmWrappedValue.layer.render(in: context)
        kmWrappedValue.frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}


