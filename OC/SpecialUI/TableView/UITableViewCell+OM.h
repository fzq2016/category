//
//  UITableViewCell+OM.h
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/5.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OMCellModel;
@protocol OMTableViewCell <NSObject>

/**
 计算 Cell 高度，默认为 0，会被 CellModel 缓存
 调用方式为 - [cellModel cellHeight]，建议提前调用缓存高度
 
 @param cellModel cellModel
 @return cellHeight
 */
+ (CGFloat)cellHeightForCellModel:(id<OMCellModel>)cellModel;

/**
 cell 创建完成回调
 */
- (void)cellDidLoad;


/**
 注册 Cell（ 非必要实现 ）
 默认调用 registerClass:forCellReuseIdentifier:
 使用 xib 或需要手动注册的需要实现该方法
 
 @param tableView tableView
 @param identify identify
 */
+ (void)registerCellWithTableView:(UITableView *)tableView identify:(NSString *)identify;


/**
 数据源方法
 不建议实现该方法，请在重写 setCellModel: 设置 Cell
 
 @param tableView tableView
 @param cellModel cellModel
 @return cell
 */
+ (instancetype)cellForTableView:(UITableView *)tableView cellModel:(id<OMCellModel>)cellModel;

/**
 cell重用标识符
 */
+ (NSString *)cellIdentifier;

/**
 *  通过xib注册nib
 *
 *
 */
+ (void) registerTableViewWithNibName:(UITableView *)tableView;
@end

@interface UITableViewCell (OM) <OMTableViewCell>

@property (nonatomic, strong) id<OMCellModel> cellModel;

@end
