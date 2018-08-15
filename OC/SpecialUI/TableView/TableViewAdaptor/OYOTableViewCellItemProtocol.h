//
//  OYOTableViewCellItemProtocol.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/24.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OYOGroupedCellPositon) {
    OYOGroupedCellPositonNone,        //分割线的缩进位置
    OYOGroupedCellPositonFirst,
    OYOGroupedCellPositonMiddle,
    OYOGroupedCellPositonLast
};

typedef void(^OYOEventBlock)(id object);

@protocol OYOTableViewCellItemProtocol <NSObject>


@required
/*!
 @property
 @abstract  cell 的类
 */
@property (nonatomic, strong) Class cellClass;

/*!
 @property
 @abstract  cell类型
 */
@property (nonatomic, copy)   NSString *cellType;

/*!
 @property
 @abstract  cell高度
 */
@property (nonatomic, strong) NSNumber *cellHeight;

@optional
/*!
 @property
 @abstract  cell响应对象
 */
@property (nonatomic, assign) id cellSelResponse;
/*!
 @property
 @abstract  cell数据源tag标识
 */
@property (nonatomic, assign) int cellTag;

/*!
 @property
 @abstract  cell event block
 */
@property (nonatomic, copy) OYOEventBlock eventBlock;
/*!
 @property
 @abstract  cell的位置，用于指示画线类型， 默认是OYOGroupedCellPositonMiddle
 */
@property (nonatomic, assign) OYOGroupedCellPositon groupedCellPostion;

/*!
 @property
 @abstract  cell上下边线的缩进值
 */
@property (nonatomic, strong) NSNumber *lineIndent;
@property (nonatomic, strong) NSNumber *lineWidth;

@property (nonatomic, assign) BOOL useNib;


@end
