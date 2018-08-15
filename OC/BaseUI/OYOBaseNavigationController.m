 //
//  OYOBaseNavigationController.m
//  OYOConsumer
//
//  Created by neo on 2018/7/6.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "OYOBaseNavigationController.h"

@interface OYOBaseNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation OYOBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    self.delegate = self;
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [super dismissViewControllerAnimated:flag completion:completion];
//    [(UINavigationController *)[OYONavigator sharedInstance].modalNavigationController setViewControllers:[NSArray new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
