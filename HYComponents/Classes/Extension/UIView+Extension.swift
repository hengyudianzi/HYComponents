//
//  UIView+Extension.swift
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation


//给view扩展设置部分角是原角的方法
extension UIView {

    /// 设置多个圆角
    ///
    /// - Parameters:
    ///   - cornerRadii: 圆角幅度
    ///   - roundingCorners: UIRectCorner(rawValue: (UIRectCorner.topRight.rawValue) | (UIRectCorner.bottomRight.rawValue))
     public func filletedCorner(_ cornerRadii:CGSize,_ roundingCorners:UIRectCorner)  {
          let fieldPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii:cornerRadii )
          let fieldLayer = CAShapeLayer()
          fieldLayer.frame = bounds
          fieldLayer.path = fieldPath.cgPath
          self.layer.mask = fieldLayer
    }

}

extension UIView {
    
    //父控制器 controller
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
extension UIView {
        
    @objc  func addSubViews(views:[UIView])  {
        for view in views {
            if view.superview != nil
            {
                continue
            }
            self.addSubview(view)
        }
    }
}

extension UIView{//颜色
    
    public func colorClear() {
        self.backgroundColor = UIColor.clear
    }
    public func colorGroupTableViewBackground() {
        self.backgroundColor = UIColor.groupTableViewBackground
    }
    public func colorWhite() {
        self.backgroundColor = UIColor.white
    }
    
}

extension UIView{//
    public func cornerRadius(radius:CGFloat,clip:Bool)  {
        self.layer.cornerRadius = radius
        self.clipsToBounds = clip
    }
}

extension UIView{//
    public func fitContentViewHeight()  {
        var maxY:CGFloat = 0
        for subView in self.subviews {
            if maxY < subView.frame.maxY
            {
                maxY = subView.frame.maxY
            }
        }
        var frame = self.frame
        frame.size.height = maxY
        self.frame = frame
    }
}


extension UIView{
    @objc  func onClickViewListener(sender:UIView)  {
        
    }
    
    public func addTargetForButtons(buttons:Array<UIButton>)  {
        for button in buttons {
            button.addTarget(self, action: #selector(UIViewController.onClickViewListener(sender:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    public func addTapGestureRecognizer(for views:Array<UIView>)  {
        for view in views {
            let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(UIView.onViewTapGestureRecognizerListener(sender:)))
            view.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    @objc  func onViewTapGestureRecognizerListener(sender:UITapGestureRecognizer)  {
        
    }
}

extension UIView {

    public func layerBorder(width:CGFloat?=nil,color:UIColor?=nil) ->UIView{
          if width != nil {
              self.layer.borderWidth = width!
          }
          
          if color != nil {
              self.layer.borderColor = color?.cgColor
          }
         
          return self
          
      }
    
    public func end()  {
        
    }

}

class GradientColor: UIView {



    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
public extension UIView {
    
    //Colors：渐变色色值数组
    public  func setLayerColors(_ colors:[CGColor])  {
            let layer = CAGradientLayer()
            layer.frame = bounds
            layer.colors = colors
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 1, y: 0)
            self.layer.addSublayer(layer)
    }
    
    
    // MARK: 添加渐变色图层
    public  func gradientColor(_ startPoint: CGPoint, _ endPoint: CGPoint, _ colors: [Any]) {
        
        guard startPoint.x >= 0, startPoint.x <= 1, startPoint.y >= 0, startPoint.y <= 1, endPoint.x >= 0, endPoint.x <= 1, endPoint.y >= 0, endPoint.y <= 1 else {
            return
        }
        
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
        
        var gradientLayer: CAGradientLayer!
        
        removeGradientLayer()

        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
        // self如果是UILabel，masksToBounds设为true会导致文字消失
        self.layer.masksToBounds = false
    }
    
    // MARK: 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    public func removeGradientLayer() {
        if let sl = self.layer.sublayers {
            for layer in sl {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}
