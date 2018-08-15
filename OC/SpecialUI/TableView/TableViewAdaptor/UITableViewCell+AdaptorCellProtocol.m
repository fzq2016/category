//
//  UITableViewCell+AdaptorCellProtocol.m
//  OYOConsumer
//
//  Created by willson on 2018/7/25.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "UITableViewCell+AdaptorCellProtocol.h"

@implementation UITableViewCell (AdaptorCellProtocol)

- (void)setObject:(NSObject *)object {
    objc_setAssociatedObject(self, @selector(object), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSObject *)object {
    return objc_getAssociatedObject(self, @selector(object));
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
    return 0;
}
@end
