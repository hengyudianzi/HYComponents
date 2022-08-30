//
//  CFVersionAlert.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/5/13.
//

import Foundation

public class CFVersionAlert:NSObject{
    
    public static func loadVersion(_ vc:UIViewController,_ version:String,_ isShowAlert:Bool = false)  {
        
        let strUrl = "http://itunes.apple.com/cn/lookup?id=" + APPID
        let oldNum = version.replacingOccurrences(of: ".", with: "")

        // 构建URL
        guard let url = URL(string: strUrl) else { return }
        
        // 构建请求request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            data, response, error in
            guard let data = data, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            let dataString = String(data: data, encoding: String.Encoding.utf8)
            let dict = CFVersionAlert.getDictionaryFromJSONString(jsonString: dataString!)
            print(dict)
            
            let list = dict.object(forKey: "results") as? [[String:Any]] ?? []
            
            guard list.count > 0 else {
                return
            }
            if let dic: Dictionary<String, Any>  = list.first{
                let url = dic["trackViewUrl"] as? String ?? ""
                let version = dic["version"]  as? String ?? ""

                guard url != "" && version != "" else {
                    return
                }


                let newNum = version.replacingOccurrences(of: ".", with: "")
                if newNum > oldNum {
                    self.showUpdateAlertView(vc, url, version)
                }else{
                    if isShowAlert {
                        showToast("已是最新版本！")
                    }
                }
            }
            
        }
        task.resume()
    }
    
    static func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    
    static func showUpdateAlertView(_ vc:UIViewController,_ url:String, _ version:String)  {
       
        if currentVersion == version {
            //
            saveUserDefaultsCF("newVersion", "")
        }else{
            saveUserDefaultsCF("newVersion", version)
        }
        
        let msg = "发现新版本" + version + "是否更新"
        let alertController = UIAlertController.init(title: "更新", message: msg, preferredStyle: UIAlertController.Style.alert)
        let confirmAction = UIAlertAction.init(title: "更新", style: UIAlertAction.Style.default) { (action) in
            
            guard let urls = URL(string: url) else {
                return
            }
            
            UIApplication.shared.openURL(urls)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            vc.present(alertController, animated: true, completion:  nil)
        }
    }
    
    
}
