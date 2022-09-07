//
//  BMKTextView.h
//  MapComponent
//
//  Created by zhangbaojin on 2022/3/3.
//  Copyright © 2022 Baidu. All rights reserved.
//

#import "BMKGeometryView.h"
#import "BMKText.h"

/// 文本绘制的字体类型 since 6.5.2
enum BMKTextFontType
{
    kBMKTextFontNormal = 0,        ///< 普通字体
    kBMKTextFontNormalBold,       ///< 普通字体加粗
    kBMKTextFontItalic,          ///< 斜体
    kBMKTextFontItalicBold      ///< 斜体加粗
};
typedef enum BMKTextFontType BMKTextFontType;

NS_ASSUME_NONNULL_BEGIN
/// 该类用于定义文字覆盖物对应的View since 6.5.2
@interface BMKTextView : BMKGeometryView

/// 根据指定文字覆盖物生成对应的View
/// @param textOverlay 指定的文字覆盖物
/// @return 生成的View
- (nullable instancetype)initWithTextOverlay:(BMKText *)textOverlay;

/// 该View对应的文字覆盖物
@property (nonatomic, readonly) BMKText *text;

/// 背景颜色
@property (nonatomic, strong) UIColor *backgroundColor;

/// 字体大小，默认：12
@property (nonatomic, assign) int fontSize;

/// 字体类型，默认：kBMKTextFontNormal
@property (nonatomic, assign) BMKTextFontType textFontType;

/// 字体颜色
@property (nonatomic, strong) UIColor *textColor;

/// 字符间距，默认：2.0f
@property (nonatomic, assign) CGFloat textParagraphSpacing;

/// 文字的最大行宽
@property (nonatomic, assign) int textMaxLineWidth;

/// 文字的行间距，默认：4.0f
@property (nonatomic, assign) CGFloat textLineSpacing;

/// 文字对齐方式，默认：NSTextAlignmentCenter
@property (nonatomic, assign) NSTextAlignment textAlignment;

/// 字符截断类型，默认：NSLineBreakByCharWrapping
@property (nonatomic, assign) NSLineBreakMode textLineBreakMode;
 
/// 文字最小显示层级， 默认4
@property (nonatomic, assign) int startLevel;

/// 文字最大显示层级，默认21
@property (nonatomic, assign) int endLevel;

/// 旋转角度，逆时针
@property (nonatomic, assign) float rotate;

@end

NS_ASSUME_NONNULL_END
