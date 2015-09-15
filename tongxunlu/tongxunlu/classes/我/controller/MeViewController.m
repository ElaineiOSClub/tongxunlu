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

@interface MeViewController ()<UIWebViewDelegate>
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
    label.text = @"大白菜";
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
    }
}

- (void)getIP
{
    
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
    NSRange beginRange = [requestStr rangeOfString:@"["];
    NSRange endRange = [requestStr rangeOfString:@"]"];
    requestStr = [requestStr substringWithRange: NSMakeRange(beginRange.location + 1, endRange.location - beginRange.location - 1)];
    //上传IP
  
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

    
}



@end
