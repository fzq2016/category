//
//  NSObject+OM.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/5.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCell+OM.h"

@protocol OMCellModel <NSObject>

@optional
/**
 绑定 model 对应需要显示的 CellClass
 */
@property (nonatomic, unsafe_unretained) Class<OMTableViewCell> cellClass;

/**
 缓存 cell 的高度，为 nil 时会调用 [cellClass cellHeightForCellModel:self]
 */
@property (nonatomic, strong) NSNumber *cellHeight;

@end

@interface NSObject (OM)

@end
