//
//  InfoConfig.swift
//  Alamofire
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation
import CLToast

//应用的AppID
public var APPID = "1633787567"

//获取当前版本号
public let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
public let displayName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
public let KWindow = UIApplication.shared.windows.first

//屏幕大小
public let KScreenSize: CGSize = UIScreen.main.bounds.size
//屏幕宽度
public let KScreenWidth: CGFloat = KScreenSize.width
//屏幕高度
public let KScreenHeight: CGFloat = KScreenSize.height
//navai 高度
public let KNavigationBarHeight: CGFloat = 44

/** -------    公共方法 -------- **/
/*
 * 获取本地存储 数据
 */
public func getUserDefaultsCF(_ key:String) -> Any? {
    return UserDefaults.standard.value(forKey: key)
}


/*
 * 保存本地存储 数据
 */
public func saveUserDefaultsCF(_ key:String, _ value:Any) {
    UserDefaults.standard.setValue(value, forKey: key)
}

/*
 *  删除本地存储 数据
 */
public func removeUserDefaultsCF(_ key:String) {
    UserDefaults.standard.removeObject(forKey: key)
}

/*
 * 打印语句
    - message: 打印内容
    - file: 文件描述
    - method: 方法描述
    - line: 行数
*/
public func printLog<T>(message:T,
                 file:String = #file,
                 method:String = #function,
                 line:Int = #line) {
    #if DEBUG
        print("\(file as NSString).lastPathComponent[\(line))],\(method),\(message)")
    #endif
}


/*
 * 是否登录状态
 */
public func isLoginCF() -> Bool {
    let token = getUserDefaultsCF("token") as? String ?? ""
    return token == "" ? false:true
}


/*
 * 应用中 吐司的现实
 */
public func showToast(_ text:String) {
    CLToast.cl_show(msg: text)
}

/*
 * 获取手机的uuid
 */
public func getDeviceUUid() -> String{
    let uuid = UIDevice.current.identifierForVendor!.uuidString
    return uuid;
}

