//
//  McMcTabBarViewController.m
//  MCMCDouTuArtifact
//
//  Created by 赵其龙 on 2021/7/22.
//

#import "McMcTabBarViewController.h"
#import "Header.h"
//#import "McMcTemplateViewController.h"
//#import "McMcEmoticonViewController.h"
//#import "McMcGIFMakeViewController.h"
//#import "McMcHeaderImageViewController.h"
//#import "McMcCuttingViewController.h"
//#import "McMcQRCodeViewController.h"
//#import "McMcHeaderMakeViewController.h"
//#import "McMcExpressionViewController.h"
//#import "McMcPublishViewController.h"

@interface McMcTabBarViewController ()

@property(assign , nonatomic) NSInteger centerPlace;
/** Whether center button to bulge */
@property(assign , nonatomic,getter=is_bulge) BOOL bulge;
/** items */
@property (nonatomic,strong) NSMutableArray <UITabBarItem *>*items;

@end

@implementation McMcTabBarViewController{int tabBarItemTag;BOOL firstInit;}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.centerPlace = -1;
}

/**
 *  Initialize selected
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!firstInit)
    {
        firstInit = YES;
//        if (self.centerPlace != -1 && self.items[self.centerPlace].tag != -1){
//            self.selectedIndex = self.centerPlace;
//        }else{
//            self.selectedIndex = 0;
//        }
        self.selectedIndex = 0;
        [self.tabbar setValue:[NSNumber numberWithInteger:self.selectedIndex] forKey:@"selectButtoIndex"];
    }
    
    //重新布局
    CGFloat h = 0;
    UIEdgeInsets insets = [[[[UIApplication sharedApplication] delegate] window] safeAreaInsets];
    if (insets.bottom > 0) {
        h = insets.bottom;
    }
    
    _tabbar.frame = CGRectMake(0,UIScreen.mainScreen.bounds.size.height - self.tabbar.frame.size.height - h ,self.tabbar.frame.size.width, self.tabbar.frame.size.height);;
}

/**
 *  Add other button for child’s controller
 */
- (void)addChildController:(id)Controller title:(NSString *)title nameImage:(UIImage *)nameImage selectedImage:(UIImage *)selectedImage{
    UIViewController *vc = [self findViewControllerWithobject:Controller];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = nameImage;
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.tag = tabBarItemTag++;
    [self.items addObject:vc.tabBarItem];
    [self addChildViewController:Controller];
}

/**
 *  Add center button
 */
- (void)addCenterController:(id)Controller bulge:(BOOL)bulge title:(NSString *)title nameImage:(UIImage *)nameImage selectedImage:(UIImage *)selectedImage{
    _bulge = bulge;
    if (Controller) {
        [self addChildController:Controller title:title nameImage:nameImage selectedImage:selectedImage];
        self.centerPlace = tabBarItemTag-1;
    }else{
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title
                                                          image:nameImage
                                                  selectedImage:selectedImage];
        item.tag = -1;
        [self.items addObject:item];
        self.centerPlace = tabBarItemTag;
    }
}




/**
 *  Add center button swift
 */
- (void)addCenterController_swift:(id)Controller bulge:(BOOL)bulge title:(NSString *)title nameImage:(UIImage *)nameImage selectedImage:(UIImage *)selectedImage{
    _bulge = bulge;
    if (Controller) {
        [self addChildController:Controller title:title nameImage:nameImage selectedImage:selectedImage];
        self.centerPlace = tabBarItemTag-1;
    }else{
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title
                                                          image:nameImage
                                                  selectedImage:selectedImage];
        item.tag = -1;
        [self.items addObject:item];
        self.centerPlace = tabBarItemTag;
    }
}


/**
 *  getter
 */
- (CustomTabBar *)tabbar{
    
    if (!_tabbar && self.items.count) {
        
        _tabbar = [[CustomTabBar alloc]initWithFrame:self.tabBar.frame];
        [_tabbar setValue:[NSNumber numberWithBool:self.bulge] forKey:@"bulge"];
        [_tabbar setValue:self forKey:@"controller"];
        [_tabbar setValue:[NSNumber numberWithInteger:self.centerPlace] forKey:@"centerPlace"];
        _tabbar.items = self.items;
        
        WeakSelf
        _tabbar.block = ^(NSInteger tag) {
            [weakSelf jumpVC:tag];
        };
        
        //remove tabBar
        for (UIView *loop in self.tabBar.subviews) {
            [loop removeFromSuperview];
        }
        self.tabBar.hidden = YES;
        
        [_tabbar setTextColor: [UIColor grayColor]];
        [_tabbar setSelectedTextColor:_selectedTextColor];
        [self.tabBar removeFromSuperview];
    }
    return _tabbar;
}


- (void)setSelectedTextColor:(UIColor *)selectedTextColor{
    _selectedTextColor = selectedTextColor;
    [_tabbar setTextColor: [UIColor grayColor]];
    [_tabbar setSelectedTextColor:_selectedTextColor];
}

- (NSMutableArray <UITabBarItem *>*)items{
    if(!_items){
        _items = [NSMutableArray array];
    }
    return _items;
}

#pragma -mark  制作跳转
-(void)jumpVC:(NSInteger) tag{
    
//    UIStoryboard *sb = KSTORYBOARD(@"MakeSD")
//    if (tag == 0) {
//        //模版制作
//        McMcTemplateViewController *vc = [sb instantiateViewControllerWithIdentifier:@"McMcTemplateVC"];
//        [self.navigationController pushViewController:vc animated:true];
//    }else if (tag == 1) {
//        //表情制作
//        McMcExpressionViewController *vc = [sb instantiateViewControllerWithIdentifier:@"McMcExpressionVC"];
//        [self.navigationController pushViewController:vc animated:true];
//    }else if (tag == 2) {
//        //Gif制作
//        McMcGIFMakeViewController *vc = [sb instantiateViewControllerWithIdentifier:@"McMcGIFMakeVC"];
//        [self.navigationController pushViewController:vc animated:true];
//    }else if (tag == 3) {
//        //头像制作
//        McMcHeaderMakeViewController *vc = [sb instantiateViewControllerWithIdentifier:@"McMcHeaderMakeVC"];
//        [self.navigationController pushViewController:vc animated:true];
//    }else if (tag == 4) {
//        //九宫格制作
//        McMcCuttingViewController *vc = [sb instantiateViewControllerWithIdentifier:@"McMcCuttingVC"];
//        [self.navigationController pushViewController:vc animated:true];
//    }else if (tag == 5) {
//        //二维码制作
//        McMcQRCodeViewController *vc = [sb instantiateViewControllerWithIdentifier:@"McMcQRCodeVC"];
//        [self.navigationController pushViewController:vc animated:true];
//    }else if (tag == 6) {
//        //二维码制作
//        McMcPublishViewController *vc = [sb instantiateViewControllerWithIdentifier:@"McMcPublishVC"];
//        [self.navigationController pushViewController:vc animated:true];
//    }
}


/**
 *  Update current select controller
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    if (selectedIndex >= self.viewControllers.count){
        @throw [NSException exceptionWithName:@"selectedTabbarError"
                                       reason:@"Don't have the controller can be used, index beyond the viewControllers."
                                     userInfo:nil];
    }
    [super setSelectedIndex:selectedIndex];
    UIViewController *viewController = [self findViewControllerWithobject:self.viewControllers[selectedIndex]];
    [self.tabbar removeFromSuperview];
    [viewController.view addSubview:self.tabbar];
    [self.tabbar setSelectButtoIndex:self.selectedIndex];

}



/**
 *  Catch viewController
 */
- (UIViewController *)findViewControllerWithobject:(id)object{
    while ([object isKindOfClass:[UITabBarController class]] || [object isKindOfClass:[UINavigationController class]]){
        object = ((UITabBarController *)object).viewControllers.firstObject;
    }
    return object;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
