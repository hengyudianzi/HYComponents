/*
 *  BMKHeatMap.h
 *  BMapKit
 *
 *  Copyright 2013 Baidu Inc. All rights reserved.
 *
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#ifdef USE_NAVI
#import <BaiduMapAPI_Base_Navi/BMKTypes.h>
#else
#import <BaiduMapAPI_Base/BMKTypes.h>
#endif
#import "BMKGradient.h"
#import "BMKAnimation.h"

///热力图节点信息
@interface BMKHeatMapNode : NSObject

/// 点的强度权值,默认值1，范围[> 0]
@property (nonatomic, assign) double intensity;
/// 点的位置坐标
@property (nonatomic, assign) CLLocationCoordinate2D pt;

@end


@protocol BMKHeatMapDelegate <NSObject>
/// 获取正在展示的热力图数据帧索引
- (void)onHandleCurrentHeatMapFrameAnimationIndex:(NSInteger)index;

@end

/// 热力图的绘制数据和显示样式类
@interface BMKHeatMap : NSObject
/// 热力图代理方法，since 6.5.0
@property (nonatomic, assign) id<BMKHeatMapDelegate> delegate;
/// 设置热力图点半径，默认为12ps，范围[10~50]
@property (nonatomic, assign) int mRadius;
/// 设置3D热力图最大高度，默认为0ps，范围[0~200]，since 6.5.0
@property (nonatomic, assign) int mMaxHight;
/// 设置热力图最大权重值，默认为1.0，since 6.5.0
@property (nonatomic, assign) double mMaxIntensity;
/// 设置热力图最小权重值，默认为0.0，since 6.5.0
@property (nonatomic, assign) double mMinIntensity;
/// 设置热力图渐变，有默认值 DEFAULT_GRADIENT
@property (nonatomic, strong) BMKGradient *mGradient;
/// 设置热力图层透明度，默认 0.6，范围[0~1]
@property (nonatomic, assign) double mOpacity;

/// 用户传入的热力图数据mData和mDatas ，二选一，优先mDatas
/// 用户传入的热力图数据，数组，成员类型为BMKHeatMapNode
@property (nonatomic, copy) NSArray <BMKHeatMapNode *> *mData;
/// 用户传入的热力图数据，数组，成员类型为NSArray <BMKHeatMapNode *>，用于帧动画，since 6.5.0
@property (nonatomic, copy) NSArray <NSArray <BMKHeatMapNode *> *> *mDatas;

/// 设置第一次显示时的动画属性，默认为nil
@property (nonatomic, strong) BMKAnimation *animation;
/// 设置帧动画属性，默认为nil
@property (nonatomic, strong) BMKAnimation *frameAnimation;
@end



