//
//  AppDelegate.swift
//  HYComponents
//
//  Created by hengyudianzi on 08/29/2022.
//  Copyright (c) 2022 hengyudianzi. All rights reserved.
//

import UIKit
import HYComponents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let channel = McMcTabBarViewController()
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "viewVC")
        channel.addChildController(vc1,
                                   title : "首页",
                                   nameImage : UIImage(named: "tabbar_1_no")!,
                                   selectedImage : UIImage(named: "tabbar_1_yes")!)
        
        
        let Channel2VC = sb.instantiateViewController(withIdentifier: "Channel2VC")
        
        channel.addChildController(Channel2VC,
                                   title : "搜公交",
                                   nameImage : UIImage(named: "tabbar_2_no")!,
                                   selectedImage : UIImage(named: "tabbar_2_yes")!)
        
//        channel.addChildController(CFCustomizedBusVC,
//                                   title : "定制公交",
//                                   imageName : "tabbar_3_no",
//                                   selectedImageName : "tabbar_3_yes")
//
//        channel.addChildController(CFMyVC,
//                                   title : "我的",
//                                   imageName : "tabbar_4_no",
//                                   selectedImageName : "tabbar_4_yes")

//        channel.addCenter(CFCloudBusVC,
//                          bulge :true,
//                          title : "云公交",
//                          imageName : "tabbar_center",
//                          selectedImageName : "tabbar_center")
        
        channel.modalPresentationStyle = .overFullScreen
        channel.selectedIndex = 0
        channel.selectedTextColor = UIColor(hexString: navigation_BKColor)
        
        let nav = CFBaseNavViewController(rootViewController: channel)
        self.window?.rootViewController = nav
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

