//
//  MobTechConfig.h
//  HYComponents
//
//  Created by 🐲 on 2022/9/6.
//

#import <Foundation/Foundation.h>

typedef void(^MobTechBlock)(NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface MobTechConfig : NSObject

//mob 权限问题
+(void)mob_QXConfig;

//权限 手机号
+(void)mob_SendPhoneCode:(NSString *)phoneNumber result:(MobTechBlock)result;

//检验验证码
+(void)mob_CheckPhoneCode:(NSString *)phoneNumber code:(NSString *)code result:(MobTechBlock)result;

@end

NS_ASSUME_NONNULL_END
