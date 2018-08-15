//
//  NSString+ZQFileSize.h
//  iOSBaseProject
//
//  Created by Felix on 16/5/16.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZQFileSize)

/**
 获取文件大小

 @return unsigned long long
 */
- (unsigned long long)zq_fileSize;

@end
