//
//  Notification+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation


extension NotificationCenter: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: NotificationCenter {
    
    /// <#Description#>
    /// - Parameter name: <#name description#>
    /// - Parameter object: <#object description#>
    /// - Parameter userInfo: <#userInfo description#>
    /// - Parameter waitUntilDone: <#waitUntilDone description#>
    func postNotificationOnMainThreadWithName(_ name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil, waitUntilDone: Bool = false) {
        
        guard pthread_main_np() == 0 else {
            return
        }
        
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
        
        var info = [AnyHashable: Any]()
        
        info["name"] = name
        
        if let obj = object {
            info["object"] = obj
        }

        if let uInfo = userInfo {
            info["userInfo"] = uInfo
        }

        NotificationCenter.self.performSelector(
            onMainThread: #selector(NotificationCenter._km_postNotification(_:)),
            with: info,
            waitUntilDone: waitUntilDone
        )    
        
    }
    

}


private extension NotificationCenter {
    
    @objc static func _km_postNotification(_ notification: Notification) {
        NotificationCenter.default.post(notification)
    }
    
    @objc static func _km_postNotificationName(_ info: [AnyHashable: Any]) {
        
        guard let name = info["name"] as? Notification.Name else {
            return
        }
        
        let obj = info["object"]
        let userInfo = info["userInfo"] as? [AnyHashable: Any]
        NotificationCenter.default.post(
            name: name,
            object: obj,
            userInfo: userInfo
        )
    }
    
}
