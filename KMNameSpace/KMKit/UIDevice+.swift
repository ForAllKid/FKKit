//
//  UIDevice+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit


extension UIDevice: KMKitCompatible {}


public extension KMKitWrapper where KMKitWrapperType == UIDevice {
    
    
    func blank<T>(of type: T.Type) -> T {
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
        let val = ptr.pointee
        ptr.deinitialize(count: Int.max)
        return val
    }
    
    
    /// 磁盘总大小
    var totalDiskSize: Int64 {
        var fs = blank(of: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_blocks)
        }
        return -1
    }
    
    /// 磁盘可用大小
    var availableDiskSize: Int64 {
        var fs = blank(of: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_bavail)
        }
        return -1
    }
    

    /// 将大小转换成字符串用以显示
    func fileSizeToString(fileSize: Int64) -> String {
        
        let fileSize1 = CGFloat(fileSize)
        
        let KB: CGFloat = 1024
        let MB: CGFloat = KB * KB
        let GB: CGFloat = MB * KB
        
        if fileSize < 10 {
            return "0 B"
        } else if fileSize1 < KB {
            return "< 1 KB"
        } else if fileSize1 < MB {
            return String(format: "%.1f KB", CGFloat(fileSize1) / KB)
        } else if fileSize1 < GB {
            return String(format: "%.1f MB", CGFloat(fileSize1) / MB)
        } else {
            return String(format: "%.1f GB", CGFloat(fileSize1) / GB)
        }
    }
    

}




//MARK: - Device Information

public extension KMKitWrapper where KMKitWrapperType: UIDevice {
    
    /// 系统版本
    static var systemVersion: Double {
        let version = Double(UIDevice.current.systemVersion) ?? 0.0
        return version
    }
    
    
    /// 判断是否是iPad
    var isPad: Bool {
        UI_USER_INTERFACE_IDIOM() == .pad
    }
        
    /// 判断是否是模拟器
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
        
    /// 判断是否可以拨打电话
    var canMakePhoneCalls: Bool {
        guard let url = URL(string: "tel://") else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }

}
