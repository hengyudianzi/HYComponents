//
//  CFShareAllMap.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/5/1.
//

import Foundation
import MapKit

public class CFShareAllMap: NSObject {

    
    // MARK: 点击导航按钮
    public static func touchgoMap(_ vc:UIViewController,_ latitute:Double,_ longitute:Double, _ address:String) {
            let coortitle = address
//            let latitute = self.coordinate!.latitude
//            let longitute = self.coordinate!.longitude
            //        "请选择导航应用程序"
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            
            alert.addAction(UIAlertAction(title: "高德地图", style: .default, handler: { _ in
                self.amap(dlat: latitute, dlon: longitute, dname: coortitle, way: 0)
            }))
            
            
            alert.addAction(UIAlertAction(title: "百度地图", style: .default, handler: { _ in
                self.baidumap(endAddress: coortitle, way: "driving", lat: latitute,lng: longitute)
            }))
            
            
            alert.addAction(UIAlertAction(title: "腾讯地图", style: .default, handler: { _ in
                self.qqmap(endAddress: coortitle, way: "driving", lat: latitute,lng: longitute)
            }))
            
            alert.addAction(UIAlertAction(title: "Apple 地图", style: .default, handler: { _ in
                self.appleMap(lat:latitute , lng:longitute, destination: coortitle)
            }))
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            vc.present(alert, animated: true, completion: nil)
            
    }
    
    
    // 打开苹果地图
    public static func appleMap(lat:Double,lng:Double,destination:String) {
        
        let loc = CLLocationCoordinate2DMake(lat, lng)
        let currentLocation = MKMapItem.forCurrentLocation()
        let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:loc,addressDictionary:nil))
        toLocation.name = destination
        let boo =    MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: NSNumber(value: true)])
        print(boo)

    }
    
    // 打开高德地图
    public static func amap(dlat:Double,dlon:Double,dname:String,way:Int) {
        let appName = "枣庄公交"
        
        let urlString = "iosamap://path?sourceApplication=\(appName)&dname=\(dname)&dlat=\(dlat)&dlon=\(dlon)&t=\(way)" as String
        
        if self.openMap(urlString) == false {
            print("您还没有安装高德地图")
             let urlString = "itms-apps://itunes.apple.com/app/id452186370"
            self.openURL(urlString: urlString)

        }
    }
    
    // 打开腾讯地图
    public static  func qqmap(endAddress:String,way:String,lat:Double,lng:Double) {
           
           let urlString = "qqmap://map/routeplan?type=\(way)&from=&fromcoord=CurrentLocation&to=\(endAddress)&tocoord=\(lat),\(lng)&referer=腾讯需要申请APPkey"
           let str = urlString as String
           
           if self.openMap(str) == false {
               print("您还没有安装腾讯地图")
            let urlString = "itms-apps://itunes.apple.com/app/id481623196"
            self.openURL(urlString: urlString)
           }
       }
    
    // 打开百度地图
    public static func baidumap(endAddress:String,way:String,lat:Double,lng:Double) {
        
        let coordinate = CLLocationCoordinate2DMake(lat, lng)
        
        // 将高德的经纬度转为百度的经纬度
        let baiduCoordinate = getBaiDuCoordinateByGaoDeCoordinate(coordinate: coordinate)
        
        let destination = "\(baiduCoordinate.latitude),\(baiduCoordinate.longitude)"
        
        let urlString = "baidumap://map/direction?" + "&destination=" + endAddress + "&mode=" + way + "&destination=" + destination
        
        let str = urlString as String
        
        if self.openMap(str) == false {
            print("您还没有安装百度地图")
            let urlString = "itms-apps://itunes.apple.com/app/id452186370" as String
            self.openURL(urlString: urlString)
        }
    }
    
    // 打开第三方地图
    public static func openMap(_ urlString: String) -> Bool {

         let urlstr =   urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        guard let url = URL(string:urlstr) else {
            return false
        }
        if UIApplication.shared.canOpenURL(url) == true {
            self.openURL(urlString: urlString as String)
            return true
        } else {
            return false
        }
    }
    
    public static func openURL(urlString:String) {
        let urlstr =   urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        
        guard let url = URL(string:urlstr) else {
            return
        }
        //根据iOS系统版本，分别处理
        if #available(iOS 10, *) {
            UIApplication.shared.open(url , options: [:],
                                      completionHandler: { (success) in
                                        
                printLog(message: success)
            })
        } else {
            UIApplication.shared.openURL(url )
        }
    }
      
    // 高德经纬度转为百度地图经纬度
    // 百度经纬度转为高德经纬度，减掉相应的值就可以了。
    public static func getBaiDuCoordinateByGaoDeCoordinate(coordinate:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(coordinate.latitude + 0.006, coordinate.longitude + 0.0065)
    }

}
