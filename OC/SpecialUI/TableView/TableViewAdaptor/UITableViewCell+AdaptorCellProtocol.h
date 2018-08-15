//
//  UITableViewCell+AdaptorCellProtocol.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/25.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (AdaptorCellProtocol)
//给cell的参数处理规定类
@property (nonatomic, strong) NSObject *object;

//返回cell的高度
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object;

@end
