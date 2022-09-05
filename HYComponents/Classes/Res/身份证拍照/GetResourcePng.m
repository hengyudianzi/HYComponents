//
//  GetResourcePng.m
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

#import "GetResourcePng.h"

@implementation GetResourcePng


+(UIImage *)getBundleImageWithName:(NSString *)name{
    
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSDictionary *dic = currentBundle.infoDictionary;
    NSString *bundleName = [dic objectForKey:@"CFBundleExecutable"];
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%@@%zdx", name,scale];
//    NSString *bundleNamePath = @"Bundle.bundle";//
    NSString *bundleNamePath = [NSString stringWithFormat:@"%@.bundle", bundleName];

    //路径
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",bundleNamePath]];
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *imge = [UIImage imageNamed:imageName inBundle:resource_bundle withConfiguration:nil];
    return  imge;
}

+(NSBundle *)getCFBundle{
    
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSDictionary *dic = currentBundle.infoDictionary;
    NSString *bundleName = [dic objectForKey:@"CFBundleExecutable"];
//    NSString *bundleNamePath = @"ImagesRes.bundle";//[NSString stringWithFormat:@"%@.bundle", bundleName];
    NSString *bundleNamePath = [NSString stringWithFormat:@"%@.bundle", bundleName];


    //路径
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",bundleNamePath]];
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    
//    [resource_bundle loadNibNamed:@"CFTicketCalendarView.xib" owner:nil options:nil];
//    NSObject *obj = [resource_bundle loadNibNamed:@"CFTicketCalendarView" owner:nil options:nil].firstObject;
//    NSLog(@"%@",obj.class);
    return  resource_bundle;
}

+(NSBundle *)getCFBundle_New{
    
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"HYComponents" ofType:@"bundle"];
    NSLog(@"bundlePath --- :%@",bundlePath);
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    return  resource_bundle;
}


+(UIImage *)getBundleImg:(NSString *)imageName{
    
    NSBundle *resource_bundle = [self getCFBundle_New];
    UIImage *imge = [UIImage imageNamed:imageName inBundle:resource_bundle withConfiguration:nil];
    if (imge == nil) {
        imge = [UIImage imageNamed:imageName];
    }
    return  imge;
}

@end
