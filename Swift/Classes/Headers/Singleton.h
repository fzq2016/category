//
//  Singleton.h
//  
//
//  Created by FZQ on 15/11/6.
//  Copyright © 2015年 FZQ. All rights reserved.
//  这个头文件是单例宏的头文件。在使用时，在合适的位置定义name即可使某类成为单例


#ifndef Singleton.h
#define Singleton.h

#if 1
#define Singleton_H(name) +(instancetype)share##name;

//arc
#if __has_feature(objc_arc)
#define Singleton_M(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[super allocWithZone:zone]init];\
});\
\
return _instance;\
}\
+(instancetype)share##name\
{\
    return [[self alloc]init];\
}\
\
-(nonnull id)copy\
{\
    return _instance;\
}\
\
-(nonnull id)mutableCopy\
{\
    return _instance;\
}

//mrc
#else
#define Singleton_M(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[super allocWithZone:zone]init];\
});\
\
return _instance;\
}\
\
+(instancetype)shareLoginViewController\
{\
    return [[self alloc]init];\
}\
\
-(nonnull id)copy\
{\
    return _instance;\
}\
\
-(nonnull id)mutableCopy\
{\
    return _instance;\
}\
\
-(oneway void)release{}\
\
-(instancetype)retain\
{\
    return _instance;\
}\
\
-(NSInteger)retainCount\
{\
    return MAXFLOAT;\
}
#endif

#endif


#endif /* Singleton_h */
