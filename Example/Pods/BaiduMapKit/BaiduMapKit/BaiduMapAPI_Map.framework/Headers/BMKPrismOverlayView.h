//
//  BMKPrismOverlayView.h
//  MapComponent
//
//  Created by zhangbaojin on 2021/4/19.
//  Copyright © 2021 Baidu. All rights reserved.
//

#import "BMKOverlayGLBasicView.h"
#import "BMKPrismOverlay.h"

@class BMKPrismOverlayView;

NS_ASSUME_NONNULL_BEGIN

/// 此类用于定义一个3D棱柱View since 6.4.0
@interface BMKPrismOverlayView : BMKOverlayGLBasicView

/// 根据指定的3D棱柱生成一个3D棱柱View
/// @param prismOverlay 指定的3D棱柱数据对象
/// @return 新生成的多边形View
- (nullable instancetype)initWithPrismOverlay:(BMKPrismOverlay *)prismOverlay;

/// 该View对应的3D棱柱数据对象
@property (nonatomic, readonly) BMKPrismOverlay *prismOverlay;

/// 3D棱柱顶面颜色
@property (nonatomic, strong) UIColor *topFaceColor;

/// 3D棱柱侧面颜色
@property (nonatomic, strong) UIColor *sideFaceColor;

/// 3D棱柱侧面纹理
@property (nonatomic, strong) UIImage *sideTextureImage;

/// 是否开启生长动画(仅对建筑物生效)，默认YES
@property (nonatomic, assign) BOOL isGrowthAnimation;

/// 建筑物显示层级(仅对建筑物生效), 默认18
@property (nonatomic, assign) int showLevel;

@end

NS_ASSUME_NONNULL_END
