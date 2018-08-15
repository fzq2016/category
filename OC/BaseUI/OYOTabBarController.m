//
//  OYOTabBarController.m
//  OYOConsumer
//
//  Created by willson on 2018/7/12.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "OYOTabBarController.h"

@interface OYOTabBarController ()<UITabBarDelegate, UITabBarControllerDelegate/*, OYONavigatorProtocol*/>

@end

@implementation OYOTabBarController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    // [[[OYOMainViewModel alloc] init] initVersionData];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
