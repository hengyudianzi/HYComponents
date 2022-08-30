//
//  GetResourcePng.h
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetResourcePng : NSObject

+(UIImage *)getBundleImageWithName:(NSString *)name;

+(NSBundle *)getCFBundle;

@end

NS_ASSUME_NONNULL_END
