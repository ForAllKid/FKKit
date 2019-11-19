//
//  UILabel+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UILabel {
    
    @discardableResult
    func textColor(name: String) -> KMKitNamespaceWrapper {
        kmWrappedValue.textColor = UIColor.KM.color(name: name)
        return KMKitNamespaceWrapper(value: kmWrappedValue)
    }
    
    @discardableResult
    func textAlignment(_ alignment: NSTextAlignment) -> KMKitNamespaceWrapper {
        kmWrappedValue.textAlignment = alignment
        return KMKitNamespaceWrapper(value: kmWrappedValue)
    }
    
    @discardableResult
    func font(_ font: UIFont) -> KMKitNamespaceWrapper {
        kmWrappedValue.font = font
        return KMKitNamespaceWrapper(value: kmWrappedValue)
    }

}

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UILabel {
    
    static func initWith(fontSize: CGFloat, isBold: Bool, textColor: UIColor?, textAlignment:  NSTextAlignment?) -> UILabel {
        
        let label = UILabel()
        label.font = UIFont.KM.fontOfSize(fontSize, isBlod: isBold)

        if let alignment = textAlignment {
            label.textAlignment = alignment
        }
        
        if let tColor = textColor {
            label.textColor = tColor
        }
        
        return label
    }
    
    static func initWith(fontSize: CGFloat, isBold: Bool, colorStr: String?, textAlignment: NSTextAlignment?) -> UILabel {
        
        var color: UIColor?
        
        if let colorName = colorStr {
            color = UIColor.KM.color(name: colorName)
        }
                
        return self.initWith(
            fontSize: fontSize,
            isBold: isBold,
            textColor: color,
            textAlignment: textAlignment
        )
    }
    
    
    
    
    //label 内容行数  这的size 是label 的宽和高  lineSpace 是行间距
    func textNumLinesWithWidth(_ width: CGFloat ,text: String) -> CGFloat {
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = kmWrappedValue.lineBreakMode
        
        paragraphStyle.alignment = kmWrappedValue.textAlignment
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font : kmWrappedValue.font ?? UIFont.KM.fontOfSize(14),
            .paragraphStyle : paragraphStyle
        ]
        
        let contentSize = text.boundingRect(
            with: CGSize(
                width: width,
                height: 1000
            ),
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: attributes,
            context: nil
        ).size
        
        let labelNumber = contentSize.height / kmWrappedValue.font.lineHeight
        
        return labelNumber
    }
    
    static func textNumLinesWithWidth(_ width: CGFloat, font: UIFont, text:String) -> UInt {
        
        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.alignment = .left
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font : font,
            .paragraphStyle : paragraphStyle
        ]
        
        let contentSize = text.boundingRect(
            with: CGSize(
                width: width,
                height: 1000
            ),
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: attributes,
            context: nil
        ).size
        
        let labelNumber = UInt(contentSize.height / font.lineHeight)
        
        return labelNumber
    }
    
}
