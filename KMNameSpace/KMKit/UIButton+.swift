//
//  UIButton+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

/*
 方法里面的参数使用了可选类型，原因是因为有些情况下会删除一些图片或者文字颜色
 */

public extension KMKitWrapper where KMKitWrapperType: UIButton {
    
    func titleColor(name: String?, state: UIControl.State) {
        
        var color: UIColor?
        if let colorName = name {
            color = UIColor.KM.color(name: colorName)
        }
        
        kmWrappedValue.setTitleColor(color, for: state)
        
    }
    
    func image(name: String?, for state: UIControl.State) {
        
        var image: UIImage?
        
        if let imageName = name {
            image = UIImage(named: imageName)
        }
        
        kmWrappedValue.setImage(image, for: state)
    }
    
    func backgroundImage(name: String?, state: UIControl.State) {
        var image: UIImage?
        
        if let imageName = name {
            image = UIImage(named: imageName)
        }
        
        kmWrappedValue.setBackgroundImage(image, for: state)
    }
    
}
