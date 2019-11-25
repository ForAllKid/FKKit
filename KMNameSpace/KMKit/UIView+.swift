//
//  UIView+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension UIView: KMKitCompatible {}


public extension KMKitWrapper where KMKitWrapperType: UIView {
    
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
    
    func snapshotImageAfterScreenUpdates(_ afterUpdates: Bool) -> UIImage? {
        
        guard kmWrappedValue.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) else {
            return self.screenshot
        }
        
        UIGraphicsBeginImageContextWithOptions(kmWrappedValue.bounds.size, kmWrappedValue.isOpaque, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        kmWrappedValue.drawHierarchy(in: kmWrappedValue.bounds, afterScreenUpdates: afterUpdates)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        return snap

    }
    
}


public extension KMKitWrapper where KMKitWrapperType: UIView {
    
    /// 添加一组子视图
    /// - Parameter subviews: 子视图
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { kmWrappedValue.addSubview($0) }
    }
    
}

public extension KMKitWrapper where KMKitWrapperType: UIView {
    
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



public extension KMKitWrapper where KMKitWrapperType: UIView {
    
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
    
    func getFirstScrollView() -> UIScrollView? {
        if kmWrappedValue.isKind(of: UIScrollView.self) {
            return kmWrappedValue as? UIScrollView
        }
        for view in kmWrappedValue.subviews {
            if let thisView = view.km.getFirstScrollView() {
                return thisView
            }
        }
        return nil
    }
}



// MARK: - 快速设置坐标属性

public extension KMKitWrapper where KMKitWrapperType: UIView {
    
    
    var top: CGFloat {
        set {
            kmWrappedValue.frame.origin.y = newValue
        }
        get {
            return kmWrappedValue.frame.minY
        }
    }
    
    
    var left: CGFloat {
        set {
            kmWrappedValue.frame.origin.x = newValue
        }
        get {
            return kmWrappedValue.frame.minX
        }
    }


    
    var bottom: CGFloat {
        set {
            kmWrappedValue.frame.origin.y = newValue - kmWrappedValue.frame.size.height
        }
        get {
            return kmWrappedValue.frame.maxY
        }
    }
    
    var right: CGFloat {
        set {
            kmWrappedValue.frame.origin.x = newValue - kmWrappedValue.frame.size.width
        }
        get {
            return kmWrappedValue.frame.maxX
        }
    }

    var width: CGFloat {
        set {
            kmWrappedValue.frame.size.width = newValue
        }
        get {
            return kmWrappedValue.frame.width
        }
    }
    
    var height: CGFloat {
        set {
            kmWrappedValue.frame.size.height = newValue
        }
        get {
            return kmWrappedValue.frame.height
        }
    }
    
    var centerX: CGFloat {
        set {
            kmWrappedValue.center.x = newValue
        }
        get {
            return kmWrappedValue.center.x
        }
    }
    
    var centerY: CGFloat {
        set {
            kmWrappedValue.center.y = newValue
        }
        get {
            return kmWrappedValue.center.y
        }
    }


    var origin: CGPoint {
        set {
            kmWrappedValue.frame.origin = newValue
        }
        get {
            return kmWrappedValue.frame.origin
        }
    }

    var size: CGSize {
        set {
            kmWrappedValue.frame.size = newValue
        }
        get {
            return kmWrappedValue.frame.size
        }
    }
    
}




// MARK: - 复用标识

public extension KMKitWrapper where KMKitWrapperType: UICollectionReusableView {
    
    /// UICollectionView的子视图的默认复用标识，默认为类名
    static var reuseIdentifier: String {
        String(describing: KMKitWrapperType.self)
    }
    
}


public extension KMKitWrapper where KMKitWrapperType: UITableViewCell {
    
    /// UITableView的子视图的默认复用标识，默认为类名
    static var reuseIdentifier: String {
        String(describing: KMKitWrapperType.self)
    }
    
}


public extension KMKitWrapper where KMKitWrapperType: UITableViewHeaderFooterView {
    
    /// UITableView的子视图的默认复用标识，默认为类名
    static var reuseIdentifier: String {
        String(describing: KMKitWrapperType.self)
    }
    
}



// MARK: - 渐变色


fileprivate extension UIView {
    
    var gradientLayer: CAGradientLayer? {
        set {
            objc_setAssociatedObject(self, "gradientLayer", newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            if let layer = objc_getAssociatedObject(self, "gradientLayer") as? CAGradientLayer {
                return layer
            }
            return nil
        }
    }
    
}
    


extension KMKitWrapper where KMKitWrapperType: UIView {

    func createGradientLayer(frame: CGRect, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        
        /// CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        let cgColors = colors.map { $0.cgColor }
        gradientLayer.colors = cgColors
        
        /// 设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        return gradientLayer
    }
    
    //水平方向渐变
    func addHorizontalGradientLayer(frame: CGRect, fromColor: UIColor, toColor: UIColor) {
        addGradientLayer(frame: frame, colors: [fromColor, toColor], startPoint: .init(x: 0, y: 0.5), endPoint: .init(x: 1, y: 0.5))
    }
    
    //垂直方向渐变
    func addVerticalGradientLayer(frame: CGRect, fromColor: UIColor, toColor: UIColor) {
        addGradientLayer(frame: frame, colors: [fromColor, toColor], startPoint: .init(x: 0.5, y: 0.0), endPoint: .init(x: 0.5, y: 1))
    }
    
    func addGradientLayer(frame: CGRect, fromColor: UIColor, toColor: UIColor, startPoint: CGPoint, endPoint: CGPoint) {
        addGradientLayer(frame: frame, colors: [fromColor, toColor], startPoint: startPoint, endPoint: endPoint)
    }
    
    func addGradientLayer(frame: CGRect,colors: [UIColor], startPoint: CGPoint,endPoint: CGPoint) {
        let layer = createGradientLayer(frame: frame, colors: colors, startPoint: startPoint, endPoint: endPoint)
        kmWrappedValue.gradientLayer = layer
        kmWrappedValue.layer.insertSublayer(layer, at: 0)
    }
    
    
    func getFatherViewWithClassName<T:UIView>(className:T.Type) -> UIView? {
        var superView = kmWrappedValue.superview
        while true {
            if let sview = superView{
                if sview.isKind(of: className){
                    return sview
                }
                superView = sview.superview
            }else{
                break
            }
        }
        return nil
    }
    
    //寻找数组内符合条件的类,先找到哪个返回哪个
    func getFatherViewWithClassNames<T:UIView,T2:UIView>(className:T.Type,className2:T2.Type) -> UIView? {
        var superView = kmWrappedValue.superview
        while true {
            if let sview = superView{
                if sview.isKind(of: className){
                    return sview
                }
                if sview.isKind(of: className2){
                    return sview
                }
                superView = sview.superview
            }else{
                break
            }
        }
        return nil
    }
    
    
        func getFatherViewWithClass(className:String) -> UIView? {
            var superView = kmWrappedValue.superview
    
            while true {
                if let sview = superView{
                    let objType = type(of: sview)
                    let objTypeStr = "\(objType)"
                    if objTypeStr.contains(className){
                        return sview
                    }
                    superView = sview.superview
                }else{
                    break
                }
            }
            return nil
        }
    

}




// MARK: - LoadingView


//#if canImport(SnapKit)
//
//import SnapKit
//
//
//class KMKitLoadingView: UIView {
//    
//    fileprivate var title: String = ""
//    fileprivate var imageView: UIImageView = UIImageView()
//    fileprivate var titleLabel: UILabel = UILabel()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setInterface()
//    }
//    
//    fileprivate var images = [UIImage]()
//         
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    fileprivate func setInterface() {
//        
//        backgroundColor = UIColor.clear
//                
//        titleLabel.km.textColor(name: "ffffff").font(UIFont.KM.fontOfSize(14))
//        titleLabel.numberOfLines = 0
//        
//        addSubview(imageView)
//        imageView.snp.makeConstraints { maker in
//            maker.centerX.equalToSuperview()
//            maker.centerX.equalToSuperview()
//            maker.width.height.equalTo(60)
//        }
//        
//        addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { maker in
//            maker.top.equalTo(imageView.snp.bottom).offset(10)
//            maker.left.equalToSuperview().offset(20)
//            maker.right.equalToSuperview().inset(20)
//        }
//        
//        let images = (1 ..< 9).map { index -> UIImage in
//            let string = "readerloading_\(index)"
//            let img = UIImage(named: string)
//            return img!
//        }
//        
//        imageView.animationImages = images// KMKitLoadingView.appearance().loadingViewImages
//        imageView.animationDuration = 0.8
//        imageView.animationRepeatCount = 0
//        
//    }
//    
//    fileprivate func startAnimation() {
//        imageView.startAnimating()
//    }
//    
//    fileprivate func stopAnimation() {
//        imageView.stopAnimating()
//    }
//}
//
//
//extension UIView {
//    
//    static var KMKitLoadingViewKey = "com.km.associat.key.loadingView"
//    static var KMKitLoadingViewOffsetKey = "com.km.associat.key.loadingView.offset"
//    
//    var loadingViewOffset: CGPoint {
//        get{
//            guard let value = objc_getAssociatedObject(self, &UIView.KMKitLoadingViewOffsetKey) as? NSValue else{
//                return CGPoint.zero
//            }
//            return value.cgPointValue
//        }
//        set{
//            objc_setAssociatedObject(self, &UIView.KMKitLoadingViewOffsetKey, NSValue.init(cgPoint: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//    
//    private var loadingView: KMKitLoadingView {
//        set {
//            objc_setAssociatedObject(self, &UIView.KMKitLoadingViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        
//        get {
//            guard let v = objc_getAssociatedObject(self, &UIView.KMKitLoadingViewKey) as? KMKitLoadingView else {
//                let thisView = KMKitLoadingView()
//                self.loadingView = thisView
//                thisView.alpha = 0
//                thisView.isHidden = true
//                self.addSubview(thisView)
//                thisView.snp.makeConstraints { (make) in
//                    make.left.top.width.height.equalTo(self)
//                }
//                return thisView
//            }
//            return v
//        }
//    }
//    
//    func showLoadingView(with topOffset: CGFloat = 0, backgroundColor: UIColor = UIColor.clear) {
//        self.loadingView.backgroundColor = backgroundColor
//        self.bringSubviewToFront(self.loadingView)
//        self.loadingView.imageView.snp.remakeConstraints { (make) in
//            make.centerY.equalToSuperview().offset(topOffset != 0 ? topOffset : loadingViewOffset.y)
//            make.centerX.equalToSuperview().offset(loadingViewOffset.x)
//            make.width.height.equalTo(60)
//        }
//        DispatchQueue.main.async {
//            self.loadingView.isHidden = false
//            UIView.animate(withDuration: 0.25) {
//                self.loadingView.alpha = 1
//                self.loadingView.startAnimation()
//            }
//        }
//        
//    }
//    
//    func hideLoadingView() {
//        UIView.animate(withDuration: 0.25, animations: {
//            self.loadingView.alpha = 0
//        }) { (flag) in
//            self.loadingView.isHidden = true
//            self.loadingView.stopAnimation()
//        }
//    }
//    
//    
//}
//
//
//#endif


//
//
//// MARK: - Placeholder
//
//
//#if canImport(SnapKit)
//
//import SnapKit
//
//
//class KMKitPlaceHolderView: UIView {
//
//    var title = "" {
//        didSet {
//            self.titleLabel.text = title
//        }
//    }
//    var imageName = "" {
//        didSet {
//            self.imageView.km_setImage(imageName: imageName)
//        }
//    }
//
//    var retryButtonTitle = "" {
//        didSet {
//            retryButton.setTitle(self.retryButtonTitle, for: .normal)
//            let constrainedSize: CGSize = .init(width: UIScreen.main.bounds.width - 40, height: 20)
//            let size = retryButtonTitle.km.sizeWithFont(UIFont.KM.fontOfSize(14), constrainedToSize: constrainedSize)
//            self.retryButton.snp.updateConstraints { (make) in
//                make.width.equalTo(max(size.width, 104))
//            }
//        }
//    }
//
//    var contentOffset: CGPoint = .zero{
//        didSet{
//            self.imageView.snp.updateConstraints { (make) in
//                make.bottom.equalTo(self.snp.centerY).offset(contentOffset.y)
//                make.centerX.equalTo(self).offset(contentOffset.x)
//            }
//        }
//    }
//
//    var block: (() -> Void)?
//
//    private let imageView = UIImageView()
//    private let titleLabel = UILabel()
//    let retryButton = UIButton.init(type: .custom)
//    let customView = UIView()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setInterface()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        btnLayer.frame = retryButton.bounds
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    lazy var btnLayer: CAGradientLayer = {
//        let layer = CAGradientLayer.init()
//        layer.startPoint = CGPoint.init(x: 0, y: 0)
//        layer.endPoint = CGPoint.init(x: 1, y: 0)
//        layer.cornerRadius = 18.0
//        layer.colors = [HexColor(hexString: "FFC2C2")!.cgColor, HexColor(hexString: "FF5C5C")!.cgColor]
//        return layer
//    }()
//
//    func setInterface() {
//        self.titleLabel.km_setTextColor(colorName: Nine)
//        self.titleLabel.textAlignment = NSTextAlignment.center
//        self.titleLabel.font = UIFont.font(with: 14)
//        self.titleLabel.numberOfLines = 0
//
//        self.retryButton.setTitle(self.title, for: .normal)
//        self.retryButton.km_setBackgroundColor(MainColor)
//        self.retryButton.layer.cornerRadius = 16
//        self.retryButton.layer.masksToBounds = true
//        self.retryButton.titleLabel?.font = UIFont.font(with: 14)
//        self.retryButton.km_setTitleColorWith(colorName: FF, state: .normal)
//        self.retryButton.isHidden = true
//
//        self.customView.isHidden = true
//
//        self.addSubview(self.imageView)
//        self.imageView.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self)
//            make.bottom.equalTo(self.snp.centerY)
//        }
//
//        self.addSubview(self.titleLabel)
//        self.titleLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(self.imageView.snp_bottom).offset(8)
//            make.left.equalTo(self).offset(20)
//            make.right.equalTo(self).offset(-20)
//        }
//
//        self.addSubview(self.retryButton)
//        self.retryButton.snp.makeConstraints { (make) in
//            make.top.equalTo(self.titleLabel.snp_bottom).offset((30))
//            make.width.equalTo(104)
//            make.height.equalTo(32)
//            make.centerX.equalTo(self.titleLabel)
//        }
//
//        self.addSubview(self.customView)
//        self.customView.snp_makeConstraints { (m) in
//            m.top.equalTo(self.titleLabel.snp_bottom).offset((6))
//            m.width.equalTo(120)
//            m.height.equalTo(25)
//            m.centerX.equalTo(self.titleLabel)
//        }
//
//
//        self.retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
//    }
//
//    @objc func retry()  {
//        block?()
//    }
//
//}
//
//private var placeholderTitleKey = 200
//private var placeholderImageNameKey = 201
//private var placeholderViewKey = 202
//private var placeholderRetryTitleKey = 203
//
//private var placeholderContentOffsetKey = 204
//private var placeholderEdgeInsetsKey = 205
//
//private var placeholderAlwaysHideRetryKey = 206
//private var placeholderAlwaysShowCustomTitle = 207
//
//extension UIView {
//    var alwaysShowCustomTitle: Bool{
//        set{
//            objc_setAssociatedObject(self, &placeholderAlwaysShowCustomTitle, NSNumber.init(value: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        get{
//            guard let number = objc_getAssociatedObject(self, &placeholderAlwaysShowCustomTitle) as? NSNumber else {
//                return false
//            }
//            return number.boolValue
//        }
//    }
//
//    var alwaysHideRetryBtn: Bool{
//        set{
//            objc_setAssociatedObject(self, &placeholderAlwaysHideRetryKey, NSNumber.init(value: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            if newValue{
//                km_placeholderView.retryButton.isHidden = true
//            }
//        }
//        get{
//            guard let number = objc_getAssociatedObject(self, &placeholderAlwaysHideRetryKey) as? NSNumber else {
//                return false
//            }
//            return number.boolValue
//        }
//    }
//
//    /// 内部内容偏移量
//    var placeholderContentOffset: CGPoint {
//        set {
//            objc_setAssociatedObject(self, &placeholderContentOffsetKey, NSValue.init(cgPoint: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            km_placeholderView.contentOffset = newValue
//        }
//        get {
//            guard let nsvalue = objc_getAssociatedObject(self, &placeholderContentOffsetKey) as? NSValue else {
//                return .zero
//            }
//            return nsvalue.cgPointValue
//        }
//    }
//
//    /// 整个placeHolder偏移 可以留出头部
//    var placeholderEdgeInsets: UIEdgeInsets {
//        set {
//            objc_setAssociatedObject(self, &placeholderEdgeInsetsKey, NSValue.init(uiEdgeInsets: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            km_placeholderView.snp.updateConstraints { (make) in
//                make.left.equalTo(self).offset(newValue.left)
//                make.top.equalTo(self).offset(newValue.top)
//                make.width.equalTo(self).offset(-newValue.left - newValue.right)
//                make.height.equalTo(self).offset(-newValue.top - newValue.bottom)
//            }
//        }
//        get {
//            guard let nsvalue = objc_getAssociatedObject(self, &placeholderEdgeInsetsKey) as? NSValue else {
//                return .zero
//            }
//            return nsvalue.uiEdgeInsetsValue
//        }
//    }
//
//    var placeholderTitle: String {
//        set {
//            objc_setAssociatedObject(self, &placeholderTitleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
//        get {
//            guard let title = objc_getAssociatedObject(self, &placeholderTitleKey) as? String else {
//                return ""
//            }
//            return title
//        }
//    }
//
//    var placeholderImageName: String {
//        set {
//            objc_setAssociatedObject(self, &placeholderImageNameKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
//
//        }
//        get {
//            guard let imageName = objc_getAssociatedObject(self, &placeholderImageNameKey) as? String else {
//                return "icon_read_sofa"
//            }
//            return imageName
//        }
//    }
//
//    var retryTitle: String {
//        set {
//            objc_setAssociatedObject(self, &placeholderRetryTitleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
//
//        get {
//            guard let rTitle = objc_getAssociatedObject(self, &placeholderRetryTitleKey) as? String else {
//                return "重试"
//            }
//            return rTitle
//        }
//    }
//
//
//    private var km_placeholderView: KMHPlaceHolderView {
//        set {
//            objc_setAssociatedObject(self, &placeholderViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        get {
//            guard let view = objc_getAssociatedObject(self, &placeholderViewKey) as? KMHPlaceHolderView else {
//                let thisView = KMHPlaceHolderView()
//                self.km_placeholderView = thisView
//                thisView.isHidden = true
//                self.addSubview(thisView)
//                thisView.snp.makeConstraints { (make) in
//                    make.top.left.width.height.equalTo(self)
//                }
//                return thisView
//            }
//            return view
//        }
//    }
//
//    func showPlaceHolderView(isShow: Bool = true, showRetry: Bool = false) {
//
//        var isShowRetry = showRetry
//
//        DispatchQueue.main.async {
//            if isShow {
//                self.km_placeholderView.isHidden = false
//                self.km_placeholderView.retryButtonTitle = self.retryTitle
//                if NetworkManger.isNetwork() {
//                    self.km_placeholderView.imageName = self.placeholderImageName
//                    self.km_placeholderView.title = self.placeholderTitle
//                }else{
//                    self.km_placeholderView.imageName = "pic_gift_empty"
//                    self.km_placeholderView.title = self.alwaysShowCustomTitle ? self.placeholderTitle : NoNetworkMessage
//                    isShowRetry = true
//                }
//                self.km_placeholderView.retryButton.isHidden = !isShowRetry || self.alwaysHideRetryBtn
//            } else {
//                self.km_placeholderView.isHidden = true
//            }
//        }
//
//    }
//
//    func setRetryBlock(block: @escaping voidClosure) {
//        self.km_placeholderView.block = block
//    }
//
//    func setCustomSubView(view: UIView){
//        self.km_placeholderView.customView.addSubview(view)
//    }
//
//    func showCustomView(isShow: Bool = true){
//        DispatchQueue.main.async {
//            self.km_placeholderView.customView.isHidden = !isShow
//        }
//    }
//}
//
//
//
//#endif
//




// MARK: - Badge

#if canImport(SnapKit)

import SnapKit

class BadgeView: UIView {
    
    /// 默认右上角中心对齐
    var offset: CGPoint = .zero
    
    fileprivate let textLabel = UILabel()
    
    var badgeSize: CGSize = .init(width: 6, height: 6) {
        didSet{
            self.layer.cornerRadius = badgeSize.width / 2.0
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        textLabel.km.textColor(name: "ffffff").font(.systemFont(ofSize: 14.0)).textAlignment(.center)
        self.layer.cornerRadius = badgeSize.width / 2.0
        self.layer.masksToBounds = true
        self.km.backgroundColor(color: .red)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = bounds
    }
}


fileprivate extension UIView {
        
    static var badgeViewKey = "com.km.associat.key.badgeView"
    static var showBadgeViewKey = "com.km.associat.key.badgeView.show"
    static var badgeViewOffsetKey = "com.km.associat.key.badgeView.offset"

    var badgeView: BadgeView {
        get{
            if let view = objc_getAssociatedObject(self, &UIView.badgeViewKey) as? BadgeView{
                return view
            }
            let badge = BadgeView.init(frame: .zero)
            self.badgeView = badge
            return badge
        }
        set{
            objc_setAssociatedObject(self, &UIView.badgeViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置显示红点显隐
    var showBadge: Bool{
        get{
            if let isShow = objc_getAssociatedObject(self, &UIView.showBadgeViewKey) as? Bool{
                return isShow
            }
            return false
        }
        set{
            if newValue != self.showBadge {
                self.badgeShow(isShow: newValue)
            }
            objc_setAssociatedObject(self, &UIView.showBadgeViewKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    
    var badgeValue: String? {
        set {
            badgeView.textLabel.text = newValue
        }
        get {
            return badgeView.textLabel.text
        }
    }
    
    func setBadgeValue(_ value: String, attributes: [NSAttributedString.Key: Any]) {
        let text = NSAttributedString(string: value, attributes: attributes)
        badgeView.textLabel.attributedText = text
    }
    

    

    func setBadgeOffset(x: CGFloat) {
        badgeView.offset.x = x
    }
    
    func setBadgeOffset(y: CGFloat) {
        badgeView.offset.y = y
    }
    
    
    func setBadgeOffset(_ offset: CGPoint) {
        badgeView.offset = offset
    }
    
    func setBadgeSize(size: CGSize){
        badgeView.badgeSize = size
    }
    
    
    func badgeShow(isShow: Bool, offset: CGPoint, badgeSize: CGSize) {
        if isShow{
            badgeView.removeFromSuperview()
            badgeView.snp.removeConstraints()
            addSubview(badgeView)
            
            badgeView.snp.makeConstraints { maker in
                maker.centerX.equalTo(self.snp.right).offset(offset.x)
                maker.centerY.equalTo(self.snp.top).offset(offset.y)
                maker.size.equalTo(badgeSize)
            }
            
        } else {
            badgeView.removeFromSuperview()
        }
    }
    
    func badgeShow(isShow: Bool){
        badgeShow(isShow: isShow, offset: badgeView.offset, badgeSize: badgeView.badgeSize)
    }
    
}


extension KMKitWrapper where KMKitWrapperType: UIView {
    
    private var badgeView: BadgeView {
        get{
            return kmWrappedValue.badgeView
        }
        set{
            kmWrappedValue.badgeView = newValue
        }
    }
    
    /// 设置显示红点显隐
    var showBadge: Bool{
        get {
            return kmWrappedValue.showBadge
        }
        set {
            kmWrappedValue.showBadge = newValue
        }
    }
    
    func setBadgeViewOffset(_ offset: CGPoint) {
        kmWrappedValue.setBadgeOffset(offset)
    }

    func setBadgeSize(_ size: CGSize){
        kmWrappedValue.setBadgeSize(size: size)
    }
    
}


#endif


// MARK: - 添加线条

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



extension KMKitWrapper where KMKitWrapperType: UIView {
    
    
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

