//
//  MeViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/9.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MeViewController.h"
//实体
#import "MeModel.h"
//退出
#import "MeOutCell.h"
//账号信息
#import "AccountInfoViewController.h"
//屏蔽信息
#import "MeShieldViewController.h"

#import "AccountTool.h"

#import "HttpTool.h"

#import "MBProgressHUD.h"

#import "LoginViewController.h"


@interface MeViewController ()<UIWebViewDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) NSArray *modelList;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    
    self.tableView.backgroundColor = KColor(248, 248, 248);
    
    UIView *headView = [[UIView alloc] init];
    headView.height = 80;

    UILabel *label = [[UILabel alloc] init];
    label.text = [AccountTool shareAccount].account.U_Name;
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    label.centerY = headView.height/2;
    label.x = 40;
    [headView addSubview:label];
    
    self.tableView.tableHeaderView = headView;
    
    MeModel *accountInfo = [[MeModel alloc] init];
    accountInfo.text = @"账号信息";
    accountInfo.imageStr = @"icon_setting_profile";
    accountInfo.classStr = @"AccountInfoViewController";
    
    MeModel *authorityInfo = [[MeModel alloc] init];
    authorityInfo.text = @"权限屏蔽";
    authorityInfo.imageStr = @"icon_setting_merge";
    authorityInfo.classStr = @"MeShieldViewController";
    
    MeModel *ip = [[MeModel alloc] init];
    ip.text = @"上传当前位置";
    ip.imageStr = @"icon_setting_backup";
    ip.classStr = @"";
    
    
    self.modelList = @[accountInfo,authorityInfo,ip];
    

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

 
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return self.modelList.count;
    } else {
        return 1;
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        
        MeModel *model = self.modelList[indexPath.row];
        cell.textLabel.text = model.text;
        cell.imageView.image = [UIImage imageNamed:model.imageStr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        return cell;
    } else {
        MeOutCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[MeOutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textColor = [UIColor redColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {//上传
            
            [self getIP];
            
        } else {
            MeModel *model = self.modelList[indexPath.row];
            Class class = NSClassFromString(model.classStr);
            [self.navigationController pushViewController:[[class alloc] init] animated:YES];
        }
    } else {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.labelText = @"正在退出";
        HUD.removeFromSuperViewOnHide = YES;
        [HUD show:YES];
        [[AccountTool shareAccount] deleteAccount];
        HUD.hidden = YES;
        
        LoginViewController *vc = [[LoginViewController alloc] init];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        
    }
}

- (void)getIP
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在更新地址";
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    [self.view insertSubview:_webView atIndex:0];
    
    NSURL *url = [NSURL URLWithString:@"http://1111.ip138.com/ic.asp"];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *requestStr = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(\"center\")[0].innerHTML;"];
//    NSRange beginRange = [requestStr rangeOfString:@"["];
//    NSRange endRange = [requestStr rangeOfString:@"]"];
//    requestStr = [requestStr substringWithRange: NSMakeRange(beginRange.location + 1, endRange.location - beginRange.location - 1)];
    NSArray *array = [requestStr componentsSeparatedByString:@" "];
    NSString *address = [array[1] substringWithRange:NSMakeRange(3, [array[1] length] - 3)];
    MLog(@"%@",address);
    //上传地址
    
    ///AppDo/TokenService.ashx
    //action=changeCurrentAdress&Token=xxxx&CurrentAdress=当前地址 string
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx",KUrl];

    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"changeCurrentAdress",@"Token":[AccountTool shareAccount].account.Token,@"CurrentAdress":address} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //{\"UpdateAdress\":\"Success\"} 错误 {\"UpdateAdress\":\"Error\"}
        MLog(@"%@",responseObject);
        
        if ([responseObject[@"UpdateAdress"] isEqualToString:@"Success"]) {
            MLog(@"更新成功");
            HUD.labelText = @"更新成功";
            [HUD hide:YES afterDelay:1];
            
        } else {
            MLog(@"更新失败");
            HUD.labelText = @"更新失败";
            [HUD hide:YES afterDelay:1];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLog(@"%@",operation.responseString);
        MLog(@"网络异常");
        HUD.labelText = @"网络异常";
        [HUD hide:YES afterDelay:1];
    }];
    
  
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

    
}



@end
