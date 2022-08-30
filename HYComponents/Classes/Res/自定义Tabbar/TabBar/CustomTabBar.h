//
//  CustomTabBar.h
//  MCMCDouTuArtifact
//
//  Created by 赵其龙 on 2021/7/22.
//

#import <UIKit/UIKit.h>

@class CYButton;
@class CYCenterButton;

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomTabBarBlock)(NSInteger tag);

@interface CustomTabBar : UIView

/** tabbar按钮显示信息 */
@property(copy, nonatomic) NSArray<UITabBarItem *> *items;
/** 设置文字颜色 */
@property (strong , nonatomic) UIColor *textColor;
/** 设置选中颜色 */
@property (strong , nonatomic) UIColor *selectedTextColor;
/** 其他按钮 */
@property (strong , nonatomic) NSMutableArray <CYButton*>*btnArr;
/** 中间按钮 */
@property (strong , nonatomic) CYCenterButton *centerBtn;

@property (copy, nonatomic) CustomTabBarBlock block;
 

- (void)setSelectButtoIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
