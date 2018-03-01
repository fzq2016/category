//
//  NSString+ZQFileSize.m
//  
//  该分类用于计算某文件（夹）的大小


#import "NSString+ZQFileSize.h"

@implementation NSString (ZQFileSize)

- (unsigned long long)zq_fileSize
{
    // 获取文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 定义变量
    BOOL isDirectory;
    BOOL isExist;
    unsigned long long size = 0;
    
        
    // 判断文件是否存在
    isExist = [fileManager fileExistsAtPath:self isDirectory:&isDirectory];
    if (isExist == NO) return size;
    

    // 方法一：判断是否是文件夹
    if (isDirectory == NO) {
//    // 方法二：文件属性
//    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
//    if ([attrs.fileType isEqualToString:NSFileTypeDirectory] == NO) { // 文件
        
        // 直接获取文件大小
        size = [fileManager attributesOfItemAtPath:self error:nil].fileSize;
    }else{
    
        // 遍历caches文件夹子文件累计子文件大小
        NSArray *subpaths = [fileManager subpathsAtPath:self]; // 方法一
//        NSDirectoryEnumerator *subpaths = [mgr enumeratorAtPath:self];// 方法二
        
        for (NSString *subpath in subpaths) 
        {   
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
        
            // 判断是否是文件夹
            [fileManager fileExistsAtPath:fullSubpath isDirectory:&isDirectory];
        
            // 若是文件夹，不统计文件夹本身大小
            if (isDirectory == YES) continue;
        
            // 累计大小
            size += [fileManager attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
    }

    return size;
}

@end
