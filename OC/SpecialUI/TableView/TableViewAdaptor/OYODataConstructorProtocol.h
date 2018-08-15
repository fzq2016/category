//
//  OYODataConstructorProtocol.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/19.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @ class
 @abstract      基础数据构造器 统一接口协议
 */
@protocol OYODataConstructorProtocol <NSObject>

/*!
 @property
 @abstract      可变数组，用来存放构造出来的数据
 */
@optional
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) id<OYODataConstructorProtocol>delegate;

/*!
 @method
 @abstract      构造数据
 @discussion    可以是静态数据，也可以是网络请求数据，或缓存数据，由子类来实现这个方法
 */
- (void)constructData;

/*!
 @method
 @abstract      加载数据
 @discussion    子类覆盖此方法，若有多次请求，可封装为多个请求方法，然后在此处调用，具体情况具体对待
 @ return        void
 */

- (void)loadData;

/*!
 @method
 @abstract      加载数据完成
 @param         dataModel : 加载完成后的数据
 @discussion    此方法在数据加载成功的时候被调用
 @ return        void
 */
- (void)didFinishLoadData:(id)dataModel operation:(NSURLSessionDataTask *)dataTask;

/*!
 @method
 @abstract      加载数据完成
 @param         errorModel : 错误数据
 @discussion    此方法在加载数据出现错误的时候被调用
 @ return        void
 */
- (void)didFailLoadData:(id)errorModel operation:(NSURLSessionDataTask *)dataTask;



//网络请求 成功和失败的回调 , 处理一些数据逻辑, 调用顺序, 成功先调用, 然后在回调.
//下面两个方法可以理解成代理 , 上面若干方法可以理解为协议
- (void)dataConstructor:(id)dataConstructor didFinishLoadModel:(id)dataModel operation:(NSURLSessionDataTask *)dataTask;

- (void)dataConstructor:(id)dataConstructor DidFailWithErrorModel:(id)errorDataModel operation:(NSURLSessionDataTask *)dataTask;
 

@end
