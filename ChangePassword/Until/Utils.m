//
//  Utils.m
//  ChangePassword
//
//  Created by Jason_Xu on 2017/10/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation Utils

//判断是否首次安装
+ (BOOL)isFirstInstallation{
    BOOL isFirst = NO;
    static NSString *key = @"CFBundleShortVersionString";
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        isFirst = NO;
    } else {
        isFirst = YES;
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
    return isFirst;
}
//日期格式转字符串
+ (NSString *)dateToString:(NSDate *)date
            withDateFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

//字符串转日期格式
+ (NSDate *)stringToDate:(NSString *)dateString
          withDateFormat:(NSString *)format{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

//将世界时间转化为中国区时间
+ (NSDate *)worldTimeToChinaTime:(NSDate *)date{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}
//根据日期获取相对应的星期
+ (NSString*)weekdayStringFromDate:(NSDate*)date {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    // NSGregorianCalendar
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIndian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    // NSWeekdayCalendarUnit
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
//根据text适应宽度
+ (UILabel *)xxy_LabelFitWidthWithText:(NSString *)labelText font:(CGFloat)font label:(UILabel *)textLabel{
    //UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:font];
    NSString *str = labelText;
    textLabel.text = str;
    textLabel.backgroundColor = kXXYGeneralColor_WhiteColor;
    textLabel.numberOfLines = 1;//根据最大行数需求来设置
    textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(MAXFLOAT, MAXFLOAT);//labelsize的最大值
    //关键语句
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    textLabel.frame = CGRectMake(0, 0, expectSize.width, expectSize.height);
    //    CGSize size = [labelText sizeWithAttributes:@{NSFontAttributeName:textLabel.font}];
    //    CGSize adaptionSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    //
    //    textLabel.frame = CGRectMake(0, 0, adaptionSize.width, adaptionSize.height);
    
    return textLabel;
}
//归档
+ (void)archiverObject:(id)object
                 ByKey:(NSString *)key
              WithPath:(NSString *)path{
    //初始化存储对象信息的data
    NSMutableData *data = [NSMutableData data];
    //创建归档工具对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //开始归档
    [archiver encodeObject:object forKey:key];
    //结束归档
    [archiver finishEncoding];
    //写入本地
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *destPath = [[docPath stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:path];
    
    //    NSLog(@"%@", destPath);
    
    [data writeToFile:destPath atomically:YES];
}
//接档
+ (id)unarchiverObjectByKey:(NSString *)key
                   WithPath:(NSString *)path{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *destPath = [[docPath stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:path];
    
    NSData *data = [NSData dataWithContentsOfFile:destPath];
    //    NSLog(@"%@", destPath);
    if (data) {
        //创建反归档对象
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        //接收反归档得到的对象
        id object = [unarchiver decodeObjectForKey:key];
        return object;
    }
    return nil;
}
//删除归档内容
+ (BOOL)deleteFileWithKey:(NSString *)key
                     path:(NSString *)path {
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    //文件名
    NSString *destPath = [[docPath stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:path];
    
    BOOL blHave = [fileManager fileExistsAtPath:destPath];
    
    if (!blHave) {
        
        NSLog(@"no  have");
        
        return NO;
        
    }else {
        
        NSLog(@" have");
        
        BOOL blDele= [fileManager removeItemAtPath:destPath error:nil];
        
        if (blDele) {
            
            NSLog(@"dele success");
            return blDele;
        }else {
            
            NSLog(@"dele fail");
            return !blDele;
        }
        
    }
    
}

//区分号段
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    if (mobileNum.length != 11){
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700,173
     */
    NSString *CT = @"(^1(33|53|77|73|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}
//给label添加下划线
+ (void)xxy_addUnderLineWithLabel:(UILabel *)label
                       contentStr:(NSString *)contentStr{
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", contentStr]];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    //改变下划线颜色
    //[content addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:(NSRange){0,[content length]}];
    label.attributedText = content;
}
//判断密码长度8--16 以及是否同时包含数字密码
//
+ (BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if (pass.length >= 8 && pass.length <= 16){
        // 判断长度大于8小于16位位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}
//label显示不同颜色 字体大小
+ (void)changeColorAndFontWithLabel:(UILabel * )currentLabel
                            content:(NSString *)content
                              color:(UIColor *)color
                               font:(CGFloat)font
                              range:(NSRange)range{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:content];
    //设置：在响应单位长度内的内容显示成
    [str addAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : [UIFont systemFontOfSize:font]} range:range];
    currentLabel.attributedText = str;
}
//获取当前vc
+ (UIViewController *)currentViewController {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    
    return result;
}
//window
+ (UIWindow *)currentWindow {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.window;
}

+ (NSString *)previousDateTimeWithCurrentDateTime:(NSString *)dateTime{
    
    // @"2017-07-01"
    NSString *dateString = dateTime;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:date];//前一天
    NSString *time = [NSString stringWithFormat:@"%@", [formatter stringFromDate:yesterday]];
    
    return time;
}

+ (NSString *)nextDateTimeWithCurrentDateTime:(NSString *)dateTime{
    // @"2017-07-01"
    NSString *dateString = dateTime;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    NSDate *tomorrow = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];//后一天
    NSString *time = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tomorrow]];
    return time;
}
//
+ (NSString *)dateTimeStyeWithString:(NSString *)currentTime{
    
    NSArray *dateArr = [currentTime componentsSeparatedByString:@"-"];
    
    NSMutableString * time = [NSMutableString string];
    
    [time appendFormat:@"%@年", dateArr[0]];
    [time appendFormat:@"%@月", dateArr[1]];
    [time appendFormat:@"%@日", dateArr[2]];
    return time;
}
//#pragma mark - 拼接月份 2017-07-07
+ (NSString *)returnStringWithString:(NSString *)string{
    NSMutableString *appendStr = [NSMutableString string];
    if ([string integerValue] < 10) {
        [appendStr appendFormat:@"0%@", string];
        return appendStr;
    }else{
        return string;
    }
}
//小写
+ (NSString *)encryptionMD5_32LowercaseStringWithString:(NSString *)encryptionSting{
    //进行UTF8的转码
    const char *original_str = [encryptionSting UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str,(CC_LONG)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        /*
         %02X是格式控制符：‘x’表示以16进制输出，‘02’表示不足两位，前面补0；
         */
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}
//
+ (NSString *)encryptionMD5_32WithStr:(NSString *)encryption{
    const char *cStr = [encryption UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}
//大写
+ (NSString *)encryptionMD5_32UppercaseStringWithString:(NSString *)encryptionSting{
    //进行UTF8的转码
    const char *original_str = [encryptionSting UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str,(CC_LONG)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        /*
         %02X是格式控制符：‘x’表示以16进制输出，‘02’表示不足两位，前面补0；
         */
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash uppercaseString];
    return mdfiveString;
}

#pragma mark - 正则判断
+ (BOOL)matchStringFormat:(NSString *)matchedStr{
    NSString * regex = @"^[\u4e00-\u9fa5]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:matchedStr];
}

/**
 转化返回数据格式
 
 @param responseObjc <#responseObjc description#>
 @return <#return value description#>
 */
+ (NSDictionary *)returnDictoryWith:(id)responseObjc{
    // 1.将返回的字典类型转换为 data类型
    NSData *data = [NSJSONSerialization dataWithJSONObject:responseObjc options:NSJSONWritingPrettyPrinted error:nil];
    // 2.常规解析
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return dict;
}

#pragma mark - 时间和时间戳的互相转换

+ (NSString *)getTime{
    NSDateFormatter *dateFormatter = [ [NSDateFormatter alloc] init ];
    //YYMMddHHmmss  YYYY-MM-dd HH:mm:ss
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate *now = [NSDate date];
    NSString *stime = [dateFormatter stringFromDate:now];
    return stime;
}

//获取当前系统时间的时间戳
+ (NSString *)getCurrentTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    //现在时间
    NSDate *datenow = [NSDate date];
    
    //NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    //时间转时间戳的方法:
    NSNumber *timeSp = [NSNumber numberWithDouble:[datenow timeIntervalSince1970]];
    //时间戳的值
    NSString *timeStamp = [NSString stringWithFormat:@"%@", timeSp];
    //NSLog(@"设备当前的时间戳:%@", timeStamp);
    
    return timeStamp;
}
//将某个时间转换为时间戳
+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime
                     andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //(@"YYYY-MM-dd hh:mm:ss") 设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:format];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    //将字符串按formatter转成nsdate
    NSDate* date = [formatter dateFromString:formatTime];
    
    //时间转时间戳的方法:
    //NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    NSNumber *timeSp = [NSNumber numberWithDouble:[date timeIntervalSince1970]];
    NSString *timestamp = [NSString stringWithFormat:@"%@", timeSp];
    //NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%@", timestamp); //时间戳的值
    
    return timestamp;
}
//将某个时间戳转化成时间
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp
                     andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //（@"YYYY-MM-dd hh:mm:ss"）设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:format];
    //  @"Asia/Shanghai"
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    //NSLog(@"1296035591  = %@",confromTimesp);
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    return confromTimespStr;
}
#pragma mark -账号 密码相关操作
// 手机号加密并归档
+ (NSString *)aesPhoneAndArchiveWithPhone:(NSString *)phone{
    
    //删除原保存的账号
    [self deleteFileWithKey:phoneEncodingKey path:phoneEncodingFilePath];
    //对密码进行AES加密
    NSString *aesPhone = [NSString encrypyAES:phone key:phoneAEScodingKey];
    //归档
    [Utils archiverObject:aesPhone ByKey:phoneEncodingKey WithPath:phoneEncodingFilePath];
    
    return aesPhone;
}
// 手机号解档并解密
+ (NSString *)aesPhoneAndUnarchiveWithPhone{
    //取出密码
    NSString *encodingPhone = [Utils unarchiverObjectByKey:phoneEncodingKey WithPath:phoneEncodingFilePath];
    //AES解密
    encodingPhone = [NSString descryptAES:encodingPhone key:phoneAEScodingKey];
    
    return encodingPhone;
}
// 密码加密并归档
+ (NSString *)aesPasswordAndArchiveWithCurrentPassword:(NSString *)currentPassword{
    // 删除原保存的密码
    [self deleteFileWithKey:passwordKey path:passwordEncodingFilePath];
    // 对密码进行aes加密
    NSString *aesPassword = [NSString encrypyAES:currentPassword key:phoneAEScodingKey];
    //归档
    [Utils archiverObject:aesPassword ByKey:passwordKey WithPath:passwordEncodingFilePath];
    return aesPassword;
}
// 密码解密并归档
+ (NSString *)aesPasswordAndUnarchive{
    // 取出密码
    NSString *encodingPassword = [Utils unarchiverObjectByKey:passwordKey WithPath:passwordEncodingFilePath];
    // AES解密
    encodingPassword = [NSString descryptAES:encodingPassword key:phoneAEScodingKey];
    return encodingPassword;
}

// 解决 iOS 11 放弃 automaticallyAdjustsScrollViewInsets 的方法
+ (void)adjustsScrollViewInsets:(UIScrollView *)scrollView currentViewcontrller:(UIViewController *)currentViewcontrller{
    
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        currentViewcontrller.automaticallyAdjustsScrollViewInsets = NO;
    }
}


/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color{
    //设置长宽
    CGRect rect = CGRectMake(0.0f, 0.0f, 5.0f, 5.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}



@end
