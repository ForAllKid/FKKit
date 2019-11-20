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
    
    /// 边框颜色
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
    
    
    /// 边框线条粗细
    var borderWidth: CGFloat {
        get {
            return kmWrappedValue.layer.borderWidth
        }
        set {
            kmWrappedValue.layer.borderWidth = newValue
        }
    }
    
    
    /// 圆角值
    var cornerRadius: CGFloat {
        get {
            return kmWrappedValue.layer.cornerRadius
        }
        set {
            kmWrappedValue.layer.masksToBounds = true
            kmWrappedValue.layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    
    /// 阴影颜色
    var shadowColor: UIColor? {
        get {
            guard let color = kmWrappedValue.layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            kmWrappedValue.layer.shadowColor = newValue?.cgColor
        }
    }
    
    
    /// 阴影偏移量
    var shadowOffset: CGSize {
        get { kmWrappedValue.layer.shadowOffset }
        set { kmWrappedValue.layer.shadowOffset = newValue }
    }
    
    
    /// 阴影不透明度
    var shadowOpacity: Float {
        get { kmWrappedValue.layer.shadowOpacity }
        set { kmWrappedValue.layer.shadowOpacity = newValue }
    }
    
    
    /// 阴影圆角值
    var shadowRadius: CGFloat {
        get { kmWrappedValue.layer.shadowRadius }
        set { kmWrappedValue.layer.shadowRadius = newValue }
    }
    
    
    /// 截图
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
    
    /// 添加一组子视图
    /// - Parameter subviews: 子视图
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { kmWrappedValue.addSubview($0) }
    }
    
}

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIView {
    
    /// 设置背景色
    /// - Parameter color: 颜色
    func backgroundColor(color: UIColor) {
        kmWrappedValue.backgroundColor = color
    }
    
    
    /// 设置背景色
    /// - Parameter name: 颜色值
    func backgroundColor(name: String) {
        let color = UIColor.KM.color(name: name)
        backgroundColor(color: color)
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




#if canImport(SnapKit)

import SnapKit

public extension KMKit {
    
    static let baseTag: Int = 19900527
    
    struct LineDirection: OptionSet {
        
        public typealias RawValue = Int

        public var rawValue: Int
        
        public init(rawValue : LineDirection.RawValue) {
            self.rawValue = rawValue
        }

    }
    
    struct Inset {
        var left: CGFloat = 0.0
        var right: CGFloat = 0.0
    }

}


extension KMKit.LineDirection {
    
    static let top = KMKit.LineDirection(rawValue: 1 << 0)
    static let bottom = KMKit.LineDirection(rawValue: 1 << 1)
    static let left = KMKit.LineDirection(rawValue: 1 << 2)
    static let right = KMKit.LineDirection(rawValue: 1 << 3)
    static let centerX = KMKit.LineDirection(rawValue: 1 << 4)
    static let centerY = KMKit.LineDirection(rawValue: 1 << 5)
    static let around: KMKit.LineDirection = [top, left, bottom, right]
    
}



extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIView {
    
    
    /// 在一个border添加线条
    /// - Parameter direction: 方向
    /// - Parameter color: 颜色
    /// - Parameter inset: 缩进
    /// - Parameter borderWidth: 线条宽度或者高度
    func addLine(direction: KMKit.LineDirection, color: UIColor, inset: KMKit.Inset = KMKit.Inset(), borderWidth: CGFloat = 0.5) {

        /// 添加上边
        if direction.contains(.top) {
            
            let line = dequeueLineView(direction: .top)
            line.backgroundColor = color
            
            line.snp.remakeConstraints { maker in
                maker.top.equalTo(kmWrappedValue)
                maker.left.equalTo(kmWrappedValue).offset(inset.left)
                maker.right.equalTo(kmWrappedValue).inset(inset.right)
                maker.height.equalTo(borderWidth)
            }

        }
        
        /// 添加左边
        if direction.contains(.left) {
            
            let line = dequeueLineView(direction: .left)
            line.backgroundColor = color
            
            line.snp.remakeConstraints { maker in
                maker.top.equalTo(kmWrappedValue).offset(inset.left)
                maker.left.equalTo(kmWrappedValue)
                maker.bottom.equalTo(kmWrappedValue).inset(inset.right)
                maker.width.equalTo(borderWidth)
            }

        }
        
        /// 添加下边
        if direction.contains(.bottom) {
            
            let line = dequeueLineView(direction: .bottom)
            line.backgroundColor = color
            
            line.snp.remakeConstraints { maker in
                maker.left.equalTo(kmWrappedValue).offset(inset.left)
                maker.bottom.equalTo(kmWrappedValue)
                maker.right.equalTo(kmWrappedValue).inset(inset.right)
                maker.height.equalTo(borderWidth)
            }

        }
        
        /// 添加右边
        if direction.contains(.right) {
            
            let line = dequeueLineView(direction: .right)
            line.backgroundColor = color

            line.snp.remakeConstraints { maker in
                maker.top.equalTo(kmWrappedValue).offset(inset.left)
                maker.bottom.equalTo(kmWrappedValue).inset(inset.right)
                maker.right.equalTo(kmWrappedValue)
                maker.width.equalTo(borderWidth)
            }

        }
        
        /// 添加垂直居中
        if direction.contains(.centerX) {
            
            let line = dequeueLineView(direction: .centerX)
            line.backgroundColor = color
            
            line.snp.remakeConstraints { maker in
                maker.top.equalTo(kmWrappedValue).offset(inset.left)
                maker.centerX.equalTo(kmWrappedValue)
                maker.bottom.equalTo(kmWrappedValue).inset(inset.right)
                maker.width.equalTo(borderWidth)
            }
            
        }
        
        /// 添加水平居中
        if direction.contains(.centerY) {

            let line = dequeueLineView(direction: .centerY)
            line.backgroundColor = color
            
            line.snp.remakeConstraints { maker in
                maker.left.equalTo(kmWrappedValue).offset(inset.left)
                maker.centerY.equalTo(kmWrappedValue)
                maker.right.equalTo(kmWrappedValue).inset(inset.right)
                maker.height.equalTo(borderWidth)
            }
        
        }
    }
    
    
    /// 移除某条线
    ///
    /// - Parameter direction: 方向
    func removeLineWithDirection(direction: KMKit.LineDirection) {
        
        if direction.contains(.top) {
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .top)){
                view.removeFromSuperview()
            }
        }
        
        if direction.contains(.left){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .left)){
                view.removeFromSuperview()
            }
        }
        
        if direction.contains(.bottom){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .bottom)){
                view.removeFromSuperview()
            }
        }
        
        if direction.contains(.right){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .right)){
                view.removeFromSuperview()
            }
        }
        
        if direction.contains(.centerX){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .centerX)){
                view.removeFromSuperview()
            }
        }
        
        if direction.contains(.centerY){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .centerY)){
                view.removeFromSuperview()
            }
        }
    }
    
    
    /// 隐藏某条线
    ///
    /// - Parameter direction: 方向
    func hideLineWithDirection(direction: KMKit.LineDirection) {
        setLineHideState(direction: direction, isHidden: true)
    }
    
    func showLineWithDirection(direction: KMKit.LineDirection){
        setLineHideState(direction: direction, isHidden: false)
    }
    
    func setLineColor(color: UIColor, direction: KMKit.LineDirection){
        if direction.contains(.top) {
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .top)) {
                view.backgroundColor = color
            }
        }
        
        if direction.contains(.left){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .left)) {
                view.backgroundColor = color
            }
        }
        
        if direction.contains(.bottom){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .bottom)) {
                view.backgroundColor = color
            }
        }
        
        if direction.contains(.right){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .right)){
                view.backgroundColor = color
            }
        }
        
        if direction.contains(.centerX){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .centerX)){
                view.backgroundColor = color
            }
        }
        
        if direction.contains(.centerY){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .centerY)){
                view.backgroundColor = color
            }
        }
    }
    

    /// 获取某条线
    /// - Parameter direction: 方向
    func getLineWithDirection(direction: KMKit.LineDirection) -> UIView? {
        if direction.contains(.top) {
            return kmWrappedValue.viewWithTag(getTagWithDirection(direction: .top))
        }
        
        if direction.contains(.left){
            return kmWrappedValue.viewWithTag(getTagWithDirection(direction: .left))
        }
        
        if direction.contains(.bottom){
            return kmWrappedValue.viewWithTag(getTagWithDirection(direction: .bottom))
        }
        
        if direction.contains(.right){
            return kmWrappedValue.viewWithTag(getTagWithDirection(direction: .right))
        }
        
        if direction.contains(.centerX){
            return kmWrappedValue.viewWithTag(getTagWithDirection(direction: .centerX))
        }
        
        if direction.contains(.centerY){
            return kmWrappedValue.viewWithTag(getTagWithDirection(direction: .centerY))
        }
        
        return nil
    }
    
    // MARK: Private
    
    /// 根据方向获取某个line, 如果没有会创建一个，并且添加在view上
    /// - Parameter direction: 方向
    private func dequeueLineView(direction: KMKit.LineDirection) -> UIView {
        
        let tag = getTagWithDirection(direction: .right)

        if let v = kmWrappedValue.viewWithTag(tag) {
            return v
        }
        
        let v = UIView()
        kmWrappedValue.addSubview(v)
        v.tag = tag
        return v
    }
    
    
    private func getTagWithDirection(direction: KMKit.LineDirection) -> Int {
        let tag = KMKit.baseTag + direction.rawValue
        return tag
    }
    
    private func setLineHideState(direction: KMKit.LineDirection, isHidden: Bool) {
        
        if direction.contains(.top) {
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .top)){
                view.isHidden = isHidden
            }
        }
        
        if direction.contains(.left){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .left)){
                view.isHidden = isHidden
            }
        }
        
        if direction.contains(.bottom){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .bottom)){
                view.isHidden = isHidden
            }
        }
        
        if direction.contains(.right){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .right)){
                view.isHidden = isHidden
            }
        }
        
        if direction.contains(.centerX){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .centerX)){
                view.isHidden = true
            }
        }
        
        if direction.contains(.centerY){
            if let view = kmWrappedValue.viewWithTag(getTagWithDirection(direction: .centerY)){
                view.isHidden = true
            }
        }
    }
    
}

#endif

