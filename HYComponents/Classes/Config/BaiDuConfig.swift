//
//  BaiDuConfig.swift
//  HYComponents
//
//  Created by 🐲 on 2022/9/6.
//

import Foundation

//初始化。百度地图
public func initBMKMapManager(_ key:String) -> Bool{
    
    BMKMapManager.setAgreePrivacy(true)
    BMKLocationAuth.sharedInstance()?.setAgreePrivacy(true)
    let mapManager = BMKMapManager()
    let ret = mapManager.start(key, generalDelegate: nil)
    if (!ret) {
        print("manager start failed!")
    }
    return ret
}
