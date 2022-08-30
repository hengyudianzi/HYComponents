//
//  CFBaseViewController.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/3/30.
//

import UIKit
import CoreLocation

var manager:CLLocationManager?

public class CFBaseViewController: UIViewController {

    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
//        UIApplication.shared.statusBarStyle = statusBarStyle

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
//        showEventsAcessDeniedAlert()

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle{
        return statusBarStyle
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CFBaseViewController{
    
  
    //主动请求定位权限 让用户进行授权
    public func showEventsAcessDeniedAlert() -> Bool{
        print(CLLocationManager.authorizationStatus())
        
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            //表示用户拒绝该应用使用定位服务
            showAlert()
            return false
        case .authorizedAlways:
            //表示用户授权该应用可永久使用定位权限
//            start()
            break
//        case .authorized:
//            start()
//            break
        case .authorizedWhenInUse:
            //表示用户授权该应用或其功能在屏幕上显示时才能访问用户的位置
//            start()
            break
        case .notDetermined,.authorized:
            //表示用户还未对该应用的定位权限做出选择
//            showAlert()
            manager = CLLocationManager.init()
            manager?.requestWhenInUseAuthorization()
            manager?.requestAlwaysAuthorization()
            manager?.startUpdatingLocation()
            return false
        case .restricted:
            //表示GPS功能受限於某些限制,无法使用定位服务
            showAlert()
            return false
        default:
            break
        }
        
        return true
   }
    
    /*
     *如果未授权 - 就弹框提示 点击设置 跳转手机进行设置
     */
    public func showAlert(){
        
        let alertController = UIAlertController(title: "此应用暂未开启开定位，不能获取您的当前位置，无法进行对您周边站点的查询。是否打开定位权限？",
                                                message: "想打开定位权限,请进入 系统设置->隐私->定位服务中打开开关,并允许App使用定位服务(或者点击设置进行设置跳转)。",
                                                preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "设置", style: .default) { (alertAction) in
            if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(appSettings as URL)
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}


//MARK: - 跳转
extension UIViewController{
    
    //跳转 web页面
    public func jumpWebVC(_ title:String,_ path:String)  {
        
        guard path != "" else {
            showToast("跳转链接不可为空！")
            return
        }
        let channel = CFWebViewController(nibName: "CFWebViewController", bundle: nil)
        channel.title = title
        channel.path = path
        self.navigationController?.pushViewController(channel, animated: true)
    }
}
