//
//  SVProgressHUD+Extension.m
//  ChangePassword
//
//  Created by Jason_Xu on 2017/10/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import "SVProgressHUD+Extension.h"

@implementation SVProgressHUD (Extension)

+ (void)showWithStatus:(NSString *)status defaultStyle:(SVProgressHUDStyle)style{
    [self setDefaultStyle:style];
    if (style == SVProgressHUDStyleCustom) {
        [self setBackgroundColor:kXXYGeneralColor_BlackColor];
        [self setForegroundColor:kXXYGeneralColor_WhiteColor];
    }
    [self showWithStatus:status];
}

+ (void)showInfoWithStatus:(NSString *)status defaultStyle:(SVProgressHUDStyle)style{
    [self setDefaultStyle:style];
    if (style == SVProgressHUDStyleCustom) {
        [self setBackgroundColor:kXXYGeneralColor_BlackColor];
        [self setForegroundColor:kXXYGeneralColor_WhiteColor];
    }
    [self showInfoWithStatus:status];
}

+ (void)showProgress:(float)progress defaultStyle:(SVProgressHUDStyle)style{
    [self setDefaultStyle:style];
    if (style == SVProgressHUDStyleCustom) {
        [self setBackgroundColor:kXXYGeneralColor_BlackColor];
        [self setForegroundColor:kXXYGeneralColor_WhiteColor];
    }
    [self showProgress:progress];
}

+ (void)showErrorWithStatus:(NSString *)status dismissWithDelay:(CGFloat)delay{
    [self showErrorWithStatus:status];
    [self dismissWithDelay:delay];
}

+ (void)showSuccessWithStatus:(NSString *)status dismissWithDelay:(CGFloat)delay{
    [self showSuccessWithStatus:status];
    [self dismissWithDelay:delay];
}

+ (void)showInfoWithStatus:(NSString *)status
              defaultStyle:(SVProgressHUDStyle)style
           dismisWithDelay:(CGFloat)delay{
    [self setDefaultStyle:style];
    if (style == SVProgressHUDStyleCustom) {
        [self setBackgroundColor:kXXYGeneralColor_BlackColor];
        [self setForegroundColor:kXXYGeneralColor_WhiteColor];
    }
    [self showInfoWithStatus:status];
    [self dismissWithDelay:delay];
}

+ (void)showErrorWithStatus:(NSString *)status
               defaultStyle:(SVProgressHUDStyle)style
           dismissWithDelay:(CGFloat)delay{
    [self setDefaultStyle:style];
    if (style == SVProgressHUDStyleCustom) {
        [self setBackgroundColor:kXXYGeneralColor_BlackColor];
        [self setForegroundColor:kXXYGeneralColor_WhiteColor];
    }
    [self showErrorWithStatus:status];
    [self dismissWithDelay:delay];
}

+ (void)showSuccessWithStatus:(NSString *)status
                 defaultStyle:(SVProgressHUDStyle)style
             dismissWithDelay:(CGFloat)delay{
    [self setDefaultStyle:style];
    if (style == SVProgressHUDStyleCustom) {
        [self setBackgroundColor:kXXYGeneralColor_BlackColor];
        [self setForegroundColor:kXXYGeneralColor_WhiteColor];
    }
    [self showSuccessWithStatus:status];
    [self dismissWithDelay:delay];
}

@end
