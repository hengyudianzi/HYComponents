//
//  Header.h
//  Pods
//
//  Created by 🐲 on 2022/8/29.
//

#ifndef Header_h
#define Header_h

//#import "Masonry.h"

#define WeakSelf __weak typeof(self) weakSelf = self;
#define Color(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define bl [[UIScreen mainScreen]bounds].size.width/375
#define KW  (MIN([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width))
#define KH  ([UIScreen mainScreen].bounds.size.height)

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <BMKLocationkit/BMKLocationComponent.h>


#endif /* Header_h */
