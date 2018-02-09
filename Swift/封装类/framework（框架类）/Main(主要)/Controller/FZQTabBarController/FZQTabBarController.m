//
//  FZQTabBarController.m
//  
//
//  Created by FZQ on 16/3/28.
//  Copyright © 2016年 FZQ. All rights reserved.
//

#import "FZQTabBarController.h"
#import "FZQNavController.h"
#import "FZQTabBar.h"
#import "UIImage+ZQOriginal.h"

@interface FZQTabBarController ()

/** items */
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation FZQTabBarController

#pragma mark - lazy load
-(NSArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 添加所有子控制器 */
    [self setUpAllChildViewController];
    
    /** 初始化自定义tabBar */
    [self setUpTabBar];
}

/** 系统即将显示时移除tabBar中的button */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    
    //遍历系统的tabBar
    for (UIView *childView in self.tabBar.subviews) {
        
        if ([childView isKindOfClass:[FZQTabBar class]] == NO) {
            //如果不是自定义的tabBar,将所有系统按钮移除
            [childView removeFromSuperview];
        }
    }
}

/** 初始化自定义tabBar */
-(void)setUpTabBar
{   
    /** 初始化自定义tabBar */
    FZQTabBar *newTabBar = [[FZQTabBar alloc]initWithFrame:self.tabBar.bounds];

    //设置自定义tabBar items内容
    newTabBar.items = self.items;
    
    //设置自定义tabBar跳转block
    //用弱指针指向tabBarVc,避免循环引用
    __weak typeof(self) weakSelf = self;
    
    //设置block
    newTabBar.tabBarBlock = ^(NSInteger selectedIndex) {
        //根据选中跳转页面
        weakSelf.selectedIndex = selectedIndex;
    };
    
    //添加到系统tabBar中
    [self.tabBar addSubview:newTabBar];
}

#pragma mark - 添加所有子控制器
/* 添加所有子控制器 */
- (void)setUpAllChildViewController
{
    // 子界面标题
    [self setUpOneChildViewController:[UIViewController class] title:@"子界面标题"];
    
}

/** 添加一个子控制器 */
- (void)setUpOneChildViewController:(Class)viewControllerClass title:(NSString *)title
{
    //生成控制器
    UIViewController *vc = [[viewControllerClass alloc]init];
    
    //生成导航控制器
    UINavigationController *nav = [[UINavigationController alloc] init];
    
    //设置导航条title
    vc.navigationItem.title = title;
    
    /* 生成并设置item，并加入到items */
    [self setUpItem:viewControllerClass];
    
    //将导航控制器加入到标签控制器
    [self addChildViewController:nav];
}

#pragma mark - 设置UITabBarItem
/* 生成并设置item，并加入到items */
- (void)setUpItem:(id)className
{
    //截取字符串
    NSString *tempStr = [self getString:className];
    
    //生成item
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage zq_originalImageNamed:[NSString stringWithFormat:@"TabBar_%@_new",tempStr]] selectedImage:[UIImage zq_originalImageNamed:[NSString stringWithFormat:@"TabBar_%@_selected_new",tempStr]]];
    
    //加入到items中
    [self.items addObject:item];
}

#pragma mark - getString
/* 截取字符串 */
- (NSMutableString *)getString:(id)className
{
    /** 截取字符串 */
    NSMutableString *tempStr = [NSMutableString stringWithFormat:@"%@",NSStringFromClass([className class])];
    //删除类前缀
    NSRange range = [tempStr rangeOfString:@"FZQ"];
    [tempStr deleteCharactersInRange:range];
    //删除控制器后缀名
    range = [tempStr rangeOfString:@"ViewController"];
    [tempStr deleteCharactersInRange:range];
    
    return tempStr;
}
@end
