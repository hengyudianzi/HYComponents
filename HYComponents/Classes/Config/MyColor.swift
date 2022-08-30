//
//  MyColor.swift
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation


class MyColor: UIColor {
    
    static let lightBlueMColor = UIColor.colorWithHexString("#f9f9f9")
    static let ICColor = UIColor.colorWithHexString("#1576fe")
    static let MColor = UIColor.colorWithHexString("#006EF9")
    static let MGradColor = UIColor.init(red: 120/255, green: 180/255, blue: 250/255, alpha: 1)
    static let MTextColor = UIColor.colorWithHexString("#000000")
    static let NVBTintColor = UIColor.colorWithHexString("#006EF9")
    
    static let TTextColor = UIColor.colorWithHexString("#000000")
    static let GrayTextColor = UIColor.colorWithHexString("#888888")
    static let LineColor = UIColor.colorWithHexString("#e1e1e1")
    static let LightLineColor = UIColor.colorWithHexString("#e9e9e9")
    static let BTGDGrayColor = UIColor.colorWithHexString("#f5f5f5")
    
    static let color_green_dot = UIColor.colorWithHexString("#7ec32b")
    static let color_red_dot = UIColor.colorWithHexString("#ff6d4f")
    static let color_gray_placeholder = UIColor.colorWithHexString("#ccccd1")
    static let color_gray_line = UIColor.colorWithHexString("#e8e8e8")
    static let color_gray_bg = UIColor.colorWithHexString("#f9f9f9")
    static let color_gray_text = UIColor.colorWithHexString("#808080")
     static let color_gray_dark_text = UIColor.colorWithHexString("#7d7d7d")
     static let color_yellow_bg = UIColor.colorWithHexString("#f6a726")
    
    static let BGColor = UIColor.groupTableViewBackground
    static let color_4799e9 = colorWithHexString("#4799e9")
    static let color_a9a9a9 = colorWithHexString("#a9a9a9")
    //车票状态颜色
    static let color_ticketStatus_daichuxing = UIColor.colorWithHexString("#0380dc")//待出行
    static let color_ticketStatus_chuxingzhong = UIColor.colorWithHexString("#70bc14")//出行中
    static let color_ticketStatus_guoqi = UIColor.colorWithHexString("#c4c4c4")//已过期
    static let color_ticketStatus_yanpiao = UIColor.colorWithHexString("#818181")//已验票
    static let color_ticketStatus_daishenhe = UIColor.colorWithHexString("#ff8800")//退款待审核
    static let color_ticketStatus_tuikuanzhong = UIColor.colorWithHexString("#ffbb33")//退款中
    static let color_ticketStatus_yituikuan = UIColor.colorWithHexString("#000000")//已退款
    static let color_ticketStatus_tuikuanshibai = UIColor.red//退款失败
}

extension UIColor{
    
    static func colorWithHexString (_ hex: String) -> UIColor {
        
        
        var cString: NSString = (hex as NSString).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1) as NSString
        }
        
        if (cString.length != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}
