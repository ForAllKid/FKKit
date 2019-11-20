//
//  UIViewController+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension UIViewController: KMKitCompatible {
    
}

public extension KMKitWrapper where KMKitWrapperType: UIViewController {
    
    /// 添加通知
    /// - Parameter name: 通知名字
    /// - Parameter selector: 方法
    func addNotificationObserver(name: Notification.Name, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(kmWrappedValue, selector: selector, name: name, object: object)
    }

    
    /// 移除一个通知
    /// - Parameter name: 通知名字
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(kmWrappedValue, name: name, object: nil)
    }
    
    /// 移除所有通知
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(kmWrappedValue)
    }
    
}


