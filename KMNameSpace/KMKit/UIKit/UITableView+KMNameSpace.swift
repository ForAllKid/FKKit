//
//  UITableView+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UITableView {
    
    func registerCell<Cell: UITableViewCell>(_ cellType: Cell.Type, reuseIdentifier: String = Cell.KM.reuseIdentifier) {
        
        kmWrappedValue.register(cellType.self, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    func dequeueCell<Cell: UITableViewCell>(_ cellType: Cell.Type, reuseIdentifier: String = Cell.KM.reuseIdentifier, for indexPath: IndexPath) -> Cell {
        
        guard let c = kmWrappedValue.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("确定有没有注册")
        }
        return c
        
    }
    
}
