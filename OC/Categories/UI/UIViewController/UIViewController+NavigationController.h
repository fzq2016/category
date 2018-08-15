//
//  UIViewController+NavigationController.h
//  OYOConsumer
//
//  Created by neo on 2018/7/10.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LeftNavigationItemBlock)(void);
typedef void (^RightNavigationItemBlock)(void);
typedef void (^MiddleNavigationItemBlock)(void);

@interface UIViewController (NavigationController)

@property (nonatomic,retain) NSObject *transfer;
@property (nonatomic,assign) BOOL isSystemNavigation;
@property (nonatomic, strong) UINavigationBar *navigationBar;

- (void)showNavigationShadow:(BOOL)isSystem;
- (void)hiddenNavigationShadow:(BOOL)isSystem;
- (void)setNavHeight:(NSInteger)navHeight;
- (void)navigateWhite:(BOOL)isSystem;
- (void)navigateClear:(BOOL)isSystem;

- (void)setDefaultNavigationLeftItem;
- (void)setNavigationClearBack;
- (void)setNavigationClearBackTitle:(NSString *)title;
- (void)setDefaultNavigationLeftItemWithOffset:(CGFloat)offset;

- (void)setNavigationLeftItem:(NSString*)text block:(LeftNavigationItemBlock)block;
- (void)setNavigationLeftItem:(NSString*)text;
- (void)setNavigationLeftItemWithBlock:(LeftNavigationItemBlock)block;
- (void)setNavigationLeftItem:(UIImage*)normal selected:(UIImage*)selected;
- (void)setNavigationLeftItem:(UIImage*)normal selected:(UIImage*)selected  block:(LeftNavigationItemBlock)block;

- (void)setNavigationLeftItemWithImage:(UIImage *)normal block:(RightNavigationItemBlock)block;
- (void)setNavigationRightItemWithImage:(UIImage *)normal block:(RightNavigationItemBlock)block;
- (void)setNavigationRightItemWithImage:(UIImage *)normal adjustmentOffset:(CGFloat)offset block:(RightNavigationItemBlock)block;

- (void)setNavigationRightItem:(NSString*)text block:(RightNavigationItemBlock)block;
- (void)setNavigationRightItem:(NSString*)text font:(UIFont*)font tintColor:(UIColor*)tintColor block:(RightNavigationItemBlock)block;
- (void)setNavigationRightItem:(UIImage*)normal selected:(UIImage*)selected block:(RightNavigationItemBlock)block;

- (void)setNavigationLeftNil;

- (void)setNavigationTitle:(NSString*)title;
- (void)setNavigationTitle:(NSString *)title forNavBar:(UINavigationBar *)navBar;
- (void)setNavigationTitleBack:(NSString *)title forNavBar:(UINavigationBar *)navBar;
- (void)setNavigationRightItem:(NSString *)title
                           rightText:(NSString *)rightStr
                               block:(RightNavigationItemBlock)block
                            showBack:(BOOL)isShow
                           forNavBar:(UINavigationBar *)navBar;

- (void)setNavigationTitle:(NSString*)title subtitle:(NSString *)subtitle;

- (void)setNavigationWithIcon:(NSString *)icon title:(NSString *)title;
- (void)onBackNavigation;
- (void)setNavigationRightItem:(NSString*)text;

/*
 导航和状态栏高度
 */

-(float)heightOfNavAndStatusBar;


@end
