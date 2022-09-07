/*
 *  BMKMapStatus.h
 *  BMapKit
 *
 *  Copyright 2011 Baidu Inc. All rights reserved.
 *
 */

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#ifdef USE_NAVI
#import <BaiduMapAPI_Base_Navi/BMKTypes.h>
#else
#import <BaiduMapAPI_Base/BMKTypes.h>
#endif

/// 此类表示地图状态信息
@interface BMKMapStatus : NSObject
/// 缩放级别:[4~21]
@property (nonatomic, assign) float fLevel;
/// 旋转角度
@property (nonatomic, assign) float fRotation;
/// 俯视角度:[-79~0]
@property (nonatomic, assign) float fOverlooking;
/// 屏幕中心点坐标:在屏幕内，超过无效
@property (nonatomic, assign) CGPoint targetScreenPt;
/// 地理中心点坐标:经纬度
@property (nonatomic, assign) CLLocationCoordinate2D targetGeoPt;
/// 当前地图范围，采用直角坐标系表示，向右向下增长
@property (nonatomic, assign, readonly) BMKMapRect visibleMapRect;

@end



