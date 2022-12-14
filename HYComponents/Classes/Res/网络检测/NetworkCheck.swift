//
//  NetworkCheck.swift
//  Smartbus_ChiFeng
//
//  Created by ð² on 2022/5/16.
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
            statusStr = "æªè¯å«çç½ç»"
            showToast(statusStr ?? "")
            UserDefaults.standard.removeObject(forKey: "isFrist")
            break
        case .notReachable:
            statusStr = "ä¸å¯ç¨çç½ç»(æªè¿æ¥)"
            showToast(statusStr ?? "")
            
            UserDefaults.standard.removeObject(forKey: "isFrist")
        case .reachable:
            if (manager?.isReachableOnWWAN)! {
                statusStr = "2G,3G,4G...çç½ç»"
            } else if (manager?.isReachableOnEthernetOrWiFi)! {
                statusStr = "wifiçç½ç»";
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
