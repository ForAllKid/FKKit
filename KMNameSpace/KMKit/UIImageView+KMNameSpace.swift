//
//  UIImageView+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIImageView {
    
    
    func image(name: String) {
        let image = UIImage(named: name)
        kmWrappedValue.image = image
    }
    

}



public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIImageView {
     
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = kmWrappedValue.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        kmWrappedValue.addSubview(blurEffectView)
        kmWrappedValue.clipsToBounds = true
    }

    
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = self.kmWrappedValue
        imgView.km.blur(withStyle: style)
        return imgView
    }
    
}
    

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType: UIImageView {
    
    func download(
        from url: URL,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        placeholder: UIImage? = nil,
        completionHandler: ((UIImage?) -> Void)? = nil) {
        
        kmWrappedValue.image = placeholder
        kmWrappedValue.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
                else {
                    completionHandler?(nil)
                    return
            }
            DispatchQueue.main.async {
                self.kmWrappedValue.image = image
                completionHandler?(image)
            }
        }.resume()
        
    }
    
}
