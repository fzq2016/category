//
//  OYOConfigurationCenter.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/12.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "OYOConfigurationCenter.h"
#import "OYOTabBarController.h"
#import "OYOBaseNavigationController.h"
#import "OYOContainer.h"
#import "HomeViewController.h"
#import "OtherViewController.h"

static int maxTabCount = 2;

@interface OYOConfigurationCenter ()
@property (nonatomic, strong) UIViewController *rootViewController;
@end

@implementation OYOConfigurationCenter
@synthesize rootViewController      = _rootViewController;

static OYOConfigurationCenter* instance;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OYOConfigurationCenter alloc] init];
    });
    return instance;
}

- (UIViewController *)rootViewController {
    if (_rootViewController == nil) {
        _rootViewController     = [self navigationController];
    }
    return _rootViewController;
}

- (OYOBaseNavigationController *)navigationController {
    OYOBaseNavigationController *navigationController = nil;
    UIViewController *rootController = [self tabbarController];
    [OYOContainer global].tabbarController = (OYOTabBarController *)rootController;
    navigationController = [[OYOBaseNavigationController alloc] initWithRootViewController:rootController];
    //设置 TO DO :someProperty navigationBar
    return navigationController;
}

- (OYOTabBarController *)tabbarController {
    if (!_tabbarController) {
        _tabbarController = [[OYOTabBarController alloc] init];
        _tabbarController.viewControllers = [self OYOViewControllerts];
        _tabbarController.delegate = self;
        _tabbarController.selectedIndex = 0;
        _tabbarController.view.backgroundColor = [UIColor whiteColor];
    }
    //custom other: TO DO
    return _tabbarController;
}

- (NSArray *)OYOViewControllerts {
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
    UIViewController *homeViewController = nil;
    homeViewController                           = [[HomeViewController alloc] init];
    return homeViewController;
}

- (UIViewController *)orderViewController {
    UIViewController *orderViewController = nil;
    orderViewController                           = [[UIViewController alloc] init];
    return orderViewController;
}

- (UIViewController *)feedbackViewController {
    UIViewController *feedbackViewController = nil;
    feedbackViewController                           = [[UIViewController alloc] init];
    return feedbackViewController;
}

- (UIViewController *)mineViewController {
    UIViewController *mineViewController = nil;
    mineViewController                           = [[OtherViewController alloc] init];
    return mineViewController;
}

- (UITabBarItem *)createTabbarItem:(NSInteger)index {
    NSArray *titleArray = @[kLocalString(@"LANG_TAB_HOME"),kLocalString(@"LANG_TAB_ORDER"),kLocalString(@"LANG_TAB_FEEDBACK"),kLocalString(@"LANG_TAB_MINE")];
    
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
