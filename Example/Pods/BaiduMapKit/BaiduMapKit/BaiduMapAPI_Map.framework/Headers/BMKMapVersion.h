//
//  BMKMapVersion.h
//  MapComponent
//
//  Created by wzy on 15/9/9.
//  Copyright © 2015年 baidu. All rights reserved.
//

#ifndef BMKMapVersion_h
#define BMKMapVersion_h

#import <UIKit/UIKit.h>

/**
 *重要：
 *map组件的版本和base组件的版本必须一致，否则不能正常使用
 */

/// 获取当前地图API map组件 的版本号
/// 返回当前API map组件 的版本号
UIKIT_EXTERN NSString *BMKGetMapApiMapComponentVersion(void);

/// 检查map组件的版本号是否和base组件的版本号一致
/// 版本号一致返回YES
UIKIT_EXTERN BOOL BMKCheckMapComponentIsLegal(void);

/// 获取当前地图审图号
/// 返回当前地图审图号
UIKIT_EXTERN NSString *BMKGetMapApprovalNumber(void);

/// 获取当前地图测绘资质
/// 返回当前地图测绘资质
UIKIT_EXTERN NSString *BMKGetMapMappingQualification(void);

/// 获取当前地图版权信息
/// 返回当前地图版权信息
UIKIT_EXTERN NSString *BMKGetMapCopyrightInformation(void);

#endif /* BMKMapVersion_h */
