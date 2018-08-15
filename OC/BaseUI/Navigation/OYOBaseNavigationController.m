 //
//  OYOBaseNavigationController.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/6.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "OYOBaseNavigationController.h"

@interface OYOBaseNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation OYOBaseNavigationController

///** 初始化类时统一对导航控制器设置 */
//+(void)initialize
//{
//    // 当前类初始化的时候才会调用,子类调用时不初始化
//    if (self == [FZQNavController class]) {
//
//    //获取当前类下面所有导航条
//    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
//
//    //设置背景图片
//    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
//
//    //设置文字颜色
//    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
//    dictM[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    dictM[NSFontAttributeName] = [UIFont systemFontOfSize:20];
//
//    navBar.titleTextAttributes = dictM;
//    }
//}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    self.delegate = self;
}

#pragma mark - Selector
- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [super dismissViewControllerAnimated:flag completion:completion];
//    [(UINavigationController *)[OYONavigator sharedInstance].modalNavigationController setViewControllers:[NSArray new]];
}

@end
