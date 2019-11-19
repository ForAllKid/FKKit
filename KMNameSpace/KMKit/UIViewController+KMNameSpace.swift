//
//  UIViewController+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIViewController {
    
    
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIViewController {


}


