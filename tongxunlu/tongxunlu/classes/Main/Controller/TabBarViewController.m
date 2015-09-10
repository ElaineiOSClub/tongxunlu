//
//  TabBarViewController.m
//  导诊
//
//  Created by elaine on 15/4/23.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainNavigationViewController.h"

#import "ConstractViewController.h"
#import "MessageViewController.h"
#import "MeViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    // 1.初始化子控制器
    ConstractViewController *class = [[ConstractViewController alloc] init];
    [self addChildVc:class title:@"联系人" image:@"icon_tab_contact" selectedImage:@"icon_tab_contact_selected"];
    
    MessageViewController *message = [[MessageViewController alloc] init];
    [self addChildVc:message title:@"消息" image:@"icon_tab_message" selectedImage:@"icon_tab_message_selected"];
    
    MeViewController *me = [[MeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildVc:me title:@"我" image:@"icon_tab_setting" selectedImage:@"icon_tab_setting_selected"];
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
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = kUIColorFromRGB(0x838282);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = KColor(0, 203, 90);
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    


    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    MainNavigationViewController *nav = [[MainNavigationViewController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}


@end
