//
//  UICollectionView+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(_ cell: Cell.Type, reuseIdentifier: String = Cell.KM.reuseIdentifier) {
        kmWrappedValue.register(
            cell.self,
            forCellWithReuseIdentifier: reuseIdentifier
        )
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(_ cell: Cell.Type, reuseIdentifier: String = Cell.KM.reuseIdentifier, indexPath: IndexPath) -> Cell {
        
        guard let c = kmWrappedValue.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? Cell else {
            fatalError("确定是否注册")
        }
        return c
    }
    
    func registerSupplementaryView<SupplementaryView: UICollectionReusableView>(_ supplementaryView: SupplementaryView.Type, elementKind: String, reuseIdentifier: String = SupplementaryView.KM.reuseIdentifier) {
        
        kmWrappedValue.register(
            supplementaryView.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: reuseIdentifier
        )
        
    }
    
    func dequeueSupplementaryView<SupplementaryView: UICollectionReusableView>(_ supplementaryView: SupplementaryView.Type, elementKind: String, reuseIdentifier: String = SupplementaryView.KM.reuseIdentifier, for indexPath: IndexPath) -> SupplementaryView {
        
        guard let v = kmWrappedValue.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: reuseIdentifier, for: indexPath) as? SupplementaryView else {
            fatalError("确定是否注册")
        }
        
        return v
        
    }
    

}

