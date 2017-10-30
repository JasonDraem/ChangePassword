//
//  CommonConfigFile.h
//  ChangePassword
//
//  Created by Jason_Xu on 2017/10/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonConfigFile : NSObject


//密码
UIKIT_EXTERN NSString *const phoneEncodingKey;

UIKIT_EXTERN NSString *const phoneEncodingFilePath;

UIKIT_EXTERN NSString *const phoneAEScodingKey;

UIKIT_EXTERN NSString *const passwordKey;
UIKIT_EXTERN NSString *const passwordEncodingFilePath;
UIKIT_EXTERN NSString *const passwordAesCodingKey;


@end
