//
//  OYOUITableView.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/5.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "OYOUITableView.h"
#import "OYOMessageWare.h"


@interface OYOUITableView ()

@property (nonatomic, strong) UILabel *unQueryLabel;
@property (nonatomic, strong) OYOMessageWare *delegateProxy;
@property (nonatomic, strong) OYOMessageWare *dataSourceProxy;
@end

@implementation OYOUITableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self binding];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self binding];
    }
    return self;
}

- (void)initTableView {
//    OYOWeakSelf
//    kLazyLoad(_unQueryLabel, {
//        _unQueryLabel = Label.string(@"暂无数据").withFont(kFontLight(14)).color(@"#666666").centerAlignment;
//        [self addSubview:_unQueryLabel];
//        [_unQueryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            OYOStrongSelf
//            make.centerX.equalTo(self);
//        }];
//        _unQueryLabel;
//    });
}

- (void)binding {
    [super setDelegate:(id<UITableViewDelegate>)self.delegateProxy];
    [super setDataSource:(id<UITableViewDataSource>)self.dataSourceProxy];
    self.tableFooterView = [UIView new];
    
//    OYOWeakSelf
//    [[RACObserve(self, models) skip:1] subscribeNext:^(id  _Nullable x) {
//        OYOStrongSelf
//        if (self.mj_header.isRefreshing) {
//            [self.mj_header endRefreshing];
//        }
//        if (self.mj_footer.isRefreshing) {
//            [self.mj_footer endRefreshing];
//        }
//        [self reloadData];
//    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id obj = self.models[section];
    if ([obj isKindOfClass:[NSArray class]]) {
        return [obj count];
    }
    return 1;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<OMCellModel> *cellModel = [self cellModelAtIndexPath:indexPath];
    if(self.tableViewCellIdentifier) {
        cellModel.cellClass = self.tableViewCellIdentifier;
        return [self.tableViewCellIdentifier cellForTableView:tableView cellModel:cellModel];
    }
    return [cellModel.cellClass cellForTableView:tableView cellModel:cellModel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<OMCellModel> *cellModel = [self cellModelAtIndexPath:indexPath];
    return cellModel.cellHeight.doubleValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<OMCellModel> *cellModel = [self cellModelAtIndexPath:indexPath];
//    [self.didSelectCommand execute:RACTuplePack(tableView, indexPath, cellModel)];
}

#pragma mark - Private
- (NSObject<OMCellModel> *)cellModelAtIndexPath:(NSIndexPath *)indexPath {
    id obj = self.models[indexPath.section];
    if ([obj isKindOfClass:[NSArray class]] && ((NSArray*)obj).count>0) {
        return [obj objectAtIndex:indexPath.row];
    } else {
        return obj;
    }
}

#pragma mark - Getter && Setter
//- (void)setRefreshCommand:(RACCommand *)refreshCommand {
//    _refreshCommand = refreshCommand;
//    @weakify(self);
//    MJRefreshHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        @strongify(self);
//        [self.refreshCommand execute:nil];
//    }];
//    self.mj_header = header;
//}
//
//- (void)setLoadMoreCommand:(RACCommand *)loadMoreCommand {
//    _loadMoreCommand = loadMoreCommand;
//    @weakify(self);
//    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
//        @strongify(self);
//        [self.loadMoreCommand execute:nil];
//    }];
//    self.mj_footer = footer;
//}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    self.delegateProxy.middleman = delegate;
    [super setDelegate:(id<UITableViewDelegate>)self.delegateProxy];
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    self.dataSourceProxy.middleman = dataSource;
    [super setDataSource:(id<UITableViewDataSource>)self.dataSourceProxy];
}

- (OYOMessageWare *)delegateProxy {
    if (!_delegateProxy) {
        _delegateProxy = [[OYOMessageWare alloc] init];
        _delegateProxy.receiver = self;
    }
    return _delegateProxy;
}

- (OYOMessageWare *)dataSourceProxy {
    if (!_dataSourceProxy) {
        _dataSourceProxy = [[OYOMessageWare alloc] init];
        _dataSourceProxy.receiver = self;
    }
    return _dataSourceProxy;
}

@end
