//
//  NSString+ZQFileSize.h
//  
//
//  Created by FZQ on 16/5/16.
//  Copyright © 2016年 FZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZQFileSize)

/**
 获取文件大小

 @return unsigned long long
 */
- (unsigned long long)zq_fileSize;

@end