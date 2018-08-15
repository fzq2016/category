//
//  OYOCalendarView.h
//  OYOConsumer
//
//  Created by zhanglei on 2018/7/18.
//  Copyright © 2018 www.oyohotels.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OYOCalendarViewDayModel : NSObject

@property (nonatomic, assign) NSInteger year;//年

@property (nonatomic, assign) NSInteger month;//月

@property (nonatomic, assign) NSUInteger day;//第几天

@property (nonatomic, assign) NSUInteger week;//周几

@property (nonatomic, assign) NSUInteger dayNo;//月第一天序号

- (instancetype)initWithDate:(NSDate *)date;

@end

@interface OYOCalendarViewDateRange : NSObject

@property (strong, nonatomic) OYOCalendarViewDayModel * checkin;

@property (strong, nonatomic) OYOCalendarViewDayModel * checkout;

@property (assign, nonatomic) NSUInteger rangeLimit;

@property (assign, nonatomic) NSUInteger availableLimit;

@end

typedef NS_ENUM(NSUInteger, OYOCalendarViewType) {
    OYOCalendarViewTypeDateRange,
};

@protocol OYOCalendarViewDelegate<NSObject>

- (void)didCalendarViewCompletedWithType:(OYOCalendarViewType)viewType withData:(id)data;

@end

@interface OYOCalendarView : UIView

@property (weak, nonatomic) id<OYOCalendarViewDelegate> delegate;

- (instancetype)initWithType:(OYOCalendarViewType)viewType WithData:(id)data;

@end
