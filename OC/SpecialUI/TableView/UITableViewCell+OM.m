//
//  UITableViewCell+OM.m
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/5.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "UITableViewCell+OM.h"
#import <objc/message.h>

@implementation UITableViewCell (OM)

+ (void)load {
    Method original = class_getInstanceMethod(self.class, @selector(initWithStyle:reuseIdentifier:));
    Method swizzled = class_getInstanceMethod(self.class, @selector(oyo_initWithStyle:reuseIdentifier:));
    method_exchangeImplementations(original, swizzled);
}

- (instancetype)oyo_initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    UITableViewCell *cell = [self oyo_initWithStyle:style reuseIdentifier:reuseIdentifier];
    [cell cellDidLoad];
    return cell;
}

#pragma mark - OMCellModel
+ (void)registerCellWithTableView:(UITableView *)tableView identify:(NSString *)identify {
    [tableView registerClass:self forCellReuseIdentifier:identify];
}

+ (instancetype)cellForTableView:(UITableView *)tableView cellModel:(id<OMCellModel>)cellModel {
    NSString *identify = NSStringFromClass(self.class);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        [self registerCellWithTableView:tableView identify:identify];
        cell = [tableView dequeueReusableCellWithIdentifier:identify];
    }
    cell.cellModel = cellModel;
    return cell;
}

+ (CGFloat)cellHeightForCellModel:(id<OMCellModel>)cellModel {
    return 0;
}

- (void)cellDidLoad {
    
}

+ (NSString *)cellIdentifier {
    const char *className = class_getName(self);
    return [NSString stringWithUTF8String:className];
}


+ (void)registerTableViewWithNibName:(UITableView *)tableView {
    UINib *nib = [UINib nibWithNibName:[self cellIdentifier] bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[self cellIdentifier]];
}


#pragma mark - Getter & Setter
- (void)setCellModel:(id<OMCellModel>)cellModel {
    objc_setAssociatedObject(self, @selector(cellModel), cellModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<OMCellModel>)cellModel {
    return objc_getAssociatedObject(self, _cmd);
}

@end
