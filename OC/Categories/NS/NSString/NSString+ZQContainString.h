//
//  NSString+ZQContainString.h
//  iOSBaseProject
//
//  Created by Felix on 2018/8/15.
//  Copyright © 2018年 FelixFan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZQContainString)

/**
    字符串是否包含某字符串

 @param subString subString
 @return BOOL
 */
- (BOOL)hasSubstring:(NSString *)subString;

@end
