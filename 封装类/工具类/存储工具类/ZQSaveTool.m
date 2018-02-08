

#import "ZQSaveTool.h"

@implementation ZQSaveTool

//保存方法
+ (void)setObject:object forKey:key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}

//读取方法
+ (id)objectForKey:key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
