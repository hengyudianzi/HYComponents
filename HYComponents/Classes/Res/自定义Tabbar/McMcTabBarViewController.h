//
//  McMcTabBarViewController.h
//  MCMCDouTuArtifact
//
//  Created by 赵其龙 on 2021/7/22.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"


NS_ASSUME_NONNULL_BEGIN

@interface McMcTabBarViewController : UITabBarController

/** 自定义的tabbar */
@property (strong , nonatomic) CustomTabBar* tabbar;

/** 设置选中颜色 */
@property (strong , nonatomic) UIColor *selectedTextColor;

/**
 * 添加子控制器
 * @param Controller          需管理的子控制器
 * @param title               底部文字
 * @param nameImage           未选中的图片名
 * @param selectedImage   选中的图片名
 */
- (void)addChildController:(id)Controller title:(NSString *)title nameImage:(UIImage *)nameImage selectedImage:(UIImage *)selectedImage;

/**
 * 设置中间按钮
 * @param Controller          需管理的子控制器
 * @param title               底部文字
 * @param nameImage           未选中的图片名
 * @param selectedImage   选中的图片名
 */
- (void)addCenterController:(id)Controller
                      bulge:(BOOL)bulge
                     title:(NSString *)title
                 imageName:(NSString *)imageName
         selectedImageName:(NSString *)selectedImageName;

/**
 *  Add center button swift
 */
- (void)addCenterController:(id)Controller bulge:(BOOL)bulge title:(NSString *)title nameImage:(UIImage *)nameImage selectedImage:(UIImage *)selectedImage;

@end

NS_ASSUME_NONNULL_END
