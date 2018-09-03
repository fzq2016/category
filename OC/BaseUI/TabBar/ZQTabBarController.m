//
//  ZQTabBarController.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/12.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "ZQTabBarController.h"

@interface ZQTabBarController ()<UITabBarDelegate, UITabBarControllerDelegate/*, OYONavigatorProtocol*/>

@end

@implementation ZQTabBarController

#pragma mark - Init && Dealloc
- (instancetype)initWithQuery:(NSDictionary *)query {
    if ([query isKindOfClass:[NSDictionary class]]) {
        NSLog(@"query_____%@",query);
    }
    return self;
}

- (void)doInitializeWithQuery:(NSDictionary *)query {
    if ([query isKindOfClass:[NSDictionary class]]) {
        NSLog(@"query_____%@",query);
    }
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    // [[[OYOMainViewModel alloc] init] initVersionData];
    
}

///** 系统即将显示时移除tabBar中的button */
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    //遍历系统的tabBar
//    for (UIView *childView in self.tabBar.subviews) {
//
//        if ([childView isKindOfClass:[FZQTabBar class]] == NO) {
//            //如果不是自定义的tabBar,将所有系统按钮移除
//            [childView removeFromSuperview];
//        }
//    }
//}

#pragma mark - Selector
///** 初始化自定义tabBar */
//-(void)setUpTabBar
//{
//    /** 初始化自定义tabBar */
//    FZQTabBar *newTabBar = [[FZQTabBar alloc]initWithFrame:self.tabBar.bounds];
//
//    //设置自定义tabBar items内容
//    newTabBar.items = self.items;
//
//    //设置自定义tabBar跳转block
//    //用弱指针指向tabBarVc,避免循环引用
//    __weak typeof(self) weakSelf = self;
//
//    //设置block
//    newTabBar.tabBarBlock = ^(NSInteger selectedIndex) {
//        //根据选中跳转页面
//        weakSelf.selectedIndex = selectedIndex;
//    };
//
//    //添加到系统tabBar中
//    [self.tabBar addSubview:newTabBar];
//}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}

@end
