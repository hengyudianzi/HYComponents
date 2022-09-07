//
//  BMKMapGestureDelegate.h
//  MapComponent
//
//  Created by zhaoxiangru on 2022/1/29.
//  Copyright © 2022 Baidu. All rights reserved.
//
#ifndef __BMKMapGestureDelegate_H__
#define __BMKMapGestureDelegate_H__
#import <Foundation/Foundation.h>

@class BMKMapView;
@class BMKMapStatus;
@class BMKForceTouchGestureRecognizer;
@class BMKFlyingGestureRecognizer;
/**
 地图手势代理回调方法
 */
@protocol BMKMapGestureDelegate <NSObject>
@optional
#pragma mark - Gesture action selector 回调
/// 单击手势处理回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param gesture 当前手势对象
- (BOOL)handleTapGesture:(UITapGestureRecognizer *)gesture;

/// 拖拽手势处理回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param gesture 当前手势对象
/// 注意：pan手势被拦截时filing手势会同时被拦截
- (BOOL)handlePanGesture:(UIPanGestureRecognizer *)gesture;

/// 快速滑动手势处理回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param gesture 当前手势对象
- (BOOL)handleFlyingGesture:(BMKFlyingGestureRecognizer *)gesture;

/// 长按手势处理回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param gesture 当前手势对象
- (BOOL)handleLongGesture:(UILongPressGestureRecognizer *)gesture;

/// 单指双击手势处理回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param gesture 当前手势对象
- (BOOL)handleDoubleTapGesture:(UITapGestureRecognizer *)gesture;


/// 双指点击手势处理回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param gesture 当前手势对象
- (BOOL)handleTwoFingersTapGesture:(UITapGestureRecognizer *)gesture;

/// 双指滑动手势处理回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param gesture 当前手势对象
- (BOOL)handleTwoFingersPanGesture:(UIPanGestureRecognizer *)gesture;

/// 旋转手势处理回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param gesture 当前手势对象
- (BOOL)handleRotationGesture:(UIRotationGestureRecognizer *)gesture;

/// 捏合手势处理回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param gesture 当前手势对象
- (BOOL)handlePinchGesture:(UIPinchGestureRecognizer *)gesture;

#pragma mark - 以下为手势自定义方法回调，内部优先响应Gesture action selector 回调
/// 单指手势开始时回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param touchPoint 单指手势开始时手指位置
/// @param mapSatus 当前地图状态
- (BOOL)beginTouchPoint:(CGPoint)touchPoint mapSatus:(BMKMapStatus *)mapSatus;

/// 单指手势移动时回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param touchPoint 单指手势移动时手指位置
/// @param mapSatus 当前地图状态
- (BOOL)moveTouchPoint:(CGPoint)touchPoint mapSatus:(BMKMapStatus *)mapSatus;

/// 单指手势抬结束时回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param touchPoint 单指手势结束时手指位置
/// @param mapSatus 当前地图状态
- (BOOL)endTouchPoint:(CGPoint)touchPoint mapSatus:(BMKMapStatus *)mapSatus;

/// 双指手势开始回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param touchPoint 手指1位置
/// @param otherTouchPoint 手指2位置
/// @param mapSatus 当前地图状态
- (BOOL)twoFingersBeginTouchPoint:(CGPoint)touchPoint otherTouchPoint:(CGPoint)otherTouchPoint mapSatus:(BMKMapStatus *)mapSatus;

/// 双指手势移动时回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param touchPoint 手指1位置
/// @param otherTouchPoint 手指2位置
/// @param mapSatus 当前地图状态
- (BOOL)twoFingersMoveTouchPoint:(CGPoint)touchPoint otherTouchPoint:(CGPoint)otherTouchPoint mapSatus:(BMKMapStatus *)mapSatus;

/// 双指手势结束回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param touchPoint 手指1位置
/// @param otherTouchPoint 手指2位置
/// @param mapSatus 当前地图状态
- (BOOL)twoFingersEndTouchPoint:(CGPoint)touchPoint otherTouchPoint:(CGPoint)otherTouchPoint mapSatus:(BMKMapStatus *)mapSatus;

/// 单指双击放大回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param tapPoint 手指位置
/// @param mapSatus 当前地图状态
- (BOOL)doubleTap:(CGPoint)tapPoint mapSatus:(BMKMapStatus *)mapSatus;

/// 双指点击缩小回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param tapPoint 手指1位置
/// @param otherTapPoint 手指2位置
/// @param mapSatus 当前地图状态
- (BOOL)twoFingerTap:(CGPoint)tapPoint otherTapPoint:(CGPoint)otherTapPoint mapSatus:(BMKMapStatus *)mapSatus;

/// 单指快速滑动过程回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param tapPoint 手指位置
/// @param speed 手指离开时速度
/// @param mapSatus 当前地图状态
- (BOOL)onMapFlyingWithEndTapPoint:(CGPoint)tapPoint speed:(CGPoint)speed mapSatus:(BMKMapStatus *)mapSatus;

/// 双指平移过程回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param tapPoint 手指1位置
/// @param otherTapPoint 手指2位置
/// @param overLook 俯瞰角变化的角度
/// @param mapSatus 当前地图状态
- (BOOL)onMapOverlookWithTapPoint:(CGPoint)tapPoint otherTapPoint:(CGPoint)otherTapPoint overLook:(int)overLook mapSatus:(BMKMapStatus *)mapSatus;

/// 双指旋转过程回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param tapPoint 手指1位置
/// @param otherTapPoint 手指2位置
/// @param roate 旋转变化角度
/// @param mapSatus 当前地图状态
- (BOOL)onMapRoateWithTapPoint:(CGPoint)tapPoint otherTapPoint:(CGPoint)otherTapPoint route:(int)roate mapSatus:(BMKMapStatus *)mapSatus;

/// 双指缩放过程回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param tapPoint 手指1位置
/// @param otherTapPoint 手指2位置
/// @param scale 缩放变化比例
/// @param mapSatus 当前地图状态
- (BOOL)onMapScaleWithTapPoint:(CGPoint)tapPoint otherTapPoint:(CGPoint)otherTapPoint scale:(float)scale mapSatus:(BMKMapStatus *)mapSatus;


/// 双指缩放结束延迟动画回调，返回YES时为外部拦截该手势操作，内部将不做其他处理
/// @param tapPoint 手指1位置
/// @param otherTapPoint 手指2位置
/// @param scale 缩放变化比例
/// @param mapSatus 当前地图状态
- (BOOL)onMapEndScaleTapPoint:(CGPoint)tapPoint otherTapPoint:(CGPoint)otherTapPoint scale:(float)scale mapSatus:(BMKMapStatus *)mapSatus;
@end
#endif /* __BMKMapGestureDelegate_H__ */
