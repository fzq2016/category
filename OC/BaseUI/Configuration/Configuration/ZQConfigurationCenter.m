//
//  ZQConfigurationCenter.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/12.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "ZQConfigurationCenter.h"
#import "ZQTabBarController.h"
#import "ZQBaseNavigationController.h"
#import "HomeViewController.h"
#import "OtherViewController.h"

static int maxTabCount = 2;

@interface ZQConfigurationCenter ()

@property (nonatomic, strong) UIViewController *rootViewController;

@end

@implementation ZQConfigurationCenter


static ZQConfigurationCenter* instance;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZQConfigurationCenter alloc] init];
    });
    return instance;
}

- (UIViewController *)rootViewController {
    if (_rootViewController == nil) {
        _rootViewController     = [self navigationController];
    }
    return _rootViewController;
}

- (ZQBaseNavigationController *)navigationController {
    ZQBaseNavigationController *navigationController = nil;
    
    UIViewController *rootController = [self tabbarController];
    [ZQContainer global].tabbarController = (ZQTabBarController *)rootController;
    
    navigationController = [[ZQBaseNavigationController alloc] initWithRootViewController:rootController];
    
    return navigationController;
}

- (ZQTabBarController *)tabbarController {
    if (!_tabbarController) {
        _tabbarController = [[ZQTabBarController alloc] init];
        _tabbarController.viewControllers = [self getBusinessViewControllerts];
        _tabbarController.delegate = self;
        _tabbarController.selectedIndex = 0;
        _tabbarController.view.backgroundColor = [UIColor whiteColor];
    }
    
    return _tabbarController;
}

- (NSArray *)getBusinessViewControllerts {
    NSMutableArray * controllers                = [NSMutableArray arrayWithCapacity:maxTabCount];
    for (int i = 0; i < maxTabCount; i++) {
        UIViewController * controller           = [self viewControllerForTabIndex:i];
        
        if (controller) {
            [controllers addObject:controller];
        }
    }
    return controllers;
}

- (UIViewController *)viewControllerForTabIndex:(int)tabIndex {
    
    UIViewController * viewController   = nil;
    
    switch (tabIndex) {
        case 0:{
            viewController              = [self homeViewController];
            break;
        }
        case 1:{
            viewController              = [self mineViewController];
            break;
        }
        case 2:{
            viewController              =  [self feedbackViewController];
        }
            break;
        case 3:{
            viewController              = [self mineViewController];
        }
            break;
        default:
            break;
            
    }
    if (viewController) {
        viewController.tabBarItem       = [self createTabbarItem:tabIndex];
    }
    
    return viewController;
}

- (UIViewController *)homeViewController {
    
    return [HomeViewController zq_viewController];
}

- (UIViewController *)orderViewController {

    return [UIViewController zq_viewController];
}

- (UIViewController *)feedbackViewController {
    return [UIViewController zq_viewController];
}

- (UIViewController *)mineViewController {
    
    return [OtherViewController zq_viewController];
}

- (UITabBarItem *)createTabbarItem:(NSInteger)index {
    NSArray *titleArray = @[kLocalString(@"LANG_TAB_HOME", @"首页"),
                            kLocalString(@"LANG_TAB_ORDER", @"订单"),
                            kLocalString(@"LANG_TAB_FEEDBACK", @"反馈"),
                            kLocalString(@"LANG_TAB_MINE", @"我的")];
    
    NSArray *imageArray = @[@"homeTabbar",@"orderTabbar",@"feedback",@"mineTabbar"];
    NSArray *selectArry = @[@"homeTabbarSelected",@"orderTabbarSelected",@"feedbackSelected",@"mineTabbarSelected"];
    UIImage *originImage = [UIImage imageNamed:imageArray[index]];
    UIImage *selectImage = [UIImage imageNamed:selectArry[index]];
    
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:titleArray[index] image:[originImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage: [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    return tabbarItem;
    
}

@end
