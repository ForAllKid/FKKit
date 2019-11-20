//
//  UISwitch+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

public extension KMKitWrapper where KMKitWrapperType: UISwitch {
    
    func toggle(animated: Bool = true) {
        kmWrappedValue.setOn(!kmWrappedValue.isOn, animated: animated)
    }
    
}
