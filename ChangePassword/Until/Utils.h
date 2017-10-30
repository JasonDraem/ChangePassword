//
//  Utils.h
//  ChangePassword
//
//  Created by Jason_Xu on 2017/10/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(void);

@interface Utils : NSObject
/**
 判断是否是首次安装
 
 @return <#return value description#>
 */
+ (BOOL)isFirstInstallation;

/**
 字符串转换为时间
 
 @param dateString <#dateString description#>
 @param format <#format description#>
 @return <#return value description#>
 */
+ (NSDate *)stringToDate:(NSString *)dateString
          withDateFormat:(NSString *)format;
/**
 根据时间获取当前星期几
 
 @param date <#date description#>
 @return <#return value description#>
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)date;

/**
 自适应宽度
 
 @param labelText <#labelText description#>
 @param font <#font description#>
 @return return value description
 */
+ (UILabel *)xxy_LabelFitWidthWithText:(NSString *)labelText
                                  font:(CGFloat)font
                                 label:(UILabel *)textLabel;

/**
 归档
 
 @param object <#object description#>
 @param key <#key description#>
 @param path <#path description#>
 */
+ (void)archiverObject:(id)object
                 ByKey:(NSString *)key
              WithPath:(NSString *)path;

/**
 解档
 
 @param key <#key description#>
 @param path <#path description#>
 @return <#return value description#>
 */
+ (id)unarchiverObjectByKey:(NSString *)key
                   WithPath:(NSString *)path;

/**
 清除原归档信息信息
 
 @param key <#key description#>
 @param path <#path description#>
 @return <#return value description#>
 */
+ (BOOL)deleteFileWithKey:(NSString *)key
                     path:(NSString *)path;

/**
 判断是否为手机号
 
 @param mobileNum <#mobileNum description#>
 @return <#return value description#>
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 给label添加下划线
 
 @param label <#label description#>
 @param contentStr <#contentStr description#>
 */
+ (void)xxy_addUnderLineWithLabel:(UILabel *)label
                       contentStr:(NSString *)contentStr;
/**
 判断用户输入的密码是否符合规范，符合规范的密码要求：
 长度大于8位
 密码中必须同时包含数字和字母
 @param pass <#pass description#>
 @return <#return value description#>
 */
+(BOOL)judgePassWordLegal:(NSString *)pass;

/**
 label字符串显示不同颜色
 
 @param currentLabel <#currentLabel description#>
 @param content <#content description#>
 @param color <#color description#>
 @param font <#font description#>
 @param range <#range description#>
 */
+ (void)changeColorAndFontWithLabel:(UILabel * )currentLabel
                            content:(NSString *)content
                              color:(UIColor *)color
                               font:(CGFloat)font
                              range:(NSRange)range;

/**
 获取当前vc
 
 @return <#return value description#>
 */
+ (UIViewController *)currentViewController;

/**
 获取当前window
 
 @return <#return value description#>
 */
+ (UIWindow *)currentWindow;


/**
 根据当前时间获取 前一天 后一天时间
 
 @param dateTime <#dateTime description#>
 @return <#return value description#>
 */
+ (NSString *)previousDateTimeWithCurrentDateTime:(NSString *)dateTime;

/**
 后一天
 
 @param dateTime <#dateTime description#>
 @return <#return value description#>
 */
+ (NSString *)nextDateTimeWithCurrentDateTime:(NSString *)dateTime;

/**
 时间显示类型转换
 
 @param currentTime <#currentTime description#>
 @return <#return value description#>
 */
+ (NSString *)dateTimeStyeWithString:(NSString *)currentTime;

/**
 时间类型转化
 
 @param string <#string description#>
 @return <#return value description#>
 */
+ (NSString *)returnStringWithString:(NSString *)string;

/**
 32位加密  MD5 小写
 
 @param encryptionSting <#encryptionSting description#>
 @return <#return value description#>
 */
+ (NSString *)encryptionMD5_32LowercaseStringWithString:(NSString *)encryptionSting;

/**
 32位 加密
 
 @param encryption <#encryption description#>
 @return <#return value description#>
 */
+ (NSString *)encryptionMD5_32WithStr:(NSString *)encryption;

/**
 32位MD5加密 大写
 
 @param encryptionSting <#encryptionSting description#>
 @return <#return value description#>
 */
+ (NSString *)encryptionMD5_32UppercaseStringWithString:(NSString *)encryptionSting;

/**
 判断是否为中文
 
 @param matchedStr <#matchedStr description#>
 @return <#return value description#>
 */
+ (BOOL)matchStringFormat:(NSString *)matchedStr;

/**
 转化网络数据格式
 
 @param responseObjc <#responseObjc description#>
 @return <#return value description#>
 */
+ (NSDictionary *)returnDictoryWith:(id)responseObjc;

/**
 获取当前系统时间戳
 
 @return <#return value description#>
 */
+ (NSString *)getCurrentTimestamp;

+ (NSString *)getTime;

/**
 将某个时间转换为时间戳
 
 @param formatTime 时间
 @param format 时间格式 （@"YYYY-MM-dd hh:mm:ss"）--设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return <#return value description#>
 */
+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime
                     andFormatter:(NSString *)format;

/**
 将某个时间戳转换为时间
 
 @param timestamp 时间戳
 @param format （@"YYYY-MM-dd hh:mm:ss"）--设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return <#return value description#>
 */
+(NSString *)timestampSwitchTime:(NSInteger)timestamp
                    andFormatter:(NSString *)format;

/**
 对手机号AES加密并归档
 
 @param phone <#password description#>
 @return <#return value description#>
 */
+ (NSString *)aesPhoneAndArchiveWithPhone:(NSString *)phone;

/**
 对密码接档并AES解密
 
 @return <#return value description#>
 */
+ (NSString *)aesPhoneAndUnarchiveWithPhone;

/**
 对当前新密码进行加密并归档
 
 @param currentPassword currentPassword
 @return <#return value description#>
 */
+ (NSString *)aesPasswordAndArchiveWithCurrentPassword:(NSString *)currentPassword;

/**
 接档解密当前密码
 
 @return <#return value description#>
 */
+ (NSString *)aesPasswordAndUnarchive;

/**
 记录模式
 
 @param model model
 */
+ (void)recordProductModel:(NSArray *)model;

/**
 1、iOS 11 scrollerview放弃 automaticallyAdjustsScrollViewInsets 属性的使用
 2、iOS 11 后使用contentInsetAdjustmentBehavior属性
 @param scrollView <#scrollView description#>
 @param currentViewcontrller <#currentViewcontrller description#>
 */
+ (void)adjustsScrollViewInsets:(UIScrollView *)scrollView
           currentViewcontrller:(UIViewController *)currentViewcontrller;


/**
 color生产image
 
 @param color <#color description#>
 @return <#return value description#>
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;


@end
