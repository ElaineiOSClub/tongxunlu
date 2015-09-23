//
//  MeModifyViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/21.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MeModifyViewController.h"
#import "AccountTool.h"
#import "HttpTool.h"
#import "MBProgressHUD.h"

@interface MeModifyViewController ()
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@end

@implementation MeModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电话号码";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : KColor(0, 203, 95)} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = item;
    
    self.phoneField.text = [AccountTool shareAccount].account.U_Phone;
    [self.phoneField becomeFirstResponder];
    
}

- (void)save
{
    
    //电话
    NSString *pattern = @"^[0-9]{11}";
    if (![self predicate:pattern withStr:self.phoneField.text]) {
        [self alertWithStr:@"请填写11位手机号"];
        return;
    }
    
    [self.phoneField resignFirstResponder];
    
    //TokenService.asxh?action=changePhone&Token=XXX&Phone=XXX
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.labelText = @"正在保存";
    [HUD show:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx",KUrl];
    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"changePhone",@"Token":[AccountTool shareAccount].account.Token,@"Phone":self.phoneField.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"ChangeMes"] isEqualToString:@"成功"]) {
            [AccountTool shareAccount].account.U_Phone = self.phoneField.text;
            HUD.labelText =responseObject[@"ChangeMes"];
            [HUD hide:YES afterDelay:1];
            [self.navigationController popViewControllerAnimated:YES];
        }  else {
             HUD.labelText = @"保存失败";
            [HUD hide:YES afterDelay:1];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HUD.labelText = @"网络异常";
       [HUD hide:YES afterDelay:1];
    }];
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
