//
//  Array+KMKit.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/15.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation


public extension Array {
    
    func sub(from fromIndex: Int, to toIndex: Int ) -> [Element] {
        guard fromIndex >= 0 && (fromIndex + count) <= self.count else {
            return []
        }
        var newArray: [Element] = []
        for i in fromIndex ..< (fromIndex + count){
            newArray.append(self[i])
        }
        return newArray
    }


    
    subscript(index: Int, safe: Bool ) -> Element? {
        if safe {
            if self.count > index {
                return self[index]
            }
            else {
                return nil
            }
        }
        else {
            return self[index]
        }
    }
    
}

