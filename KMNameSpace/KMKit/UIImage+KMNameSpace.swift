//
//  UIImage+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit
import ImageIO
import Accelerate

extension UIImage: KMKitNamespaceWrappable {}



// MARK: - 创建图片

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIImage {
    
    
    /// 根据一个emoji表情创建一张指定大小的图片
    /// - Parameter emoji: emoji表情，比如 😈
    /// - Parameter size: 图片的宽度
    static func imageWithEmoji(_ emoji: String, size: CGFloat) -> UIImage? {
        
        guard emoji.count > 0, size > 1 else {
            return nil
        }

        /// 获取屏幕的scale
        let scale = UIScreen.main.scale
        
        let ctFont = CTFontCreateWithName(
            "AppleColorEmoji" as CFString,
            size * scale,
            nil
        )
        
        let font = ctFont as UIFont
        
        let att: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        
        let str = NSAttributedString(string: emoji, attributes: att)
                    
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let ctx = CGContext(data: nil, width: Int(size * scale), height: Int(size * scale), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) else {
            return nil
        }

        ctx.interpolationQuality = .high

        let cfString = str as CFAttributedString
        let line = CTLineCreateWithAttributedString(cfString)

        let bounds = CTLineGetBoundsWithOptions(line, .useGlyphPathBounds)

        ctx.textPosition = .init(x: 0, y: -bounds.origin.y)

        CTLineDraw(line, ctx)

        guard let cgImage = ctx.makeImage() else {
            return nil
        }
        
        let image = UIImage(
            cgImage: cgImage,
            scale: scale,
            orientation: .up
        )
        
        return image
    }

    /// 根据颜色创建一张图片，大小可以指定，默认为 1 x 1 pt的大小，不能为负数，不然返回为nil
    /// - Parameter color: 颜色
    /// - Parameter size: 大小
    static func imageWithColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        
        guard size != .zero else {
            return nil
        }
        
        let rect = CGRect(origin: .zero, size: size)

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        defer { UIGraphicsEndImageContext() }
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }

        ctx.setFillColor(color.cgColor)
        ctx.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()

        return image
        
    }
    

    
}


// MARK: - 获取图片信息

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIImage {
    
    
    /// 是否包含alpha通道
    var hasAlphaChannel: Bool {
        
        guard let cgImage = kmWrappedValue.cgImage else {
            return false
        }
        
        let alpha = cgImage.alphaInfo.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        
        return (alpha == CGImageAlphaInfo.first.rawValue ||
                alpha == CGImageAlphaInfo.last.rawValue ||
                alpha == CGImageAlphaInfo.premultipliedFirst.rawValue ||
                alpha == CGImageAlphaInfo.premultipliedLast.rawValue)
    }
    
    /// 图片占用的磁盘大小（byte）
    var bytesSize: Int {
        return kmWrappedValue.jpegData(compressionQuality: 1)?.count ?? 0
    }
    
    /// 获取原图
    var original: UIImage {
        return kmWrappedValue.withRenderingMode(.alwaysOriginal)
    }
    
    /// 咋翻译呢
    var template: UIImage {
        return kmWrappedValue.withRenderingMode(.alwaysTemplate)
    }
    
}
    

// MARK: - 修改图片

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIImage {
    
    /// 根据特定大小，指定的contentMode重新绘制图片
    /// - Parameter rect: 绘制的区域
    /// - Parameter contentMode: contentMode
    /// - Parameter clipsToBounds: 图片超出部分是否裁剪
    func draw(in rect: CGRect, contentMode: UIView.ContentMode = .scaleToFill, clipsToBounds: Bool = false) {
        
        let drawRect = KMKit.rectFitWithContentMode(
            rect: rect,
            size: kmWrappedValue.size,
            contentMode: contentMode
        )
        
        guard drawRect.size != .zero else {
            return
        }
        
        if clipsToBounds {
            
            if let ctx = UIGraphicsGetCurrentContext() {
                
                ctx.saveGState()
                
                ctx.addRect(rect)
                
                ctx.clip()

                kmWrappedValue.draw(in: drawRect)
                
                ctx.restoreGState()
 
            }
            
        } else {
            kmWrappedValue.draw(in: drawRect)
        }
        
    }
    
    /// 根据指定的大小改变图片的宽高
    /// - Parameter size: 大小
    func imageByResize(to size: CGSize) -> UIImage? {
        
        guard size.width > 0, size.height > 0 else {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(size, false, kmWrappedValue.scale)
        
        defer {
            UIGraphicsEndImageContext()
        }

        kmWrappedValue.draw(
            in: .init(origin: .zero, size: size)
        )

        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
    }

    
    /// 获取图片指定区域的内容（裁剪）
    /// - Parameter rect: 指定区域
    func imageByCrop(to rect: CGRect) -> UIImage? {
        
        var rect = rect
    
        rect.origin.x *= kmWrappedValue.scale
        rect.origin.y *= kmWrappedValue.scale
        rect.size.width *= kmWrappedValue.scale
        rect.size.height *= kmWrappedValue.scale
        
        guard rect.size.width > 0, rect.size.height > 0, let cgImage = kmWrappedValue.cgImage else {
            return nil
        }
  
        guard let ref = cgImage.cropping(to: rect) else {
            return nil
        }
        
        let image = UIImage(
            cgImage: ref,
            scale: kmWrappedValue.scale,
            orientation: kmWrappedValue.imageOrientation
        )
                
        return image
        
    }

    
    /// 改变图片内间距
    /// - Parameter insets: 内间距
    /// - Parameter color: 填充颜色
    func imageByInsetsEdge(_ insets: UIEdgeInsets, color: UIColor?) -> UIImage? {
        
        var size = kmWrappedValue.size
        
        size.width -= insets.left + insets.right
        size.height -= insets.top + insets.bottom
        
        guard size.width > 0, size.height > 0 else {
            return nil
        }

        let rect = CGRect(
            x: -insets.left,
            y: -insets.top,
            width: kmWrappedValue.size.width,
            height: kmWrappedValue.size.height
        )
        
        UIGraphicsBeginImageContextWithOptions(size, false, kmWrappedValue.scale)

        defer {
            UIGraphicsEndImageContext()
        }

        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        if let c = color {

            ctx.setFillColor(c.cgColor)
                        
            let path = CGMutablePath()
            
            path.addRect(.init(origin: .zero, size: size))
            
            path.addRect(rect)

            ctx.addPath(path)
            
            ctx.drawPath(using: .eoFill)

        }
        
        kmWrappedValue.draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()

        return image
        
    }
    
    /// 为图片添加圆角、边框粗细和颜色、以及边框连接样式
    /// - Parameter radius: 圆角值
    /// - Parameter corners: 圆角位置
    /// - Parameter borderWidth: 边框粗细值
    /// - Parameter borderColor: 边框颜色
    /// - Parameter borderLineJoin: 边框线条连接样式
    func imageByRoundCornerRadius(
        _ radius: CGFloat,
        corners: UIRectCorner = .allCorners,
        borderWidth: CGFloat = 0.0,
        borderColor: UIColor? = nil,
        borderLineJoin: CGLineJoin = .miter) -> UIImage? {
    
        UIGraphicsBeginImageContextWithOptions(kmWrappedValue.size, false, kmWrappedValue.scale)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = kmWrappedValue.cgImage else {
            return nil
        }
        
        let rect = CGRect(origin: .zero, size: kmWrappedValue.size)

        ctx.scaleBy(x: 1, y: -1)
        ctx.translateBy(x: 0, y: -rect.height)
                
        let minSize = min(kmWrappedValue.size.width, kmWrappedValue.size.height)
        
        if borderWidth < minSize / 2 {
            
            let path = UIBezierPath(
                roundedRect: rect.insetBy(
                    dx: borderWidth,
                    dy: borderWidth
                ),
                byRoundingCorners: corners,
                cornerRadii: .init(
                    width: radius,
                    height: borderWidth
                )
            )
                
            path.close()
            
            ctx.saveGState()

            path.addClip()

            ctx.draw(cgImage, in: rect)

            ctx.restoreGState()

        }
        
        if let borderColor = borderColor, borderWidth < minSize / 2, borderWidth > 0 {
            
            let strokeInset = (floor(borderWidth * kmWrappedValue.scale) + 0.5) / kmWrappedValue.scale
            let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius = radius > kmWrappedValue.scale / 2 ? radius - kmWrappedValue.scale / 2 : 0

            let path = UIBezierPath(
                roundedRect: strokeRect,
                byRoundingCorners: corners,
                cornerRadii: .init(
                    width: strokeRadius,
                    height: borderWidth
                )
            )
                
            path.close()
            
            path.lineWidth = borderWidth
            
            path.lineJoinStyle = borderLineJoin
            
            borderColor.setStroke()

            path.stroke()
        }
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
        
    }
    

    /// 旋转。。。
    /// - Parameter radians: 角度
    /// - Parameter fitSize: 是否自适应大小
    func imageByRotate(_ radians: CGFloat, fitSize: Bool = false) -> UIImage? {
        
        guard let cgImage = kmWrappedValue.cgImage else {
            return nil
        }
        
        let width = cgImage.width
        let height = cgImage.height

        let imageRect = CGRect(origin: .zero, size: .init(width: width, height: height))
        
        let transform = fitSize ? CGAffineTransform(rotationAngle: radians) : .identity
        let newRect = imageRect.applying(transform)
        
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        /// 这个坑爹的创建方式
        guard let ctx = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: colorSpace,
            bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue ) else {
                return nil
        }
        
        ctx.setShouldAntialias(true)
        ctx.setAllowsAntialiasing(true)
        ctx.interpolationQuality = .high
        
        ctx.translateBy(x: +(newRect.width * 0.5), y: +(newRect.height * 0.5))
        ctx.rotate(by: radians)

        ctx.draw(
            cgImage,
            in: CGRect(
                x:-(CGFloat(width) * 0.5),
                y: -(CGFloat(height) * 0.5),
                width: CGFloat(width),
                height: CGFloat(height)
            )
        )
        
        guard let imageRef = ctx.makeImage() else {
            return nil
        }
        
        let img = UIImage(
            cgImage: imageRef,
            scale: kmWrappedValue.scale,
            orientation: kmWrappedValue.imageOrientation
        )

        return img
        
    }
    
    /// 向左旋转90°
    var imageByRotateLeft90: UIImage? {
        imageByRotate(90, fitSize: true)
    }
    
    /// 向右旋转90°
    var imageByRotateRight90: UIImage? {
        imageByRotate(-90, fitSize: true)
    }
    
    /// 旋转180°
    var imageByRotate180: UIImage? {
        _km_flipHorizontal(true, vertical: true)
    }
    
    /// 垂直翻转
    var imageByFlipVertical: UIImage? {
        _km_flipHorizontal(false, vertical: true)
    }
    
    /// 水平翻转
    var imageByFlipHorizontal: UIImage? {
        _km_flipHorizontal(true, vertical: false)
    }
    
    
    
    
    /// 内部方法
    /// - Parameter horizontal: 是否水平翻转
    /// - Parameter vertical: 是否垂直翻转
    private func _km_flipHorizontal(_ horizontal: Bool, vertical: Bool) -> UIImage? {
        
        guard let cgImage = kmWrappedValue.cgImage else {
            return nil
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerRow = width * 4
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let ctx = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) else {
                return nil
        }
        
        let drawRect = CGRect(origin: .zero, size: .init(width: width, height: height))
        ctx.draw(cgImage, in: drawRect)

        guard let data = ctx.data else {
            return nil
        }

        var src = vImage_Buffer(
            data: data,
            height: vImagePixelCount(height),
            width: vImagePixelCount(width),
            rowBytes: bytesPerRow
        )
        
        var dest = vImage_Buffer(
            data: data,
            height: vImagePixelCount(height),
            width: vImagePixelCount(width),
            rowBytes: bytesPerRow
        )


        if vertical {
            vImageVerticalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        
        if horizontal {
            vImageHorizontalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        
        guard let ref = ctx.makeImage() else {
            return nil
        }

        let img = UIImage(cgImage: ref, scale: kmWrappedValue.scale, orientation: kmWrappedValue.imageOrientation)

        return img
        
    }
    
    
}



// MARK: - 图片着色以及blur样式（blur样式待完善）

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIImage {

    /// 重新着色
    /// - Parameter color: 着色值
    func imageByTintColor(_ color: UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(kmWrappedValue.size, false, kmWrappedValue.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        
        let rect = CGRect(origin: .zero, size: kmWrappedValue.size)
        color.set()
        UIRectFill(rect)
        
        kmWrappedValue.draw(at: .zero, blendMode: .destinationIn, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage
    }
 
    
}








