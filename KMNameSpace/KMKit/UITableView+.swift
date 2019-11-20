//
//  UITableView+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

public extension KMKitWrapper where KMKitWrapperType: UITableView {
    
    /// 注册一类cell
    /// - Parameter cellType: cell的类型
    /// - Parameter reuseIdentifier: 复用标识
    func registerCell<Cell: UITableViewCell>(_ cellType: Cell.Type, reuseIdentifier: String = Cell.KM.reuseIdentifier) {
        
        kmWrappedValue.register(
            cellType.self,
            forCellReuseIdentifier: reuseIdentifier
        )
        
    }
    
    /// 根据复用标识和类名获取可重用的cell，如果没有注册过对应的cell，会直接报错
    /// - Parameter cellType: cell类型
    /// - Parameter reuseIdentifier: 重用标识
    /// - Parameter indexPath: indexPath
    func dequeueCell<Cell: UITableViewCell>(_ cellType: Cell.Type, reuseIdentifier: String = Cell.KM.reuseIdentifier, for indexPath: IndexPath) -> Cell {
        
        guard let c = kmWrappedValue.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath) as? Cell else {
            fatalError("确定有没有注册")
        }
        return c
        
    }
    
    
    /// 注册header或者footer
    /// - Parameter headerOrFooter: 类
    /// - Parameter reuseIdentifier: 重用标识
    func registerHeaderOrFooter<HeaderOrFooter: UITableViewHeaderFooterView>(_ headerOrFooter: HeaderOrFooter.Type, reuseIdentifier: String = HeaderOrFooter.KM.reuseIdentifier) {
        
        kmWrappedValue.register(
            headerOrFooter.self,
            forHeaderFooterViewReuseIdentifier: reuseIdentifier
        )
        
    }
    
    /// 获取服用的header或者footer
    /// - Parameter headerOrFooterType: 类
    /// - Parameter reuseIdentifier: 重用标识
    func dequeHeaderOrFooter<HeaderOrFooter: UITableViewHeaderFooterView>(_ headerOrFooterType: HeaderOrFooter.Type, reuseIdentifier: String = HeaderOrFooter.KM.reuseIdentifier) -> HeaderOrFooter {
        
        guard let v = kmWrappedValue.dequeueReusableHeaderFooterView(
            withIdentifier: reuseIdentifier) as? HeaderOrFooter else {
            fatalError("确定有没有注册")
        }
        
        return v
        
    }
    
}
