//
//  LWUIButton+Extension.swift
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation

extension UIButton{
    
    public func setAttributedTitles(titles:[[Any]],textColor:UIColor,for state: UIControl.State)  {
       self.titleLabel?.numberOfLines = 0
        let  attriTitles = NSMutableAttributedString.init(string: "")
        for itemArr in titles {
            var title:String?
            var font:UIFont?
            for item in itemArr{
                if item is String
                {
                    title = item as? String
                }else if item is UIFont{
                    font = item as? UIFont
                }
            }
            if title == nil || font == nil  {
                continue
            }
            
            let  newAttriTitles = NSAttributedString.init(string: title!, attributes: [NSAttributedString.Key.foregroundColor : textColor,NSAttributedString.Key.font : font!])
            attriTitles.append(newAttriTitles)
        }
       self.setAttributedTitle( attriTitles, for: state)
      
    }
}

//基础设置
extension UIButton {
    public func normalTitle(title:String)-> UIButton {
        self.setTitle(title, for: .normal)
        return self
    }
    public func normalTextColor(color:UIColor)-> UIButton {
           self.setTitleColor(color, for: .normal)
           return self
    }
    
    public func normalImage(image:UIImage?) -> UIButton {//
        self.setImage(image, for: .normal)
          return self
    }
    
    public func backgroundColor(color:UIColor) -> UIButton {
        self.backgroundColor = color
        return self
    }
    
    public func touchUpInside(_ target: Any?, action: Selector) ->  UIButton{
        self.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
         return self
    }
    
    public func  subLayerBorder(width: CGFloat? = nil, color: UIColor? = nil) ->UIButton {
        _ = self.layerBorder(width: width, color: color)
        return self
    }
    
//    func end()  {
//
//    }

}
