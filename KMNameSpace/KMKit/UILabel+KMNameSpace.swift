//
//  UILabel+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UILabel {
    
    
    /// 设置文字颜色
    /// - Parameter name: 颜色值，例如“#333333”， “0x333333”
    @discardableResult func textColor(name: String) -> KMKitNamespaceWrapper {
        kmWrappedValue.textColor = UIColor.KM.color(name: name)
        return KMKitNamespaceWrapper(value: kmWrappedValue)
    }
    
    /// 设置文字对齐方式
    /// - Parameter alignment: 对齐方式
    @discardableResult func textAlignment(_ alignment: NSTextAlignment) -> KMKitNamespaceWrapper {
        kmWrappedValue.textAlignment = alignment
        return KMKitNamespaceWrapper(value: kmWrappedValue)
    }
    
    /// 设置字体
    /// - Parameter font: 字体
    @discardableResult func font(_ font: UIFont) -> KMKitNamespaceWrapper {
        kmWrappedValue.font = font
        return KMKitNamespaceWrapper(value: kmWrappedValue)
    }

}

// MARK: - 快速创建

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UILabel {
    
    /// 创建一个label
    /// - Parameter fontSize: 文字大小
    /// - Parameter isBold: 是否加粗
    /// - Parameter textColor: 文字颜色
    /// - Parameter textAlignment: 文字对齐方式
    /// - Parameter fitSize: 是否自适应大小，默认大小为 字体大小 * 屏幕宽度
    static func create(fontSize: CGFloat, isBold: Bool = false, textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, fitSize: Bool = true) -> UILabel {
        let label = UILabel(
            frame: .init(
                origin: .zero,
                size: .init(width: UIScreen.main.bounds.width, height: fontSize)
            )
        )
        label.font = UIFont.KM.fontOfSize(fontSize, isBlod: isBold)
        label.textAlignment = textAlignment
        label.textColor = textColor
        if fitSize {
            label.sizeToFit()
        }
        return label
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
