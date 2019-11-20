//
//  CGRect+.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension CGRect: KMKitCompatible {

}

extension KMKitWrapper where KMKitWrapperType == CGRect {
    
    func fitWithContentMode(_ contentMode: UIView.ContentMode, targetSize: CGSize) -> CGRect {
        
        var rect = kmWrappedValue.standardized
        var size = targetSize
        
        size.width = size.width < 0 ? -size.width : size.width
        size.height = size.height < 0 ? -size.height : size.height
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        switch contentMode {
            
            case .scaleAspectFit, .scaleAspectFill:
                
                if rect.width < 0.01 || rect.height < 0.01 || size.width < 0.01 || size.height < 0.01 {
                    rect.origin = center
                    rect.size = .zero
                    
                } else {
                    
                    var scale: CGFloat = 0.0
                    
                    if contentMode == .scaleAspectFit {
                        
                        if size.width / size.height < rect.width / rect.height {
                            scale = rect.height / size.height
                        } else {
                            scale = rect.width / size.width
                        }
                        
                    } else {
                        
                        if size.width / size.height < rect.width / rect.height {
                            scale = rect.width / size.width
                        } else {
                            scale = rect.height / size.height
                        }
                    }
                    
                    size.width *= scale
                    size.height *= scale
                    rect.size = size
                    
                    rect.origin = CGPoint(
                        x: center.x - size.width * 0.5,
                        y: center.y - size.height * 0.5
                    )
            }
            
            case .center:
                rect.size = size
                rect.origin = CGPoint(
                    x: center.x - size.width * 0.5,
                    y: center.y - size.height * 0.5
            )
            
            case .top:
                rect.origin.x = center.x - size.width * 0.5
                rect.size = size
            
            
            case .bottom:
                rect.origin.x = center.x - size.width * 0.5
                rect.origin.y += rect.height - size.height
                rect.size = size
            
            case .left:
                rect.origin.y = center.y - size.height * 0.5
                rect.size = size;
            
            case .right:
                rect.origin.y = center.y - size.height * 0.5
                rect.origin.x += rect.size.width - size.width
                rect.size = size
            
            case .topLeft:
                rect.size = size
            
            case .topRight:
                rect.origin.x += rect.width - size.width
                rect.size = size
            
            case .bottomLeft:
                rect.origin.y += rect.height - size.height
                rect.size = size
            
            case .bottomRight:
                rect.origin.x += rect.width - size.width
                rect.origin.y += rect.height - size.height
                rect.size = size
            
            default:
                break
            
        }
        return rect
    }
    
}


//public struct KMKit {
//    
//    static func rectFitWithContentMode(rect: CGRect, size: CGSize, contentMode: UIView.ContentMode) -> CGRect {
//                
//        var rect = rect.standardized
//        var size = size
//        
//        size.width = size.width < 0 ? -size.width : size.width
//        size.height = size.height < 0 ? -size.height : size.height
//        let center = CGPoint(x: rect.midX, y: rect.midY)
//
//        switch contentMode {
//         
//            case .scaleAspectFit, .scaleAspectFill:
//
//                if rect.width < 0.01 || rect.height < 0.01 || size.width < 0.01 || size.height < 0.01 {
//                    rect.origin = center
//                    rect.size = .zero
//                    
//                } else {
//                    
//                    var scale: CGFloat = 0.0
//                    
//                    if contentMode == .scaleAspectFit {
//                        
//                        if size.width / size.height < rect.width / rect.height {
//                            scale = rect.height / size.height
//                        } else {
//                            scale = rect.width / size.width
//                        }
//                        
//                    } else {
//                        
//                        if size.width / size.height < rect.width / rect.height {
//                            scale = rect.width / size.width
//                        } else {
//                            scale = rect.height / size.height
//                        }
//                    }
//                    
//                    size.width *= scale
//                    size.height *= scale
//                    rect.size = size
//                    
//                    rect.origin = CGPoint(
//                        x: center.x - size.width * 0.5,
//                        y: center.y - size.height * 0.5
//                    )
//                }
//
//            case .center:
//                rect.size = size
//                rect.origin = CGPoint(
//                    x: center.x - size.width * 0.5,
//                    y: center.y - size.height * 0.5
//            )
//
//            case .top:
//                rect.origin.x = center.x - size.width * 0.5
//                rect.size = size
//                
//
//            case .bottom:
//                rect.origin.x = center.x - size.width * 0.5
//                rect.origin.y += rect.height - size.height
//                rect.size = size
//
//            case .left:
//                rect.origin.y = center.y - size.height * 0.5
//                rect.size = size;
//
//            case .right:
//                rect.origin.y = center.y - size.height * 0.5
//                rect.origin.x += rect.size.width - size.width
//                rect.size = size
//
//            case .topLeft:
//                rect.size = size
//
//            case .topRight:
//                rect.origin.x += rect.width - size.width
//                rect.size = size
//
//            case .bottomLeft:
//                rect.origin.y += rect.height - size.height
//                rect.size = size
//
//            case .bottomRight:
//                rect.origin.x += rect.width - size.width
//                rect.origin.y += rect.height - size.height
//                rect.size = size
//
//            default:
//                break
//            
//        }
//        return rect
//    }
//    
//    
//}




