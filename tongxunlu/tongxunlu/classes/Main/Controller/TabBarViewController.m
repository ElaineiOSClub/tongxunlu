//
//  TabBarViewController.m
//  导诊
//
//  Created by elaine on 15/4/23.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainNavigationViewController.h"




@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.初始化子控制器
    UIViewController *nav = [[UIViewController alloc] init];
    nav.title = @"曼荼罗导诊";
    [self addChildVc:nav title:@"首页" image:@"导诊流程页面icon_03" selectedImage:@"导诊流程页面icon_03-05"];
    nav.tabBarItem.badgeValue = @"20";
    
    UIViewController *check = [[UIViewController alloc] init];
    [self addChildVc:check title:@"查看" image:@"导诊流程页面icon_03-07" selectedImage:@"导诊流程页面icon_03-09"];
    
    UIViewController *appointment = [[UIViewController alloc] init];
    [self addChildVc:appointment title:@"预约" image:@"导诊流程页面icon_03-11" selectedImage:@"导诊流程页面icon_03-13"];
    
    UIViewController *propaganda = [[UIViewController alloc] init];
    [self addChildVc:propaganda title:@"我" image:@"导诊流程页面icon_03-15" selectedImage:@"导诊流程页面icon_03-17"];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat  x = kScreenW/4.0;
    CGFloat y = x/2;
    CGFloat z = kScreenW - y + 5;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(z, 7, 10, 10)];
    view.layer.cornerRadius = 5;
    view.backgroundColor = [UIColor redColor];
    [self.tabBar addSubview:view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",NSStringFromCGRect(self.tabBar.frame));
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.tabBarItem.title = title; // 同时设置tabbar和navigationBar的文字
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = kUIColorFromRGB(0x838282);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = kUIColorFromRGB(0x1ac785);
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    


    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    MainNavigationViewController *nav = [[MainNavigationViewController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}


@end
