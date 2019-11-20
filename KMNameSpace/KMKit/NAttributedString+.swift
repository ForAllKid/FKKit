//
//  NAttributedString+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit
import CoreText

extension NSAttributedString: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType: NSAttributedString {
    
    var rangeOfAll: NSRange {
        .init(location: 0, length: kmWrappedValue.length)
    }

}

public extension KMKitWrapper where KMKitWrapperType == NSMutableAttributedString {
    

    func setFont(_ font: UIFont?, range: NSRange) {
        kmSetAttribute(.font, value: font, range: range)
    }
    
    
    func setKern(_ kern: CGFloat?, range: NSRange) {
        kmSetAttribute(.kern, value: kern, range: range)
    }
    
    func setForegroundColor(_ color: UIColor?, range: NSRange) {
        kmSetAttribute(.foregroundColor, value: color, range: range)
    }
    
    func setBackgroundColor(_ color: UIColor?, range: NSRange) {
        kmSetAttribute(.backgroundColor, value: color, range: range)
    }
    
    
    func setStrokeWidth(_ width: CGFloat?, range: NSRange) {
        kmSetAttribute(.strokeWidth, value: width, range: range)
    }
    
    func setStrokeColor(_ color: UIColor?, range: NSRange) {
        kmSetAttribute(.strokeColor, value: color, range: range)
    }

    func setParagraphStyle(_ style: NSParagraphStyle, range: NSRange) {
        kmSetAttribute(.paragraphStyle, value: style, range: range)
    }
    
    private func kmSetAttribute(_ name: NSAttributedString.Key, value: Any?, range: NSRange) {
        if let v = value {
            kmWrappedValue.addAttribute(name, value: v, range: range)
        } else {
            kmWrappedValue.removeAttribute(name, range: range)
        }
    }
}
