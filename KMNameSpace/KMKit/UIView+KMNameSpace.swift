//
//  UIView+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension UIView: KMKitNamespaceWrappable {}


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIView {
 
    var borderColor: UIColor? {
        get {
            guard let color = kmWrappedValue.layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                kmWrappedValue.layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            kmWrappedValue.layer.borderColor = color.cgColor
        }
    }
    
    
    var borderWidth: CGFloat {
        get {
            return kmWrappedValue.layer.borderWidth
        }
        set {
            kmWrappedValue.layer.borderWidth = newValue
        }
    }
    
    
    var cornerRadius: CGFloat {
        get {
            return kmWrappedValue.layer.cornerRadius
        }
        set {
            kmWrappedValue.layer.masksToBounds = true
            kmWrappedValue.layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    

    var shadowColor: UIColor? {
        get {
            guard let color = kmWrappedValue.layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            kmWrappedValue.layer.shadowColor = newValue?.cgColor
        }
    }
    

    var shadowOffset: CGSize {
        get { kmWrappedValue.layer.shadowOffset }
        set { kmWrappedValue.layer.shadowOffset = newValue }
    }
    

    var shadowOpacity: Float {
        get { kmWrappedValue.layer.shadowOpacity }
        set { kmWrappedValue.layer.shadowOpacity = newValue }
    }
    
    var shadowRadius: CGFloat {
        get { kmWrappedValue.layer.shadowRadius }
        set { kmWrappedValue.layer.shadowRadius = newValue }
    }
    
    
    
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(kmWrappedValue.layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        kmWrappedValue.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIView {
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { kmWrappedValue.addSubview($0) }
    }
    
}


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIView {
    
    static func removeCornerRectOnView(view: UIView) {
        view.layer.mask = nil
    }
    
    static func addCornerRectTo(view: UIView, viewSize: CGSize, corners: UIRectCorner, cornerRadii: CGSize) {

        guard let _ = view.layer.mask else {
            return
        }
        
        let maskPath = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: viewSize.width,
                height: viewSize.height
            ),
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        )
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: viewSize.width,
            height: viewSize.height
        )
        
        maskLayer.path = maskPath.cgPath
        
        view.layer.mask = maskLayer
        
    }
    
    static func addCornerRectTo(view: UIView, corners: UIRectCorner, cornerRadii: CGSize) {
        addCornerRectTo(
            view: view,
            viewSize: view.frame.size,
            corners: corners,
            cornerRadii: cornerRadii
        )
    }
    
}



