//
//  CommonConfigFile.m
//  ChangePassword
//
//  Created by Jason_Xu on 2017/10/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import "CommonConfigFile.h"

@implementation CommonConfigFile


//归档地址
NSString *const filePath = @"childCareIsLogin.plist";
//归档key
NSString *const encodeKey = @"encodeKey";

//sessionKey
NSString *const sessionIdKey = @"sessionIdKey";
//sessionIdFilePath
NSString *const sessionIdFilePath = @"sessionIdFilePath";
//保存手机号即当前帐号相关字段
NSString *const phoneEncodingKey = @"phoneEncodingKey";

//加密地址
NSString *const phoneEncodingFilePath = @"phoneEncodingFilePath";
NSString *const phoneAEScodingKey = @"phoneEncodingFilePath";
//密码
NSString *const passwordKey = @"passwordKey";
NSString *const passwordEncodingFilePath = @"passwordEncodingFilePath";
NSString *const passwordAesCodingKey = @"passwordEncodingKey";


@end
