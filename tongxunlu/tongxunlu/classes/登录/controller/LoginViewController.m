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
#import "NSString+Extension.h"
#import "HttpTool.h"
#import "MBProgressHUD.h"
#import "AccountTool.h"
#import "MJExtension.h"

@interface LoginViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UITextField *userNameField;

@property (weak, nonatomic) IBOutlet UITextField *passWordField;

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
    
    //用户名
    if ([self.userNameField.text containsStringWithios7:@" "] || [self.userNameField.text isEqualToString:@""]) {
        [self alertWithStr:@"用户名不能为空"];
        return;
    }
    //密码
    if ([self.passWordField.text containsStringWithios7:@" "] || [self.passWordField.text isEqualToString:@""]) {
        [self alertWithStr:@"密码不能为空"];
        return;
    }
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"正在登陆";
    [HUD show:YES];

    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/UserService.ashx",KUrl];
    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"Login",@"Account":self.userNameField.text,@"Password":self.passWordField.text } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MLog(@"%@",responseObject);
        Account *account = [Account objectWithKeyValues:responseObject[0]];
        
        [[AccountTool shareAccount] saveAccount:account];
        
        

        [HUD hide:YES];
        TabBarViewController *tab = [[TabBarViewController alloc] init];
        self.view.window.rootViewController = tab;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLog(@"%@",operation.responseString);
        MLog(@"%@",error);
    }];
    
    
    
    
    

}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

/**
 *  验证用户信息
 *
 *  @param predicate 正则表达式
 *  @param str       验证内容
 *
 *  @return bool
 */
- (BOOL)predicate:(NSString *)predicate withStr:(NSString *)str
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicate];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

/**
 *  提示
 *
 *  @param str 内容
 */
- (void)alertWithStr:(NSString *)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:@"" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}





@end
