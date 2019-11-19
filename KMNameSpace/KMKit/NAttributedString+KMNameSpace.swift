//
//  NAttributedString+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation

extension NSAttributedString: KMKitNamespaceWrappable {}

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: NSAttributedString {
    
    
    var rangeOfAll: NSRange {
        .init(location: 0, length: kmWrappedValue.length)
    }

}
