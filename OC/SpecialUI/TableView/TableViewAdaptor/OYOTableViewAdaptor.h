//
//  OYOTableViewAdaptor.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/24.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OYOTableViewCellItemProtocol.h"

@protocol OYOTableViewAdaptorDelegate;
/*!
 @class
 @abstract      该类处理tableview适配工作
 @discussion    处理plain类型的tableview相关适配工作,使用的时候需要将tableview的datasource和delegate设置成本类的实例对象
 */

@interface OYOTableViewAdaptor : NSObject<UITableViewDataSource,UITableViewDelegate>
//tableview
@property (nonatomic, weak) UITableView *tableView;

//cell 显示所需数据数组,其中每个数据模型都必须实现OYOTableViewCellItemProtocol协议
@property (nonatomic, strong) NSMutableArray        *items;

// 下拉刷新控制 (预留上拉刷新和下拉加载的处理)
@property (nonatomic, assign) BOOL dragRefreshEnable;

//tableViewEndDrag 结束刷新机制
@property (nonatomic, assign) BOOL tableViewEndRefresh;

// 上拉刷新控制
@property (nonatomic, assign) BOOL loadMoreEnable;

//上拉刷新事件回调
@property (nonatomic, copy) CommonSimpleBlock headerRefreshBlock;
//下拉事件回调
@property (nonatomic, copy) CommonSimpleBlock footerRefreshBlock;

/*!
 @property
 @abstract      cell 点击事件对应的action，用celltype进行索引
 @discussion    action对应的selector必须有两个参数，第一个参数是id类型的object对象，第二个参数是indexpath对象
 */
@property (nonatomic, strong) NSMutableDictionary   *cellActionDictionary;

//cell 执行点击事件的对象存放的字典,使用celltype进行索引
@property (nonatomic, strong) NSMutableDictionary   *cellTargetDictionary;

/*!
 @property
 @abstract      delegate
 @discussion    delegate和上面的cellActionDictionary＋cellTargetDictionary实现方法二者选其一即可，delegate是让代理对象去处理点击事件，
 action＋target方式是传递自定义的对象和sel来进行处理相关方式，具体使用看情况而定。
 */
@property (nonatomic, weak)   id<OYOTableViewAdaptorDelegate> delegate;

/*!
 @method
 @abstract  生成一个新的cell
 @param     object : cell显示所需的数据模型
 @param     indexPath : cell 的indexpath
 @param     identifier : cell 的重用标识
 @return    返回PATableViewCell类型的cell
 */
- (UITableViewCell *)generateCellForObject:(id<OYOTableViewCellItemProtocol>)object indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier;

/*!
 @method
 @abstract  获取indexpath位置的cell的高度
 @param     indexPath : index path
 @return    返回cell高度
 */
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

/*!
 @protocol
 @abstract  OYOTableViewAdaptor 代理
 */
@protocol OYOTableViewAdaptorDelegate<NSObject>

/*!
 @method
 @abstract  处理tableview cell选中事件
 param     tableView : tableview
 param     object : 选中的cell对用的数据模型
 param     indexPath : 被选中的cell的indexpath
 return    void
 */

@optional
- (void)tableView:(UITableView *)tableView didSelectObject:(id<OYOTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didSetObject:(id<OYOTableViewCellItemProtocol>)object cell:(UITableViewCell *)cell;

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
@end

