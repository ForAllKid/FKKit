//
//  FileManager+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/19.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation


extension FileManager: KMKitCompatible {}


extension KMKitWrapper where KMKitWrapperType: FileManager {
    

    /// 获取某个路径下的文件大小
    /// - Parameter path: 文件路径
    func fileSize(at path: String) -> Int {
        
        let manager: FileManager = FileManager.default
        if manager.fileExists(atPath: path) {
            do {
                let dic :[FileAttributeKey : Any] = try manager.attributesOfItem(atPath: path)
                return dic[FileAttributeKey.size] as! Int
            } catch {}
        }
        return 0
    }

    /// 统计某个文件夹的大小，返回字节数
    /// - Parameter folderPath: 文件夹路径
    func folderSize(at folderPath: String) -> Int {
        
        guard FileManager.default.fileExists(atPath: folderPath) else {
            return 0
        }
        
        /// 获取当前文件夹下面所有的文件信息，貌似。。。没有去掉一些隐藏文件
        guard let fileNames = FileManager.default.subpaths(atPath: folderPath), fileNames.count > 0 else {
            return 0
        }
        
        
        /// 这个地方待测试。。。
        let totalSize = fileNames.reduce(0) { result, fileName -> Int in
            
            let fileAbsolutePath = folderPath + fileName

            let size = fileSize(at: fileAbsolutePath)
            
            return result + size
            
        }

        return totalSize
    }
    
}
