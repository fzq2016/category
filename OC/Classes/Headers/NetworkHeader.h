//
//  NetworkHeader.h
//  
//
//  Created by FZQ on 2018/2/9.
//  Copyright © 2018年 FZQ. All rights reserved.
//  此文件用于存放网络相关的枚举宏

#ifndef NetworkHeader_h
#define NetworkHeader_h


#ifdef DEBUG
//----------------------测试环境---------------------------
// 内网地址


#else
//----------------------发布环境---------------------------
// 外网地址

#endif


//----------------------请求结果---------------------------
#define REQUEST_SUCCESS @"0"                                      //请求成功
#define NON_INFOMATION @"2440"                                    //无信息
#define PHONE_CODE_FALSE @"2407"                                  //手机验证码失败
#define TOKEN_IS_NON @"9999"                                      //token不存在
//----------------------请求结果---------------------------


#endif /* NetworkHeader_h */
