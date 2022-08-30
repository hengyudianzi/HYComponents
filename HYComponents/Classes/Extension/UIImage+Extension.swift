//
//  UIImage+Extension.swift
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation

extension UIImage{
    public func BundleImage(_ imageName:String)-> UIImage? {
            // class: 库里 任意class， static bundle 和 mainBundle 是同一个
            let bundle = Bundle(for: DDPhotoViewController.self)
            let mainBundle = Bundle.main
            let path = bundle.path(forResource: "HYComponents", ofType: "bundle", inDirectory: "HYComponents.framework")
            if let path = path {
                let sdkBundle = Bundle(path: path)
                let image = UIImage(named: imageName, in: sdkBundle, compatibleWith: nil)
                return image
            }
            return nil
    }
}
