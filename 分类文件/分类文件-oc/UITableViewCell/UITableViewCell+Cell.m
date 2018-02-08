//
//  UITableViewCell+Cell.m
//  
//
//  Created by FZQ on 16/5/12.
//  Copyright © 2016年 FZQ. All rights reserved.
//

#import "UITableViewCell+Cell.h"

@implementation UITableViewCell (Cell)

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

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(NSObject *)model
{
    NSAssert(FALSE, @"children class method");
    return nil;
}


@end
