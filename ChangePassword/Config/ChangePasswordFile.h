//
//  ChangePasswordFile.h
//  ChangePassword
//
//  Created by Jason_Xu on 2017/10/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#ifndef ChangePasswordFile_h
#define ChangePasswordFile_h

//屏幕尺寸
#define kMainScreenW [UIScreen mainScreen].bounds.size.width
#define kMainScreenH [UIScreen mainScreen].bounds.size.height
#define kMainScreenBounds [UIScreen mainScreen].bounds
//状态栏高度
#define kStatusnBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height)
// 导航栏高度
#define kNavgationBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)

#define kIphone6ScreenHeight    667.0f
#define kIphone6ScreenWidth     375.0f

#define kViewWidthScale     (kMainScreenW / kIphone6ScreenWidth)
#define kViewHeightScale    (kMainScreenH / kIphone6ScreenHeight)
#define kViewSizeScale      (kViewHeightScale / kViewWidthScale)

//通知
#define kNotificationCenter [NSNotificationCenter defaultCenter]
//打印
#ifdef DEBUG
#define kXXYLog(...) NSLog(__VA_ARGS__)
#else
#define kXXYLog(...)
#endif
//打印当前方法
#define kLogFunc kXXYLog(@"%s", __func__)
// RGB
#define kXXYColor(r, g, b, al) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:al]
#define kXXYGlobalBg        kXXYColor(223, 223, 223, 1.0)

#define kDXCMainColor                           kXXYColor(153,153,153,1)
#define kXXYGeneralColor_WhiteColor             [UIColor whiteColor]
#define kXXYGeneralColor_BlackColor             [UIColor blackColor]
#define kXXYGeneralColor_ClearColor               [UIColor clearColor]
#define kXXYGlobalSpaceColor [UIColor colorWithHexString:@"#efefef"]
#define kDXMainColorValue   (@"#347aea")
//导航栏主题颜色
#define kDXMainColor        kXXYColor(57, 125, 232, 1.0)

//判断系统版本
#define IOS_VERSION_7_OR_Below (([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0)? (YES):(NO))

#define IOS_VERSION_7_OR_Above (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))

#define IOS_VERSION_8_OR_Above (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))

#define IOS_VERSION_9_OR_Above (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)? (YES):(NO))

#define kDXCareUerDefaults                     [NSUserDefaults standardUserDefaults]

//获取image
#define kGetImage(imageName)     [UIImage imageNamed:imageName]
//超时时间处理
#define kTimeoutInterval 30.0f
//语音沙河路径
#define kDocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//判断当前设备机型是否为6
#define kIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断字符串是否有效
#define kIsValidNSString(x) (x != NULL && [x length] > 0)
//weakify/strongify
#pragma mark - weakify & strongify
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) __block __typeof__(object) block##_##object = object;
#endif
#endif
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) __typeof__(object) strong##_##object = block##_##object;
#endif
#endif


#endif /* ChangePasswordFile_h */
