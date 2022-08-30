//
//  CFPGDatePickView.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/26.
//

import UIKit
import PGDatePicker

public func initCFPGDatePick() -> PGDatePickManager{
    let manager = PGDatePickManager()
    
    //时间选择器
    let datePicker = manager.datePicker!
    datePicker.datePickerMode = .date
    
    manager.titleLabel.text = ""
    manager.titleLabel.textColor = UIColor.black
     //设置半透明的背景颜色
    manager.isShadeBackground = true
     //设置头部的背景颜色
    manager.headerViewBackgroundColor = UIColor.groupTableViewBackground
     //设置线条的颜色
     datePicker.lineBackgroundColor = UIColor.groupTableViewBackground
     //设置取消按钮的字体颜色
    manager.cancelButtonTextColor = UIColor(hexString: navigation_BKColor)
     //设置取消按钮的字
    manager.cancelButtonText = "取消";
     //设置取消按钮的字体大小
    manager.cancelButtonFont = UIFont.systemFont(ofSize: 16.0)
     
     //设置确定按钮的字体颜色
    manager.confirmButtonTextColor = UIColor(hexString: navigation_BKColor)
     //设置确定按钮的字
    manager.confirmButtonText = "确定";
     //设置确定按钮的字体大小
    manager.confirmButtonFont = UIFont.systemFont(ofSize: 16.0)
    return manager
}



public enum DateType {
    case date       //年月日 时分秒
    case yearOrDay  //年月日
    case yearOrMonth //年月
    case year //年
    
}

public class CFPGDatePickView: NSObject {
        
    //显示 选择日期的选择框
    public static func showPGDataPick(_ vc:UIViewController,_ model:PGDatePickerMode){
        
        let datePickManager = initCFPGDatePick()
        let datePicker = datePickManager.datePicker!
        datePicker.datePickerMode = model
        datePickManager.datePicker.delegate = vc.self as? PGDatePickerDelegate
        vc.present(datePickManager, animated: false, completion: nil)
    }
    
    
    //日期选择 之后 修改 自己响应格式 的 字符串  年月
    public static func dateComponentsToStr(_ dateComponents: DateComponents, _ dateType:DateType = .date) -> String{
        
        let month =  (dateComponents.month?.description)!
        let day =  (dateComponents.day?.description)!
        let hour =  (dateComponents.hour?.description)!
        let min =  (dateComponents.minute?.description)!
        let secound =  (dateComponents.second?.description)!
        
        
        switch dateType {
        case .date:
            let rideTime = (dateComponents.year?.description)! + "-" +  (month.count == 1 ? "0\(month)":month) + "-" +  (day.count == 1 ? "0\(day) ":"\(day) ") + (hour.count == 1 ? "0\(hour)":hour) + ":" +  (min.count == 1 ? "0\(min)":min) + ":" +  (secound.count == 1 ? "0\(secound)":secound)
            return rideTime
        case .yearOrDay:
            let rideTime = (dateComponents.year?.description)! + "-" +  (month.count == 1 ? "0\(month)":month) + "-" +  (day.count == 1 ? "0\(day)":day)
            return rideTime
        case .yearOrMonth:
            let rideTime = (dateComponents.year?.description)! + "-" +  (month.count == 1 ? "0\(month)":month)
            return rideTime
        case .year:
            let rideTime = (dateComponents.year?.description)!
            return rideTime
        }
    }
}
