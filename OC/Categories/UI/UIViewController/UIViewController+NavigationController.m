//
//  UIViewController+NavigationController.m
//  OYOConsumer
//
//  Created by neo on 2018/7/10.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "UIViewController+NavigationController.h"
#import <objc/runtime.h>

#define kNavigationTitleSize 18
#define kNavigationSubTitleSize 14.0f
#define kNavigationBarColor [UIColor whiteColor]
#define kNavigationBarTextColor [UIColor blackColor]

@interface UIViewController(Private)

@property (nonatomic, assign) BOOL isHideCustomStatusbar;

- (void)onBackNavigation;

@end
@implementation UIViewController (NavigationController)

//const void *transferKey = (void*)@"Transfer";

static char rightNavItemkey;
static char midNavItemkey;
static char leftNavItemkey;

- (UINavigationBar *)navigationBar{
    if (!objc_getAssociatedObject(self, _cmd))
    {
        UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame: CGRectZero];
        //nav.translucent = false;
        nav.shadowImage = nil;
        //nav.shadowImage = [UIImage new];
        nav.backgroundColor = kNavigationBarColor;
        [nav setBackgroundImage:[UIImage imageWithColor:kNavigationBarColor] forBarMetrics:UIBarMetricsDefault];
        objc_setAssociatedObject(self, @selector(navigationBar), nav, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        nav.userInteractionEnabled = true;
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNavigationBar:(UINavigationBar *)navigationBar{
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isHideCustomStatusbar{
    return OYOBool(objc_getAssociatedObject(self, _cmd));
}

- (void)setIsHideCustomStatusbar:(BOOL)isHideCustomStatusbar{
    objc_setAssociatedObject(self, @selector(isHideCustomStatusbar), @(isHideCustomStatusbar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)navigateWhite:(BOOL)isSystem{
    [self setNavColor: [UIColor whiteColor] system:isSystem];
    // [self targetNavigationBar].alpha = 1;
    [self showNavigationShadow:isSystem];
}

- (void)navigateClear:(BOOL)isSystem{
    [self setNavColor: [UIColor clearColor] system:isSystem];
    //[self targetNavigationBar].alpha = 0;
    [self hiddenNavigationShadow:isSystem];
}

- (void)setNavColor:(UIColor *)navColor system:(BOOL)isSystem{
    if (isSystem) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
        return;
    }
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavHeight:(NSInteger)navHeight
{
    if (navHeight == 64 || (isIPHONE_X && navHeight == kNavStausHeight)) {
        [[self targetNavigationBar] setShadowImage:nil];
    }
}

- (void)hiddenNavigationShadow:(BOOL)isSystem{
    if (isSystem) {
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        return;
    }
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)showNavigationShadow:(BOOL)isSystem{
    if (isSystem) {
        [self.navigationController.navigationBar setShadowImage:nil];
        return;
    }
    [self.navigationBar setShadowImage:nil];
}

- (BOOL)isSystemNavigation{
    return OYOBool(objc_getAssociatedObject(self, _cmd));
}

- (void)setIsSystemNavigation:(BOOL)isSystemNavigation{
    objc_setAssociatedObject(self, @selector(isSystemNavigation), @(isSystemNavigation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTransfer:(NSObject *)transfer
{
    objc_setAssociatedObject(self, @selector(transfer), transfer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSObject *)transfer
{
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)isSameNavigation{
    return self.navigationController == self.tabBarController.navigationController;
}

- (void)setNavigationItems{
    [self targetNavigationBar].items = @[[self getNavigationItem]];
}

- (void)addCustomNavigationBar{
    if (![self.navigationBar isDescendantOfView:self.view]) {
        if (!self.isHideCustomStatusbar) {
            UIView *topStatusBar = [UIView new];
            topStatusBar.backgroundColor = self.navigationBar.backgroundColor;
            [self.view insertSubview:topStatusBar atIndex:998];
            [topStatusBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(self.view);
                make.height.mas_equalTo(kStatusHeight);
            }];
        }
        [@[self.navigationBar] enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.view insertSubview:view atIndex:999];
        }];
        [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusHeight);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(kNavHeight);
        }];
    }
}

- (UINavigationBar *)targetNavigationBar{
    if (self.isSystemNavigation) {
        return self.navigationController.navigationBar;
    }
    return self.navigationBar;
}

- (UINavigationItem *)getNavigationItem{
    if (self.isSystemNavigation) {
        return self.navigationItem;
    }
    if (!objc_getAssociatedObject(self, _cmd))
    {
        UINavigationItem *navItem = [[UINavigationItem alloc] init];
        objc_setAssociatedObject(self, @selector(getNavigationItem), navItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return navItem;
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNavigationLeftNil
{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    self.navigationItem.leftBarButtonItem = nil;
    // self.tabBarController.navigationItem.hidesBackButton = true;
}

- (void)setNavigationLeftVest:(LeftNavigationItemBlock)block
{
    if (self.isSystemNavigation) {
        return;
    }
    self.navigationItem.hidesBackButton = YES;
    SEL selector;
    if (block) {
        selector = @selector(onClickLeft:);
    }else{
        selector = @selector(onBackNavigation);
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"      " style:UIBarButtonItemStylePlain target:self action:selector];
}

- (void)setNavigationRightVest:(LeftNavigationItemBlock)block
{
    if (self.isSystemNavigation) {
        return;
    }
    if (block) {
        SEL selector;
        selector = @selector(onClickRight:);
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"      " style:UIBarButtonItemStylePlain target:self action:selector];
    }
}

- (void)setNavigationLeftItemWithBlock:(LeftNavigationItemBlock)block
{
    objc_setAssociatedObject(self, &leftNavItemkey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIImage *normal = [UIImage imageNamed:@"navigation_back"];
    UIImage *selected = [UIImage imageNamed:@"navigation_back"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];;
    [btn setImage:normal forState:UIControlStateNormal];
    [btn setImage:selected forState:UIControlStateHighlighted];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [btn addTarget:self action:@selector(onClickLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    buttonItem.enabled = true;
    [self getNavigationItem].leftBarButtonItem = buttonItem;
    [self getNavigationItem].leftBarButtonItem.tintColor = kNavigationBarColor;
    [self addCustomNavigationBar];
    [self setNavigationLeftVest:block];
}

- (void)setDefaultNavigationLeftItem
{
    [self setDefaultNavigationLeftItemWithOffset:0];
}

- (void)setNavigationClearBack
{
    self.isHideCustomStatusbar = true;
    [self setDefaultNavigationLeftItemWithOffset:0];
    [self hiddenNavigationShadow:false];
    [self navigateClear:false];
    self.navigationBar.backgroundColor = [UIColor clearColor];
    [self setNavigationLeftNil];
}

- (void)setNavigationClearBackTitle:(NSString *)title
{
    [self setNavigationClearBack];
    [self setNavigationTitle: title];
}

- (void)setDefaultNavigationLeftItemWithOffset:(CGFloat)offset
{
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigation_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onBackNavigation)];
    [backBarButtonItem setBackgroundVerticalPositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    //左右占位偏移的buttonItem
    //    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    fixedSpace.width = 0;
    [self getNavigationItem].leftBarButtonItems = @[backBarButtonItem];
    if (!self.isSystemNavigation) {
        [self setNavigationLeftVest:nil];
        [self setNavigationItems];
    }
    backBarButtonItem.enabled = true;
    [self addCustomNavigationBar];
}

- (void)setNavigationLeftItem:(NSString*)text block:(LeftNavigationItemBlock)block
{
    objc_setAssociatedObject(self, &leftNavItemkey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    SEL selector = nil;
    if (block != nil) {
        selector = @selector(onClickLeft:);
    }
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:text style:UIBarButtonItemStylePlain target:self action:selector];
    
    [self getNavigationItem].leftBarButtonItem = buttonItem;
    [self getNavigationItem].leftBarButtonItem.tintColor = kNavigationBarTextColor;
    [self addCustomNavigationBar];
    [self setNavigationLeftVest:block];
}

- (void)setNavigationLeftItem:(NSString*)text
{
    [self setNavigationLeftItem:text block:nil];
}

- (void)setNavigationLeftItem:(UIImage*)normal selected:(UIImage*)selected
{
    [self setNavigationLeftItem:normal selected:selected block:nil];
}

- (void)setNavigationLeftItemWithImage:(UIImage *)normal block:(RightNavigationItemBlock)block
{
    [self setNavigationLeftItemWithImage:normal adjustmentOffset:0 block:block];
}

- (void)setNavigationLeftItem:(UIImage *)normal selected:(UIImage*)selected block:(LeftNavigationItemBlock)block
{
    objc_setAssociatedObject(self, &leftNavItemkey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];;
    [leftBtn setImage:normal forState:UIControlStateNormal];
    [leftBtn setImage:selected forState:UIControlStateHighlighted];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    if (block) {
        [leftBtn addTarget:self action:@selector(onClickLeft:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [leftBtn addTarget:self action:@selector(onBackNavigation) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [self getNavigationItem].leftBarButtonItem = buttonItem;
    [self getNavigationItem].leftBarButtonItem.tintColor = kNavigationBarColor;
    [self addCustomNavigationBar];
    [self setNavigationLeftVest:block];
}

- (void)setNavigationLeftItemWithImage:(UIImage *)normal adjustmentOffset:(CGFloat)offset block:(RightNavigationItemBlock)block
{
    objc_setAssociatedObject(self, &leftNavItemkey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onClickLeft:)];
    [leftBarButtonItem setBackgroundVerticalPositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -20;
    
    [self getNavigationItem].leftBarButtonItems = @[space, leftBarButtonItem];
    [self addCustomNavigationBar];
    [self setNavigationLeftVest:block];
}

- (void)setNavigationRightItemWithImage:(UIImage *)normal block:(RightNavigationItemBlock)block
{
    [self setNavigationRightItemWithImage:normal adjustmentOffset:0 block:block];
}

- (void)setNavigationRightItemWithImage:(UIImage *)normal adjustmentOffset:(CGFloat)offset block:(RightNavigationItemBlock)block
{
    objc_setAssociatedObject(self, &rightNavItemkey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onClickRight:)];
    [rightBarButtonItem setBackgroundVerticalPositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -5;
    [self setNavigationRightVest:block];
    [self getNavigationItem].rightBarButtonItems = @[space, rightBarButtonItem];
    [self addCustomNavigationBar];
}

- (void)setNavigationRightItem:(UIImage*)normal selected:(UIImage*)selected block:(RightNavigationItemBlock) block
{
    objc_setAssociatedObject(self, &rightNavItemkey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:normal forState:UIControlStateNormal];
    [btn setImage:selected forState:UIControlStateHighlighted];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [btn addTarget:self action:@selector(onClickRight:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self getNavigationItem].rightBarButtonItem = buttonItem;
    [self addCustomNavigationBar];
    [self setNavigationRightVest:block];
}

//设置右边按钮
- (void)setNavigationRightItem:(NSString*)text
{
    [self setNavigationRightItem:text block:nil];
}

- (void)setNavigationRightItem:(NSString*)text block:(RightNavigationItemBlock)block
{
    [self setNavigationRightItem:text font:nil tintColor:[UIColor blackColor] block:block];
}

- (void)setNavigationRightItem:(NSString*)text font:(UIFont*)font tintColor:(UIColor*)tintColor block:(RightNavigationItemBlock)block
{
    objc_setAssociatedObject(self, &rightNavItemkey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:text style:UIBarButtonItemStylePlain target:self action:@selector(onClickRight:)];
    buttonItem.enabled = (block != nil);
    [buttonItem setTintColor: tintColor];
    [self getNavigationItem].rightBarButtonItem = buttonItem;
    [self addCustomNavigationBar];
    [self setNavigationRightVest:block];
}

- (void)setNavigationTitle:(NSString *)title
{
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 18)];
    titleView.font = kFontMedium(kNavigationTitleSize);
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = title;
    titleView.textColor = kNavigationBarTextColor;
    [self getNavigationItem].titleView = titleView;
    [self setNavigationItems];
    if (!self.isSystemNavigation) {
        [self addCustomNavigationBar];
    }
}

/**
 *  指定navigationbar
 */
- (void)setNavigationTitle:(NSString *)title forNavBar:(UINavigationBar *)navBar
{
    [self setNavigationTitleBack:title forNavBar:navBar showBack:false];
}

- (void)setNavigationTitleBack:(NSString *)title forNavBar:(UINavigationBar *)navBar
{
    [self setNavigationTitleBack:title forNavBar:navBar showBack:true];
}

- (void)setNavigationRightItem:(NSString *)title rightText:(NSString *)rightStr block:(RightNavigationItemBlock)block showBack:(BOOL)isShow forNavBar:(UINavigationBar *)navBar
{
    navBar.zq_y = 0;
    objc_setAssociatedObject(self, &rightNavItemkey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 18)];
    titleView.font = kFont(kNavigationTitleSize);
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = title;
    titleView.textColor = kNavigationBarTextColor;
    titleView.backgroundColor = [UIColor clearColor];
    navItem.titleView = titleView;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn addTarget:self action:@selector(onClickRight:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:rightStr forState:UIControlStateNormal];
    [rightBtn setTitleColor:kHexRGB(0x646361) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFont(kNavigationTitleSize);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    navItem.rightBarButtonItems = @[rightItem];
    if (isShow){
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigation_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onBackNavigation)];
        [backItem setBackgroundVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpace.width = -5;
        navItem.leftBarButtonItems = @[fixedSpace, backItem];
    }
    
    navBar.items = @[navItem];
    [self addCustomNavigationBar];
}


- (void)setNavigationTitleBack:(NSString *)title forNavBar:(UINavigationBar *)navBar showBack:(BOOL)isShow
{
    navBar.zq_y = 0;
    UINavigationItem *titleItem = [[UINavigationItem alloc] init];
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 18)];
    titleView.font = kFont(kNavigationTitleSize);
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = title;
    titleView.textColor = kNavigationBarTextColor;
    titleView.backgroundColor = [UIColor clearColor];
    titleItem.titleView = titleView;
    if (isShow){
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigation_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onBackNavigation)];
        [backItem setBackgroundVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpace.width = -5;
        titleItem.leftBarButtonItems = @[fixedSpace, backItem];
    }
    navBar.backgroundColor = kNavigationBarColor;
    navBar.items = @[titleItem];
    [self setNavigationLeftVest:nil];
    [self addCustomNavigationBar];
}

- (void)setNavigationTitle:(NSString*)title subtitle:(NSString *)subtitle
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 34)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, -5, 100, 18)];
    titleView.font = kFont(kNavigationTitleSize);
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = title;
    titleView.textColor = kHexRGB(0x646361);
    
    UILabel *subTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, titleView.frame.origin.y + titleView.frame.size.height + 10, 100, 12)];
    subTitle.font = kFont(kNavigationSubTitleSize);
    subTitle.textAlignment = NSTextAlignmentCenter;
    subTitle.text = subtitle;
    subTitle.textColor = kHexRGB(0x646361);
    
    titleView.zq_height = subTitle.frame.origin.y + subTitle.frame.size.height;
    [view addSubview:titleView];
    [view addSubview:subTitle];
    [self getNavigationItem].titleView = view;
    [self addCustomNavigationBar];
}

- (void)setNavigationWithIcon:(NSString *)icon title:(NSString *)title{
    
}

- (void)onClickLeft:(id)sender
{
    LeftNavigationItemBlock block = objc_getAssociatedObject(self, &leftNavItemkey);
    if (block) {
        block();
    }
}

- (void)onClickRight:(id)sender
{
    RightNavigationItemBlock block = objc_getAssociatedObject(self, &rightNavItemkey);
    if (block) {
        block();
    }
}

- (void)onClickMidden:(id)sender
{
    MiddleNavigationItemBlock block = objc_getAssociatedObject(self, &midNavItemkey);
    if (block) {
        block();
    }
}

- (void)onBackNavigation
{
    if ([self.navigationController.viewControllers count] > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(float)heightOfNavAndStatusBar
{
    return self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //用UIImagePickerController会导致statusbar的样式变成黑色 需还原回来
    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
        ((UIImagePickerController *)navigationController).sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}
@end
