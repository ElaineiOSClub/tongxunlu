//
//  MainNavigationViewController.m
//  导诊
//
//  Created by elaine on 15/4/20.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "MainNavigationViewController.h"
#import "UIBarButtonItem+Extension.h"


@interface MainNavigationViewController ()

@end

@implementation MainNavigationViewController


+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    navigationBar.barTintColor = [UIColor redColor];
    
    [navigationBar setTitleTextAttributes:attributes];
    
    
  
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //大于0 表示不是根控制器
   if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置返回按钮样式
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithTarget:self action:@selector(back) image:@"nav_left_normal" highImage:@"nav_left_high"];
   }
//   else {
//       //这里是导航栏下的根控制器
//       viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithTarget:self action:@selector(presentLeftMenuViewController:) image:@"nav_home_nomal" highImage:@"nav_home_high"];
//   }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
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
