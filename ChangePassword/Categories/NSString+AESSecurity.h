//
//  NSString+AESSecurity.h
//  ChangePassword
//
//  Created by Jason_Xu on 2017/10/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AESSecurity)
/**
 AES加密
 
 @param content <#content description#>
 @param key <#key description#>
 @return <#return value description#>
 */
+ (NSString *)encrypyAES:(NSString *)content
                     key:(NSString *)key;

/**
 AES解密
 
 @param content <#content description#>
 @param key <#key description#>
 @return <#return value description#>
 */
+ (NSString *)descryptAES:(NSString *)content
                      key:(NSString *)key;
@end
