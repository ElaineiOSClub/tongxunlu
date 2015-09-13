//
//  LoginViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/10.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistersViewController.h"
#import "TabBarViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.cornerRadius = 4;
}

- (IBAction)registerClick:(id)sender {
    
    RegistersViewController *registerVC = [[RegistersViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
    
}

- (IBAction)loginClick:(id)sender {
    TabBarViewController *tab = [[TabBarViewController alloc] init];
    
    self.view.window.rootViewController = tab;
}




@end
