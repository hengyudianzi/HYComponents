//
//  MobTechConfig.m
//  HYComponents
//
//  Created by 🐲 on 2022/9/6.
//

#import "MobTechConfig.h"
#import <MOBFoundation/MobSDK+Privacy.h>
#import <SMS_SDK/SMSSDK.h>

@implementation MobTechConfig

//mob 权限问题
+(void)mob_QXConfig{
    [MobSDK uploadPrivacyPermissionStatus:YES onResult:^(BOOL success) {
    }];
}


//权限 手机号
+(void)mob_SendPhoneCode:(NSString *)phoneNumber result:(MobTechBlock)result{
    //
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumber zone:@"86" template:@"" result:^(NSError *error) {
        result(error);
    }];
}


//检验验证码
+(void)mob_CheckPhoneCode:(NSString *)phoneNumber code:(NSString *)code result:(MobTechBlock)result{
    //
    [SMSSDK commitVerificationCode:code phoneNumber:phoneNumber zone:@"86"result:^(NSError *error) {
        result(error);
    }];
}

@end
