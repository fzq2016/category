//
//  OYOCalendarView.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/18.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "OYOCalendarView.h"

#define OYOCalendarViewFlowLayoutMinInterItemSpacing  0.0
#define OYOCalendarViewFlowLayoutMinLineSpacing  5.0
#define OYOCalendarViewFlowLayoutInsetTop  5.0
#define OYOCalendarViewFlowLayoutInsetLeft  5.0
#define OYOCalendarViewFlowLayoutInsetBottom  5.0
#define OYOCalendarViewFlowLayoutInsetRight 5.0

#define OYOCalendarViewWeekHeight  33
#define OYOCalendarViewMonthHeight 33
#define OYOCalendarViewOnceLimit   210

@class OYOCalendarViewCell;
@class OYOCalendarViewMonthView;


@interface OYOCalendarViewMonthModel : NSObject

@property (nonatomic, assign) NSInteger year;//年

@property (nonatomic, assign) NSInteger month;//月

@property (nonatomic, assign) NSUInteger days;//月总天数

@property (nonatomic, assign) NSUInteger firstDayWeek;//月第一天星期几

@property (nonatomic, assign) NSUInteger firstDayNo;//月第一天序号

@end

@implementation OYOCalendarViewMonthModel

@end

@implementation OYOCalendarViewDayModel

- (instancetype)initWithDate:(NSDate *)date{
    self = [super init];
    if (self) {
        NSCalendar * calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        self.year = dateComponents.year;
        self.month = dateComponents.month;
        self.day = dateComponents.day;
        self.week = dateComponents.weekday;
    }
    return self;
}

@end

typedef NS_ENUM(NSUInteger, OYOCalendarViewCellMode) {
    OYOCalendarViewCellModeDefault,
    OYOCalendarViewCellModeHidden,
    OYOCalendarViewCellModePast,
    OYOCalendarViewCellModeFuture,
    OYOCalendarViewCellModeToday,
    OYOCalendarViewCellModeCheckin,
    OYOCalendarViewCellModeCheckout,
    OYOCalendarViewCellModeBetween,
};


@interface OYOCalendarViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView * backgroudImageView;

@property (strong, nonatomic) UILabel * titleLabel;

@property (strong, nonatomic) UILabel * descLabel;

@property (assign, nonatomic) OYOCalendarViewCellMode cellMode;

@end

@implementation OYOCalendarViewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutCustomViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutCustomViews];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self layoutCustomViews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    self.backgroudImageView.frame = self.bounds;
    self.descLabel.frame = CGRectMake(0, self.frame.size.height/3*2, self.frame.size.width, self.frame.size.height/3);
}

- (void)layoutCustomViews{
    [self addSubview:self.backgroudImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
}

#pragma mark - Getter

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0  blue:51/255.0  alpha:1];
        
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.font = [UIFont systemFontOfSize:9 weight:UIFontWeightLight];
        _descLabel.textColor = [UIColor whiteColor];
    }
    return _descLabel;
}

- (UIImageView *)backgroudImageView{
    if (!_backgroudImageView) {
        _backgroudImageView = [[UIImageView alloc]init];
    }
    return _backgroudImageView;
}

- (void)setCellMode:(OYOCalendarViewCellMode)cellMode{
    _cellMode = cellMode;
    switch (cellMode) {
        case OYOCalendarViewCellModeDefault:
        {
            self.hidden = NO;
            _titleLabel.hidden = NO;
            _backgroudImageView.hidden = YES;
            _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0  blue:51/255.0  alpha:1];
            _descLabel.hidden = YES;
        }
            break;
        case OYOCalendarViewCellModePast:
        {
            self.hidden = NO;
            _titleLabel.hidden = NO;
            _titleLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0  blue:204/255.0  alpha:1];
            _backgroudImageView.hidden = YES;
            _descLabel.hidden = YES;
        }
            break;
        case OYOCalendarViewCellModeFuture:
        {
            self.hidden = NO;
            _titleLabel.hidden = NO;
            _titleLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0  blue:204/255.0  alpha:1];
            _backgroudImageView.hidden = YES;
            _descLabel.hidden = YES;
        }
            break;
        case OYOCalendarViewCellModeToday:
        {
            self.hidden = NO;
            _titleLabel.hidden = NO;
            _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0  blue:51/255.0  alpha:1];
            _titleLabel.text = @"今天";
            _backgroudImageView.hidden = YES;
            _descLabel.hidden = YES;
        }
            break;
        case OYOCalendarViewCellModeHidden:
        {
            self.hidden = YES;
            _titleLabel.hidden = YES;
            _backgroudImageView.hidden = YES;
            _descLabel.hidden = YES;
        }
            break;
        case OYOCalendarViewCellModeCheckin:
        {
            self.hidden = NO;
            _titleLabel.hidden = NO;
            _titleLabel.textColor = [UIColor whiteColor];
            _backgroudImageView.hidden = NO;
//            _backgroudImageView.backgroundColor = [UIColor colorWithRed:227/255.0 green:69/255.0 blue:73/255.0 alpha:1];
            _backgroudImageView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:247/255.0 alpha:1];
            _backgroudImageView.image = [UIImage imageNamed:@"checkin_bg"];
            _descLabel.hidden = NO;
            _descLabel.text = @"入住";
        }
            break;
        case OYOCalendarViewCellModeCheckout:
        {
            self.hidden = NO;
            _titleLabel.hidden = NO;
            _titleLabel.textColor = [UIColor whiteColor];
            _backgroudImageView.hidden = NO;
//            _backgroudImageView.backgroundColor = [UIColor colorWithRed:227/255.0 green:69/255.0 blue:73/255.0 alpha:1];
            _backgroudImageView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:247/255.0 alpha:1];
            _backgroudImageView.image = [UIImage imageNamed:@"checkout_bg"];
            _descLabel.hidden = NO;
            _descLabel.text = @"退房";
        }
            break;
        case OYOCalendarViewCellModeBetween:
        {
            self.hidden = NO;
            _titleLabel.hidden = NO;
            _backgroudImageView.hidden = NO;
            _backgroudImageView.image = nil;
            _backgroudImageView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:247/255.0 alpha:1];
            _descLabel.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

@end

@interface OYOCalendarViewMonthView : UICollectionReusableView

@property (strong, nonatomic) UILabel * titleLabel;

@end

@implementation OYOCalendarViewMonthView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutCustomViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutCustomViews];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self layoutCustomViews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

- (void)layoutCustomViews{
    
    [self addSubview:self.titleLabel];
}


#pragma mark - Getter

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    }
    return _titleLabel;
}

@end


@interface OYOCalendarViewDateRange ()

@property (strong, nonatomic) OYOCalendarViewDayModel * end;

@property (strong, nonatomic) OYOCalendarViewDayModel * begin;

@property (assign, nonatomic) BOOL bSelected;

@end

@implementation OYOCalendarViewDateRange

#pragma mark - Getter

- (OYOCalendarViewDayModel *)checkin{
    if (!_checkin) {
        _checkin = [[OYOCalendarViewDayModel alloc]initWithDate:[NSDate date]];
    }
    return _checkin;
}

- (OYOCalendarViewDayModel *)checkout{
    if (!_checkout) {
        _checkout = [[OYOCalendarViewDayModel alloc]initWithDate:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]+24*60*60]];
    }
    return _checkout;
}

- (OYOCalendarViewDayModel *)begin{
    if (!_begin) {
        _begin = [[OYOCalendarViewDayModel alloc]initWithDate:[NSDate date]];
    }
    return _begin;
}

- (OYOCalendarViewDayModel *)end{
    if (!_end) {
        _end = [[OYOCalendarViewDayModel alloc]initWithDate:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]+self.availableLimit*60*60]];
    }
    return _end;
}

@end



@interface OYOCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView * collectionView;

@property (strong, nonatomic) UIStackView * stackView;

@property (strong, nonatomic) NSMutableArray * datas;

@property (assign, nonatomic) NSTimeInterval currentTimestamp;

@property (assign, nonatomic) NSUInteger totalDays;

@property (strong, nonatomic) OYOCalendarViewDateRange * dateRange;

@property (assign, nonatomic) OYOCalendarViewType viewType;

@property (strong, nonatomic) OYOCalendarViewDayModel * today;

@property (strong, nonatomic) UILabel * toastLabel;

@property (strong, nonatomic) UIImageView * nightImageView;

@property (strong, nonatomic) UILabel * nightLabel;

@end


@implementation OYOCalendarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc]init];
    }
    return _datas;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutCustomViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutCustomViews];
    }
    return self;
}

- (instancetype)initWithType:(OYOCalendarViewType)viewType WithData:(id)data{
    self = [self init];
    self.viewType = viewType;
    switch (_viewType) {
        case OYOCalendarViewTypeDateRange:
        {
            if (data && [data isKindOfClass:OYOCalendarViewDateRange.class]) {
                self.dateRange = data;
            }
        }
            break;
            
        default:
            break;
    }
    [self loadDateRange];
    [self.collectionView reloadData];
    
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self layoutCustomViews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.stackView.frame = CGRectMake(0, 0, self.frame.size.width, OYOCalendarViewWeekHeight);
    self.collectionView.frame = CGRectMake(0, OYOCalendarViewWeekHeight, self.frame.size.width, self.frame.size.height-OYOCalendarViewWeekHeight);
    self.toastLabel.frame = CGRectMake(100, self.frame.size.height - 88, self.frame.size.width-200, 44);
    self.nightImageView.frame = self.nightLabel.frame;
}

- (void)layoutCustomViews{
    [self addSubview:self.collectionView];
    [self addSubview:self.stackView];
    [self addSubview:self.toastLabel];
    [self addSubview:self.nightImageView];
    [self addSubview:self.nightLabel];
}

- (void)loadData{
    
    NSDate * date  = nil;
    
    if (self.datas.count == 0) {
        
        date = [NSDate date];
        self.currentTimestamp = [date timeIntervalSince1970];
    }
    else{
        date = [NSDate dateWithTimeIntervalSince1970:self.currentTimestamp+(_totalDays-_today.day+1)*24*60*60];
    }
    
    [self.datas addObjectsFromArray:[self getDataWithDate:date andAvailableDays:OYOCalendarViewOnceLimit]];
}

- (void)loadDateRange{
    for (NSUInteger i=0; i <self.datas.count; ++i) {
        
        OYOCalendarViewMonthModel * monthModel = self.datas[i];
        
        for (NSUInteger j=1; j<=monthModel.days; ++j) {
            
            NSUInteger dayNo = monthModel.firstDayNo +j;
            
            if (monthModel.year == self.dateRange.begin.year && monthModel.month == self.dateRange.begin.month && j == self.dateRange.begin.day) {
                self.dateRange.begin.dayNo = dayNo;
                self.dateRange.end = [[OYOCalendarViewDayModel alloc]init];
                self.dateRange.end.dayNo = self.dateRange.begin.dayNo +self.dateRange.availableLimit;
            }
            if (monthModel.year == self.today.year && monthModel.month == self.today.month && j == self.today.day) {
                self.today.dayNo = dayNo;
            }
            if (monthModel.year == self.dateRange.checkin.year && monthModel.month == self.dateRange.checkin.month && j == self.dateRange.checkin.day) {
                self.dateRange.checkin.dayNo = dayNo;
            }
            if (monthModel.year == self.dateRange.checkout.year && monthModel.month == self.dateRange.checkout.month && j == self.dateRange.checkout.day) {
                self.dateRange.checkout.dayNo = dayNo;
            }
        }
    }
}

- (NSArray *)getDataWithDate:(NSDate *)date andAvailableDays:(NSUInteger)days{
    
    NSMutableArray * datas = [[NSMutableArray alloc]init];
    
    NSUInteger totalAvailableDays = 0;
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    OYOCalendarViewMonthModel * monthModel = [[OYOCalendarViewMonthModel alloc]init];
    
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    
    
    monthModel.year = dateComponents.year;
    
    monthModel.month = dateComponents.month;
    
    NSInteger firstDayWeek = dateComponents.weekday-dateComponents.day%7;
    
    monthModel.firstDayWeek = firstDayWeek>=0?firstDayWeek:firstDayWeek+7;
    
    monthModel.firstDayNo = _totalDays;
    
    monthModel.days = [self getDaysInYear:monthModel.year month:monthModel.month];
    
    totalAvailableDays = monthModel.days - dateComponents.day+1;
    _totalDays += monthModel.days;
    
    [datas addObject:monthModel];
    
    OYOCalendarViewMonthModel * tmp = monthModel;
    
    while (totalAvailableDays < days) {
        
        OYOCalendarViewMonthModel * tmp2 = [[OYOCalendarViewMonthModel alloc]init];
        
        tmp2.year = tmp.year;
        
        tmp2.month = tmp.month;
        
        if (tmp.month == 12) {

            tmp2.month = 1;

            tmp2.year = tmp.year+1;
        }
        else{

            tmp2.month = tmp.month+1;

            tmp2.year = tmp.year;
        }
        
        tmp2.firstDayWeek = (tmp.firstDayWeek+tmp.days)%7;
        tmp2.firstDayNo = _totalDays;
        
        tmp2.days = [self getDaysInYear:tmp2.year month:tmp2.month];
        
        [datas addObject:tmp2];
        
        totalAvailableDays += days - totalAvailableDays >tmp2.days?tmp2.days:days - totalAvailableDays;
        
        _totalDays += tmp2.days;
        
        tmp = tmp2;
        
    }
    
    return datas;
    
}

- (NSInteger)getDaysInYear:(NSInteger)year month:(NSInteger)month {
    if((month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12))
        return 31;
    if((month == 4)||(month == 6)||(month == 9)||(month == 11))
        return 30;
    if ((year % 4  == 0 && year % 100 != 0)  || year % 400 == 0)
        return 29;
    else
        return 28;
}

#pragma mark - Getter

- (OYOCalendarViewDayModel *)today{
    if (!_today) {
        _today = [[OYOCalendarViewDayModel alloc]initWithDate:[NSDate date]];
    }
    return _today;
}

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc]init];
//        _stackView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:247/255.0 alpha:1];
        _stackView.distribution = UIStackViewDistributionFillEqually;
        
        NSDictionary * dic = @{@"0":@"日",@"1":@"一",@"2":@"二",@"3":@"三",@"4":@"四",@"5":@"五",@"6":@"六"};
        
        for (int i = 0; i<7; i++) {
            UILabel * label = [[UILabel alloc]init];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            label.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:247/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:13];
            label.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@(i).stringValue]];
            [_stackView addArrangedSubview:label];
        }
        
    }
    return _stackView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = OYOCalendarViewFlowLayoutMinInterItemSpacing;
        layout.minimumLineSpacing = OYOCalendarViewFlowLayoutMinLineSpacing;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(OYOCalendarViewFlowLayoutInsetTop,
                                               OYOCalendarViewFlowLayoutInsetLeft,
                                               OYOCalendarViewFlowLayoutInsetBottom,
                                               OYOCalendarViewFlowLayoutInsetRight);
        layout.headerReferenceSize = CGSizeMake(0, OYOCalendarViewMonthHeight);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:NSClassFromString(@"OYOCalendarViewCell") forCellWithReuseIdentifier:@"OYOCalendarViewCell"];
        [_collectionView registerClass:NSClassFromString(@"OYOCalendarViewMonthView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"OYOCalendarViewMonthView"];
        [self loadData];
        [self loadDateRange];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (OYOCalendarViewDateRange *)dateRange{
    if (!_dateRange) {
        _dateRange = [[OYOCalendarViewDateRange alloc]init];
        _dateRange.rangeLimit = 210;
        _dateRange.availableLimit = 210;
    }
    return _dateRange;
}

- (UILabel *)toastLabel{
    if (!_toastLabel) {
        _toastLabel = [[UILabel alloc]init];
        _toastLabel.textAlignment = NSTextAlignmentCenter;
        _toastLabel.text = @"请选择入住日期";
        _toastLabel.textColor = [UIColor whiteColor];
        _toastLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightLight];
        _toastLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _toastLabel.layer.cornerRadius = 22;
        _toastLabel.layer.masksToBounds = YES;
    }
    return _toastLabel;
}

- (UILabel *)nightLabel{
    if (!_nightLabel) {
        _nightLabel = [[UILabel alloc]init];
        _nightLabel.textAlignment = NSTextAlignmentCenter;
        _nightLabel.textColor = [UIColor whiteColor];
        _nightLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightLight];
    }
    return _nightLabel;
}

- (UIImageView *)nightImageView{
    if (!_nightImageView) {
        _nightImageView = [[UIImageView alloc]init];
        _nightImageView.image = [UIImage imageNamed:@"calendar_night_bg"];
    }
    return _nightImageView;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    OYOCalendarViewMonthModel * monthModel = self.datas[section];
    return monthModel.firstDayWeek+monthModel.days;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OYOCalendarViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OYOCalendarViewCell" forIndexPath:indexPath];
    
    OYOCalendarViewMonthModel * monthModel = self.datas[indexPath.section];
    
    NSUInteger day = indexPath.item+1 -monthModel.firstDayWeek;
    
    NSUInteger dayNo = monthModel.firstDayNo+day;
    
    cell.titleLabel.text = [[NSString alloc]initWithFormat:@"%ld",day];
    
    cell.cellMode = OYOCalendarViewCellModeDefault;
    
    if (indexPath.item<monthModel.firstDayWeek) {
        cell.cellMode = OYOCalendarViewCellModeHidden;
    }
    else{

        if (dayNo < self.dateRange.begin.dayNo) {
            cell.cellMode = OYOCalendarViewCellModePast;
        }

        if (dayNo == self.today.dayNo) {
            cell.cellMode = OYOCalendarViewCellModeToday;
        }

        if (dayNo > self.dateRange.end.dayNo) {
            cell.cellMode = OYOCalendarViewCellModeFuture;
        }

        if (dayNo == self.dateRange.checkin.dayNo) {
            cell.cellMode = OYOCalendarViewCellModeCheckin;
        }

        if (dayNo == self.dateRange.checkout.dayNo) {
            cell.cellMode = OYOCalendarViewCellModeCheckout;
        }
        
        if (!self.dateRange.bSelected) {
            if (dayNo < self.dateRange.checkout.dayNo && dayNo > self.dateRange.checkin.dayNo) {
                cell.cellMode = OYOCalendarViewCellModeBetween;
            }
        }
        
        
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        OYOCalendarViewMonthView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"OYOCalendarViewMonthView" forIndexPath:indexPath];
        OYOCalendarViewMonthModel * monthModel = self.datas[indexPath.section];
        view.titleLabel.text = [NSString stringWithFormat:@"%ld年%ld月",monthModel.year,monthModel.month];
        return view;
    }
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((collectionView.zq_width - 10) / 7, (collectionView.zq_width - 10) / 7);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == self.datas.count -1) {
        
        [self loadData];
        [self loadDateRange];
        
        NSIndexSet * indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.section+1, self.datas.count-indexPath.section-1)];

        [collectionView insertSections:indexSet];
        
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    OYOCalendarViewCell * cell = (OYOCalendarViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ( cell.cellMode == OYOCalendarViewCellModeHidden|| cell.cellMode == OYOCalendarViewCellModePast || cell.cellMode == OYOCalendarViewCellModeFuture ) {
        return NO;
    }
    else{
        return YES;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OYOCalendarViewMonthModel * monthModel = self.datas[indexPath.section];
    
    NSUInteger day = indexPath.item+1 -monthModel.firstDayWeek;
    
    NSUInteger dayNo = monthModel.firstDayNo+day;
    
    if (self.dateRange.bSelected && dayNo <= self.dateRange.checkin.dayNo) {
        self.dateRange.bSelected = NO;
    }
    
    if (self.dateRange.bSelected) {
        
        UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
        
        
        CGRect rect = [collectionView convertRect:cell.frame toView:self];
        
        NSUInteger days = dayNo - self.dateRange.checkin.dayNo;
        
        self.nightLabel.text = [NSString stringWithFormat:@"%ld晚",days];
        self.nightLabel.frame = CGRectMake(rect.origin.x, rect.origin.y-44, rect.size.width, 30);
        self.nightImageView.frame = CGRectMake(rect.origin.x, rect.origin.y-44, rect.size.width, 44);
        if (days > self.dateRange.rangeLimit) {
        }else {
            self.dateRange.bSelected = NO;
            self.dateRange.checkout = [[OYOCalendarViewDayModel alloc]init];
            self.dateRange.checkout.year = monthModel.year;
            self.dateRange.checkout.month = monthModel.month;
            self.dateRange.checkout.day = day;
            self.dateRange.checkout.dayNo = dayNo;

            [self.collectionView reloadData];
            
            if (_delegate && [_delegate respondsToSelector:@selector(didCalendarViewCompletedWithType:withData:)]) {
                [_delegate didCalendarViewCompletedWithType:_viewType withData:self.dateRange];
            }
        }
        
        
    }
    else{
        self.dateRange.bSelected = YES;
        
        self.dateRange.checkin = [[OYOCalendarViewDayModel alloc]init];
        self.dateRange.checkin.year = monthModel.year;
        self.dateRange.checkin.month = monthModel.month;
        self.dateRange.checkin.day = day;
        self.dateRange.checkin.dayNo = dayNo;
        self.dateRange.checkout = nil;
        self.toastLabel.text = @"请选择退房日期";
        [self.collectionView reloadData];
    }
    
}

@end




