//
//  UIViewController+Extension.swift
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation

extension UIViewController {
    
    public  func addTargetForButtons(buttons:Array<UIButton>)  {
        for button in buttons {
            button.addTarget(self, action: #selector(UIViewController.onClickViewListener(sender:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    @objc public  func onClickViewListener(sender:UIView)  {
        
    }
    
    public func addTapGestureRecognizer(for views:Array<UIView>)  {
        for view in views {
            let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(UIView.onViewTapGestureRecognizerListener(sender:)))
            view.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    @objc public func onViewTapGestureRecognizerListener(sender:UITapGestureRecognizer)  {
    }
    
    public func addTargetForTextFeildChange(textFeilds:Array<UITextField>){
        for textFeild in textFeilds {
            textFeild.addTarget(self, action: #selector(UIViewController.onTextFeildValueChangedListener(sender:)), for: UIControl.Event.editingChanged)
        }
    }
    @objc public  func onTextFeildValueChangedListener(sender:UITextField)  {
        
    }
   
}


