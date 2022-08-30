//
//  LWImage+Extension.swift
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation


extension UIImage {
    
    public  class func createQRCodeImage(content: String, size: CGSize) -> UIImage {
        let stringData = content.data(using: String.Encoding.utf8)
        
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
        
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValuesForKeys(["inputImage" : (qrFilter?.outputImage)!,"inputColor0":CIColor.init(cgColor: UIColor.black.cgColor),"inputColor1":CIColor.init(cgColor: UIColor.white.cgColor)])
        
        let qrImage = colorFilter?.outputImage
        let cgImage = CIContext(options: nil).createCGImage(qrImage!, from: (qrImage?.extent)!)
        
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context!.interpolationQuality = .none
        context!.scaleBy(x: 1.0, y: -1.0)
        context?.draw(cgImage!, in: (context?.boundingBoxOfClipPath)!)
        let codeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return codeImage!
    }
    
    //创建二维码图片
    public  class func createQRForString(_ qrString: String?, qrImageName: String?) -> UIImage?{
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
                let avatarSize = CGSize(width: rect.size.width * 0.25, height: rect.size.height * 0.25)
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


  
    
    public class func createImageFrom(color: UIColor, width: CGFloat = 1, height: CGFloat = 1,radius:CGFloat) -> UIImage? {
      return  createImageFrom(color: color, size: CGSize.init(width: width, height: height),radius: 1)
    }
    
    public class func createImageFrom(color: UIColor, size: CGSize = CGSize(width: 1, height: 1) ,radius:CGFloat) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        drawRoundingCorner(context: context!, rect: rect, radius: rect.size.height/2)
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
    
    public class  func drawRoundingCorner(context:CGContext,rect: CGRect ,radius:CGFloat)  {
    /**
     *  使用贝塞尔曲线画出一个圆形图
     *
     *  @param CGRect 图片路径
     *
     *  @return 圆角大小
     */
    //绘制路线
        context.addPath(UIBezierPath(roundedRect: rect,
                                     byRoundingCorners: UIRectCorner.allCorners,
                                     cornerRadii: CGSize(width: radius, height: radius)).cgPath)
    //裁剪
        UIGraphicsGetCurrentContext()?.clip()
    }
}
