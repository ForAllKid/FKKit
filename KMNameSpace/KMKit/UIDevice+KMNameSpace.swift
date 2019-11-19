//
//  UIDevice+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension UIDevice: KMKitNamespaceWrappable {}


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == UIDevice {
    
    /// 获取已下载漫画章节占用的硬盘空间大小（Bytes）
    /// - Parameter path: 路径，如果文件不存在或者路径不合法，返回0
    func getChapterDownloadFileSize(path: String) -> Int64 {
        
        if !path.isEmpty {
            return self.folderSizeAtPath(folderPath: path)
        }
        return CLongLong(0.0)
    }
    
    //单个文件的大小
    func fileSizeAtPath(filePath: String) -> CLongLong {
        
        let manager: FileManager = FileManager.default
        if manager.fileExists(atPath: filePath){
            do {
                let dic :[FileAttributeKey : Any] = try manager.attributesOfItem(atPath: filePath)
                return dic[FileAttributeKey.size] as! CLongLong
            } catch {}
        }
        return 0
    }
    
    //遍历文件夹获得文件夹大小，返回多少M
    func folderSizeAtPath(folderPath: String) -> CLongLong {
        let manager: FileManager = FileManager.default
        if !manager.fileExists(atPath: folderPath) {
            return 0
        }
        let paths: NSArray = manager.subpaths(atPath: folderPath)! as NSArray
        let childFilesEnumerator: NSEnumerator = paths.objectEnumerator()
        var fileName: String? = childFilesEnumerator.nextObject() as? String
        var folderSize: CLongLong = 0;
        if fileName != nil {
            while fileName!.count > 0 {

                let fileAbsolutePath: String = folderPath //.appendingPathComponent(fileName!)
                folderSize += self.fileSizeAtPath(filePath: fileAbsolutePath);
                fileName = (childFilesEnumerator.nextObject() as? String)
                if fileName == nil {
                    break
                }
            }
        }
        return folderSize/Int64((1024.0*1024.0));
    }
    
    
    func blank<T>(of type: T.Type) -> T {
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
        let val = ptr.pointee
        ptr.deinitialize(count: Int.max)
        return val
    }
    
    
    /// 磁盘总大小
    var TotalDiskSize:Int64{
        var fs = blank(of: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_blocks)
        }
        return -1
    }
    
    /// 磁盘可用大小
    var AvailableDiskSize:Int64{
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
    
    //    用法
    //    print(UIDevice.current.fileSizeToString(fileSize: UIDevice.current.AvailableDiskSize))
    //    print(UIDevice.current.fileSizeToString(fileSize: UIDevice.current.TotalDiskSize))
    //
    //    print(UIDevice.current.AvailableDiskSize)
    //    print(UIDevice.current.TotalDiskSize)
}




public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIDevice {

    
    
    //MARK: - Device Information

    
    static var systemVersion: Double {
        let version = Double(UIDevice.current.systemVersion) ?? 0.0
        return version
    }
    

    var isPad: Bool {
        UI_USER_INTERFACE_IDIOM() == .pad
    }
    
    /// Whether the device is a simulator.
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    

    var isJailbroken: Bool {
        false
    }
    
    /// Wherher the device can make phone calls.
    var canMakePhoneCalls: Bool {
        guard let url = URL(string: "tel://") else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }

}
