//
//  QRCodeImageCreate.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/5/10.
//

import Foundation


public class QRCodeImageCreate : NSObject {
    //创建二维码图片
    public static func createQRForString(_ qrString: String?, qrImageName: String?) -> UIImage?{
        
        if let sureQRString = qrString {
            
            let stringData = sureQRString.data(using: String.Encoding.utf8,
                                               allowLossyConversion: false)
            // 创建一个二维码的滤镜
            let qrFilter = CIFilter(name: "CIQRCodeGenerator")!
            //1.2 恢复默认设置
              qrFilter.setDefaults()
            //1.3 设置生成的二维码的容错率
            //value = @"L/M/Q/H"
            qrFilter.setValue("H", forKey: "inputCorrectionLevel")
            // 2.设置输入的内容(KVC)
            // 注意:key = inputMessage, value必须是NSData类型
            qrFilter.setValue(stringData, forKey: "inputMessage")
           
            let qrCIImage = qrFilter.outputImage
            // 创建一个颜色滤镜,黑白色
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setDefaults()
            colorFilter.setValue(qrCIImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
            // 返回二维码image
            let codeImage = UIImage(ciImage: colorFilter.outputImage!
                .transformed(by: CGAffineTransform(scaleX: 10, y: 10)))
            // 通常,二维码都是定制的,中间都会放想要表达意思的图片
           if qrImageName != nil
           {
            if let iconImage = UIImage(named: qrImageName!) {
                let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
                UIGraphicsBeginImageContext(rect.size)
                
                codeImage.draw(in: rect)
                let avatarSize = CGSize(width: rect.size.width * 0.15, height: rect.size.height * 0.15)
                let x = (rect.width - avatarSize.width) * 0.5
                let y = (rect.height - avatarSize.height) * 0.5
                iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                
                UIGraphicsEndImageContext()
                return resultImage
            }
            }
            return codeImage
        }
        return nil
    }

}
