//
//  UITableViewCell+ZQCell.h
//  
//
//  Created by FZQ on 16/5/12.
//  Copyright © 2016年 FZQ. All rights reserved.
//  封装获取cell的方法

#import <UIKit/UIKit.h>

@interface UITableViewCell (ZQCell)

/**
 *  封装缓存中取出cell或通过alloc initWithStyle: reuseIdentifier:创建cell的方法
 *
 *  @param tableView  cell所在的tableView
 *  @param style  cell的类型
 *  @param Identifier cell的循环利用标识
 *
 *  @return cell
 */
+ (instancetype)zq_cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style Identifier:(NSString *)Identifier;


/**
 封装缓存中取出cell或创建cell的方法,必须由子类重写该方法的实现

 @param tableView cell所在的tableView
 @param model 模型数据
 @return cell
 */
+ (instancetype)zq_cellWithTableView:(UITableView *)tableView model:(NSObject *)model;


@end
