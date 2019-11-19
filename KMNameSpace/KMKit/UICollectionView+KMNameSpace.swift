//
//  UICollectionView+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit


extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(_ cell: Cell.Type, reuseIdentifier: String = Cell.KM.reuseIdentifier) {
        kmWrappedValue.register(cell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(_ cell: Cell.Type, reuseIdentifier: String = Cell.KM.reuseIdentifier, indexPath: IndexPath) -> Cell {
        
        guard let c = kmWrappedValue.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("确定是否注册")
        }
        return c
    }
    

    
}

