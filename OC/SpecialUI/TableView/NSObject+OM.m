//
//  NSObject+OM.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/5.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "NSObject+OM.h"
#import <objc/message.h>

@implementation NSObject (OM)

- (void)setCellClass:(Class)cellClass {
    objc_setAssociatedObject(self, @selector(cellClass), NSStringFromClass(cellClass), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (Class)cellClass {
    return NSClassFromString(objc_getAssociatedObject(self, _cmd));
}

- (void)setCellHeight:(NSNumber *)cellHeight {
    objc_setAssociatedObject(self, @selector(cellHeight), cellHeight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)cellHeight {
    NSNumber *cellHeight = objc_getAssociatedObject(self, _cmd);
    if (!cellHeight) {
        cellHeight = @([self.cellClass cellHeightForCellModel:(id<OMCellModel>)self]);
        self.cellHeight = cellHeight;
    }
    return cellHeight;
}

@end
