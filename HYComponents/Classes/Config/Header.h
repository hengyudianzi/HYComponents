//
//  Header.h
//  Pods
//
//  Created by ð² on 2022/8/29.
//

#ifndef Header_h
#define Header_h

//#import "Masonry.h"

#define WeakSelf __weak typeof(self) weakSelf = self;
#define Color(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define bl [[UIScreen mainScreen]bounds].size.width/375
#define KW  (MIN([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width))
#define KH  ([UIScreen mainScreen].bounds.size.height)

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//å¼å¥baseç¸å³ææçå¤´æä»¶
#import <BaiduMapAPI_Map/BMKMapComponent.h>//å¼å¥å°å¾åè½ææçå¤´æä»¶
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//å¼å¥æ£ç´¢åè½ææçå¤´æä»¶
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//å¼å¥è®¡ç®å·¥å·ææçå¤´æä»¶
#import <BaiduMapAPI_Map/BMKMapView.h>//åªå¼å¥æéçåä¸ªå¤´æä»¶
#import <BMKLocationkit/BMKLocationComponent.h>


#endif /* Header_h */
