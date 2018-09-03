//
//  OYOTableViewAdaptor.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/24.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "OYOTableViewAdaptor.h"
#import "MJRefresh.h"

#define LOADMORE_HEIGHT 44.0

@interface OYOTableViewAdaptor()

@end

@implementation OYOTableViewAdaptor

#pragma mark - synthesize
@synthesize items                           = _items;
@synthesize cellActionDictionary            = _cellActionDictionary;
@synthesize cellTargetDictionary            = _cellTargetDictionary;
@synthesize tableView                       = _tableView;
@synthesize delegate                        = _delegate;

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    
    kWeakSelf
    MJRefreshHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        kStrongSelf
        if (self.headerRefreshBlock) {
            self.headerRefreshBlock();
        }
    }];
    
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        kStrongSelf
        if (self.footerRefreshBlock) {
            self.footerRefreshBlock();
        }
        
    }];
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
}

- (void)setTableViewEndRefresh:(BOOL)tableViewEndRefresh {
    if (tableViewEndRefresh) {
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        if (self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}


- (UITableViewCell *)generateCellForObject:(id<OYOTableViewCellItemProtocol>)object indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    UITableViewCell *cell                  = nil;
    
    if (object) {
        Class   cellClass                       = [self cellClassForObject:object];
        //object.useNib == YES;
        BOOL userNib = NO;
        if (userNib) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
            cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        } else {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        if ([cell respondsToSelector:@selector(setObject:)]) {
            [cell performSelector:@selector(setObject:) withObject:object];
        }
    }
    
    return cell;
}

//获取cell数据模型item对应的cell的类对象
- (Class)cellClassForObject:(id<OYOTableViewCellItemProtocol>)object{
    Class cellClass             = nil;
    
    if (object) {
        if ([object respondsToSelector:@selector(cellClass)]) {
            cellClass           = [object cellClass];
        }
    }
    return cellClass;
}

- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath{
    Class cellClass                                 = nil;
    id<OYOTableViewCellItemProtocol> object     = [self objectForRowAtIndexPath:indexPath];
    
    cellClass                                       = [self cellClassForObject:object];
    
    return cellClass;
}

//获取indexpath位置上cell的数据模型
- (id<OYOTableViewCellItemProtocol>)objectForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object           = nil;
    
    if (self.items.count > indexPath.row) {
        object          = [self.items objectAtIndex:indexPath.row];
    }
    
    return object;
}

- (NSInteger)numberOfRows{
    return self.items.count;
}

- (int)numberOfSections{
    return 1;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight       = 0;
    
    UITableView * tableView = self.tableView;
    id object               = [self objectForRowAtIndexPath:indexPath];
    Class cellClass         = [self cellClassForIndexPath:indexPath];
//    rowHeight               = [cellClass tableView:tableView rowHeightForObject:object];
    
    return rowHeight;
}

- (NSString *)cellTypeAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellType                         = nil;
    
    id<OYOTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (object) {
        cellType                                = [object cellType];
    }
    
    return cellType;
}

- (NSString *)identifierForCellAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier                       = nil;
    
    identifier                                  = [self cellTypeAtIndexPath:indexPath];
    
    return identifier;
}

- (SEL)actionForCellType:(NSString *)cellType{
    SEL action      = nil;
    
    if ([self.cellActionDictionary objectForKey:cellType]) {
        if ([[self.cellActionDictionary objectForKey:cellType] isKindOfClass:[NSValue class]]) {
            action  = [[self.cellActionDictionary objectForKey:cellType] pointerValue];
        }
    }
    
    return action;
}

- (SEL)actionForCellAtIndexPath:(NSIndexPath *)indexPath{
    SEL action          = nil;
    
    NSString * cellType = [self cellTypeAtIndexPath:indexPath];
    action              = [self actionForCellType:cellType];
    
    return action;
}

- (id)targetForCellType:(NSString *)cellType{
    id target           = nil;
    
    if ([self.cellTargetDictionary objectForKey:cellType]) {
        target          = [self.cellTargetDictionary objectForKey:cellType];
    }
    
    return target;
}

- (id)targetForCellAtIndexPath:(NSIndexPath *)indexPath{
    id  target             = nil;
    
    NSString * cellType    = [self cellTypeAtIndexPath:indexPath];
    target                 = [self targetForCellType:cellType];
    
    return target;
}

#pragma mark - setter/getter
- (NSMutableArray *)items{
    if (_items == nil) {
        self.items = [NSMutableArray array];
    }
    
    return _items;
}

- (NSMutableDictionary *)cellActionDictionary{
    if (_cellActionDictionary == nil) {
        self.cellActionDictionary   = [NSMutableDictionary dictionary];
    }
    
    return _cellActionDictionary;
}


- (NSMutableDictionary *)cellTargetDictionary{
    if (_cellTargetDictionary == nil) {
        self.cellTargetDictionary   = [NSMutableDictionary dictionary];
    }
    
    return _cellTargetDictionary;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self numberOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self numberOfSections];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id<OYOTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    
    NSString * identifier  = [self identifierForCellAtIndexPath:indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        //初始化cell
        cell               = [self generateCellForObject:object indexPath:indexPath identifier:identifier];
    }
    
    //更新数据
    if ([cell isKindOfClass:[UITableViewCell class]] && [cell respondsToSelector:@selector(setObject:)]) {
        [cell performSelector:@selector(setObject:) withObject:object];
    }
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSetObject:cell:)]) {
        [self.delegate tableView:tableView didSetObject:object cell:cell];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height      = 0;
    
    if (self.tableView == nil) {
        self.tableView  = tableView;
    }
    height              = [self heightForRowAtIndexPath:indexPath];
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<OYOTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    SEL action          = [self actionForCellAtIndexPath:indexPath];
    id target           = [self targetForCellAtIndexPath:indexPath];
    if (action && target) {
        if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:action withObject:object withObject:indexPath];
#pragma clang diagnostic pop
        }
    }else{
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(tableView:didSelectObject:rowAtIndexPath:)]) {
                [self.delegate tableView:tableView didSelectObject:object rowAtIndexPath:indexPath];
            }
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.delegate tableView:self.tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return @"Delete";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

@end
