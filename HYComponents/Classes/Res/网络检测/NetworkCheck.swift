//
//  NetworkCheck.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/5/16.
//

import Foundation
import Alamofire

public var ReloadNotificationName = "checkNetWorkReloadData"

public func checkNetwork() {
    
    let manager = NetworkReachabilityManager()
    
    manager?.listener = { status in
        var statusStr: String?
        switch status {
        case .unknown:
            statusStr = "未识别的网络"
            showToast(statusStr ?? "")
            UserDefaults.standard.removeObject(forKey: "isFrist")
            break
        case .notReachable:
            statusStr = "不可用的网络(未连接)"
            showToast(statusStr ?? "")
            
            UserDefaults.standard.removeObject(forKey: "isFrist")
        case .reachable:
            if (manager?.isReachableOnWWAN)! {
                statusStr = "2G,3G,4G...的网络"
            } else if (manager?.isReachableOnEthernetOrWiFi)! {
                statusStr = "wifi的网络";
            }
            
            if (getUserDefaultsCF("isFrist") == nil) {
                saveUserDefaultsCF("isFrist", "1")
                NotificationCenter.default.post(name: NSNotification.Name(ReloadNotificationName), object: nil)
            }
            break
        }
        printLog(message: statusStr ?? "")
    }
    manager?.startListening()
}
