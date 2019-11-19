//
//  UIViewController+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIViewController {
    
    /// 添加通知
    /// - Parameter name: 通知名字
    /// - Parameter selector: 方法
    func addNotificationObserver(name: Notification.Name, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: object)
    }

    
    /// 移除一个通知
    /// - Parameter name: 通知名字
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    /// 移除所有通知
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
}


