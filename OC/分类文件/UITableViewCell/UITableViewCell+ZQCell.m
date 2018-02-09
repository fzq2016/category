//
//  UITableViewCell+ZQCell.m
//  
//
//  Created by FZQ on 16/5/12.
//  Copyright © 2016年 FZQ. All rights reserved.
//

#import "UITableViewCell+ZQCell.h"

@implementation UITableViewCell (ZQCell)

+ (instancetype)zq_cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style Identifier:(NSString *)Identifier
{
    //从缓存中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    //创建cell
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:Identifier];
    }
    
    return cell;
}

+ (instancetype)zq_cellWithTableView:(UITableView *)tableView model:(NSObject *)model
{
    // 该方法由子类重写。如果子类没有重写，抛出异常
    NSAssert(FALSE, @"children class method");
    return nil;
}


@end
