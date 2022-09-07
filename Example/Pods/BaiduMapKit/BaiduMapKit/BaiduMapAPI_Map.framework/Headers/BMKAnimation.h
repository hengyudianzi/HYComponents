//
//  BMKAnimation.h
//  MapComponent
//
//  Created by zhaoxiangru on 2021/11/29.
//  Copyright © 2021 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger  {
    Linear, /// 线性
    InQuad, OutQuad, InOutQuad, OutInQuad,
    InCubic, OutCubic, InOutCubic, OutInCubic,
    InQuart, OutQuart, InOutQuart, OutInQuart,
    InQuint, OutQuint, InOutQuint, OutInQuint,
    InSine, OutSine, InOutSine, OutInSine,
    InExpo, OutExpo, InOutExpo, OutInExpo,
    InCirc, OutCirc, InOutCirc, OutInCirc,
    InElastic, OutElastic, InOutElastic, OutInElastic,
    InBack, OutBack, InOutBack, OutInBack,
    InBounce, OutBounce, InOutBounce, OutInBounce,
    InCurve, OutCurve, SineCurve, CosineCurve
} BMKAnimationType;

NS_ASSUME_NONNULL_BEGIN
/// 动画类
@interface BMKAnimation : NSObject
/// 设置动画总时长，默认为0ms，
@property (nonatomic, assign) int duration;
/// 动画缓动函数类型，默认0：线性
@property (nonatomic, assign) BMKAnimationType type;
@end

NS_ASSUME_NONNULL_END
