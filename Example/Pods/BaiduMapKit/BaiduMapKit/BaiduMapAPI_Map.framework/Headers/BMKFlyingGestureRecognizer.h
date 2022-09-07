//
//  BMKFlyingGestureRecognizer.h
//  MapComponent
//
//  Created by Xin,Qi on 2018/11/8.
//  Copyright © 2018 Baidu. All rights reserved.
//
#ifndef __BMKFlyingGestureRecognizer_H__
#define __BMKFlyingGestureRecognizer_H__
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 轻扫手势，使用该手势地图会漂移
 */
@interface BMKFlyingGestureRecognizer : UIPanGestureRecognizer
/**
 最后手势停止点，外部计算用
 */
@property (nonatomic, readonly, assign) CGPoint endFlyingPoint;
/**
 最后手势的速度，外部计算用
 */
@property (nonatomic, readonly, assign) CGFloat speed;
/**
 手势结束后，重置参数
 */
- (void)resetParameters;
@end

NS_ASSUME_NONNULL_END
#endif /* __BMKFlyingGestureRecognizer_H__ */
