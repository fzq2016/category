//
//  OYOUITableView.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/5.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+OM.h"
#import "UITableViewCell+OM.h"
#import "MJRefresh.h"

@interface OYOUITableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *models;

//@property (nonatomic, strong) RACCommand *refreshCommand;
//@property (nonatomic, strong) RACCommand *loadMoreCommand;
//@property (nonatomic, strong) RACCommand *didSelectCommand;

@property (nonatomic, strong) Class<OMTableViewCell> tableViewCellIdentifier;

@end
