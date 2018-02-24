//
//  NSDictionary+ZQPropertyList.m
//  



#import "NSDictionary+ZQPropertyList.h"

@implementation NSDictionary (ZQPropertyList)

- (void)zq_createPropertyList
{
    // 逐个通过NSLog打印会带上其他信息，用拼接字符串打印最好
    // print无法打印OC对象信息
    NSMutableString *strM = [NSMutableString string];
 
    // 遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        
//        NSLog(@"%@ %@",key,[value class]);打印类型及属性名
        
        //数据类型
        NSString *code = nil;
        
        // 判断value类型生成输出结果
        if ([value isKindOfClass:[NSString class]]) {
            // NSString
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSString *%@;",key];
            
            // BOOL—>__NSCFBoolean
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,assign) BOOL %@;",key];
            
            // NSNumber/NSInteger
        }else if ([value isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,assign) NSInteger %@;",key];
            
            //    NSArray
        }else if ([value isKindOfClass:[NSArray class]]){
            
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSArray *%@;",key];
            
        }else if ([value isKindOfClass:[NSDictionary class]]){
            
            //    NSDictionary
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSDictionary *%@;",key];
            
        }
        
        [strM appendFormat:@"\n%@\n",code];
        // 获取所有key
    }];
    
    NSLog(@"%@",strM);
    
}
@end
