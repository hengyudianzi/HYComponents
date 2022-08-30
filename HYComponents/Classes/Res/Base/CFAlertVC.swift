//
//  AlertVC+Extension.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/26.
//

import Foundation
import UIKit

public class CFAlertVC : NSObject {

    //MARK: - alterController 两个按钮 处理otherBtn事件
    
    /// alterController 两个按钮 处理otherBtn事件
    ///
    /// - Parameters:
    ///   - currentVC:  当前控制器
    ///   - msg:        提示消息
    ///   - cancel:     取消按钮
    ///   - other:      其他按钮
    ///   - handle:     其他按钮处理事件
    public static func showAlert(currentVC:UIViewController,msg:String,cancel:String,other:String?,handle:((UIAlertAction)->Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
            //ipad使用，不加ipad上会崩溃
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = currentVC.view
                popoverController.sourceRect = currentVC.view.bounds
            }
            
            let cancelAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            if other != nil{
                let otherAction = UIAlertAction(title: other, style: UIAlertAction.Style.default, handler: { (action) in
                    handle!(action)
                })
                alertController.addAction(otherAction)
            }
            currentVC.present(alertController, animated: true, completion: nil)
        }
    }

    //MARK: - alterController 一个按钮
    
    /// alterController 一个按钮
    ///
    /// - Parameters:
    ///   - currentVC:  当前控制器
    ///   - cancelBtn:  关闭按钮的文字
    ///   - meg:        提示消息
    public static func showAlert(currentVC:UIViewController, cancelBtn:String, meg:String){
        showAlert(currentVC: currentVC, msg: meg, cancel: cancelBtn, other: nil, handle: nil)
    }
    
    
    //MARK: - alterController 两个按钮 都处理事件
    
    /// alterController 两个按钮 都处理事件
    ///
    /// - Parameters:
    ///   - currentVC:          当前控制器
    ///   - meg:                提示消息
    ///   - cancelBtn:          取消按钮
    ///   - otherBtn:           其他按钮
    ///   - cencelHandler:      取消按钮事件回调 （不处理可不写，考虑到有些场合需要使用）
    ///   - handler:            其他按钮事件回调
    public static func showAlert(currentVC:UIViewController, meg:String, cancelBtn:String, otherBtn:String?,cencelHandler:((UIAlertAction) -> Void)?, handler:((UIAlertAction) -> Void)?){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title:"",
                                                    message:meg ,
                                                    preferredStyle: .alert)
            //ipad使用，不加ipad上会崩溃
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = currentVC.view
                popoverController.sourceRect = currentVC.view.bounds
            }
            
            let cancelAction = UIAlertAction(title:cancelBtn, style: .cancel, handler:{ (action) -> Void in
                cencelHandler?(action)
            })
            alertController.addAction(cancelAction)
            
            if otherBtn != nil{
                let settingsAction = UIAlertAction(title: otherBtn, style: .default, handler: { (action) -> Void in
                    handler?(action)
                })
                alertController.addAction(settingsAction)
            }
            currentVC.present(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: - alterSheet两个按钮 都处理事件
    
    /// alterSheet两个按钮 都处理事件
    ///
    /// - Parameters:
    ///   - currentVC:      当前控制器
    ///   - meg:            提示消息
    ///   - cancelBtn:      取消按钮
    ///   - items:          数据
    ///   - sender:         取消按钮事件回调 （不处理可不写，考虑到有些场合需要使用）
    ///   - handler:        其他按钮事件回调
    public static func showAlertSheet(currentVC:UIViewController, meg:String, cancelBtn:String, items:[String]?,sender:Any, handler:((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title:"" , message: meg, preferredStyle:.actionSheet)
            
            let action = UIAlertAction(title:cancelBtn, style: UIAlertAction.Style.cancel, handler:nil)
            alertView.addAction(action)
            
            for str in items! {
                let action2 = UIAlertAction(title:str, style: UIAlertAction.Style.default, handler: { (alertAction) in
                    handler!(alertAction)
                })
                alertView.addAction(action2)
            }
            currentVC.popoverPresentationController?.sourceView = currentVC.view
            currentVC.popoverPresentationController?.sourceRect = CGRect(origin:currentVC.view.center, size: CGSize(width:1, height: 1))
            currentVC.present(alertView, animated: true, completion: {
            })
        }
    }
    //MARK:自定义日期选择器
    
    /// 自定义日期选择器
    ///
    /// - Parameters:
    ///   - currentVc:      当前控制器
    ///   - cancelBtn:      关闭按钮
    ///   - otherBtn:       其他按钮
    ///   - formart :       "YYYY-MM-dd HH:mm:ss"
    ///   - sureAction:     其他按钮的回调
    public static func showAlertSheet_Date(currentVc:UIViewController,cancelBtn:String,otherBtn:String,formart:String,sureAction:@escaping(_ respone:String)->())
    {
        DispatchQueue.main.async {
            let alertController:UIAlertController = {
                let alertC:UIAlertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
                return alertC
            }()
            
            let datePicker:UIDatePicker = {
                let picker = UIDatePicker()
                picker.locale = NSLocale(localeIdentifier: "zh_CN") as Locale //将日期选择器区域设置为中文，则选择器日期显示为中文
                picker.datePickerMode = UIDatePicker.Mode.date // 设置样式，当前设为同时显示日期和时间
                picker.date = NSDate() as Date // 设置默认时间
                picker.frame = CGRect(x: 5, y: picker.frame.minY, width: alertController.view.frame.width-30, height: picker.frame.height)
//                picker.backgroundColor = UIColor.red
                return picker
            }()
            alertController.view.addSubview(datePicker)
            
            let sureAction = { () -> UIAlertAction in
                let sure = UIAlertAction(title: otherBtn, style: .default, handler: { (action) in
                    let dateString =  datePicker.date.toString(format: formart )
                    sureAction(dateString)
                })
                return sure
            }()
            alertController.addAction(sureAction)
            
            if !cancelBtn.isEmpty{
                let cancelAction = { () -> UIAlertAction in
                    let cancel = UIAlertAction(title:cancelBtn, style: .cancel, handler:nil)
                    return cancel
                }()
                alertController.addAction(cancelAction)
            }
            currentVc.present(alertController, animated: true, completion: nil)
        }
    }
}
