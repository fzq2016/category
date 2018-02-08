//
//  ZQSaveTool.h
//  数据保存工具类，负责整个项目中所有的数据保存

#import <Foundation/Foundation.h>

@interface ZQSaveTool : NSObject

/**
   保存方法
 */
+ (void)setObject:object forKey:key;


/**
 读取方法

 @return 读取结果
 */
+ (id)objectForKey:key;

@end
