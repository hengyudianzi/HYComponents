//
//  BMKText.h
//  MapComponent
//
//  Created by zhangbaojin on 2022/3/3.
//  Copyright © 2022 Baidu. All rights reserved.
//

#import "BMKShape.h"
#import "BMKOverlay.h"

NS_ASSUME_NONNULL_BEGIN

/// 文字覆盖物 since 6.5.2
@interface BMKText : BMKShape <BMKOverlay> {
@package
    CLLocationCoordinate2D _coordinate;
    BMKMapRect _boundingMapRect;
}

/// 文字覆盖物中心点坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

/// 文字覆盖物文字内容
@property (nonatomic, copy) NSString *text;

/// 根据中心点和文本生成文字覆盖物
/// @param coord 文字覆盖物的地理坐标
/// @param text 文字覆盖物文字内容
+ (nullable instancetype)textWithCenterCoordinate:(CLLocationCoordinate2D)coord
                                             text:(NSString *)text;

/// 设置文字覆盖物中心点和文本内容
/// @param coord 字覆盖物的地理坐标
/// @param text 文字覆盖物文字内容
/// @return 是否设置成功
- (BOOL)setCircleWithCenterCoordinate:(CLLocationCoordinate2D)coord
                                 text:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
