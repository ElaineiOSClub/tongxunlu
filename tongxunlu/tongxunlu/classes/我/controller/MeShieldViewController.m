//
//  MeShieldViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/15.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MeShieldViewController.h"
#import "MeShieldCell.h"
#import "MeShield.h"
#import "AccountTool.h"
#import "HttpTool.h"
#import "MBProgressHUD.h"

static NSString *const cellID = @"cellID";

@interface MeShieldViewController ()<MeShieldCellDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) NSArray *modelList;
@end

@implementation MeShieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    [item setTintColor:KColor(0, 203, 95)];
    self.navigationItem.rightBarButtonItem = item;
    

    [self.tableView registerNib:[UINib nibWithNibName:@"MeShieldCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
   
    
    

    
    MeShield *one = [[MeShield alloc] init];
    one.ID = @"1";
    one.name = @"仅查看自己班级";
    one.isOK = [[AccountTool shareAccount].account.U_Sign boolValue];
//    
//    MeShield *two = [[MeShield alloc] init];
//    two.ID = @"2";
//    two.name = @"装逼2班";
//    two.isOK = NO;
//    
//    MeShield *three = [[MeShield alloc] init];
//    three.ID = @"3";
//    three.name = @"装逼3班";
//    three.isOK = NO;
//    
//    MeShield *four = [[MeShield alloc] init];
//    four.ID = @"3";
//    four.name = @"装逼4班";
//    four.isOK = NO;

    self.modelList = @[one];
    
//    if ([[AccountTool shareAccount].account.U_Sign isEqualToString:@"0"]) {
//        return;
//    }
//    NSArray *shieldList = [[AccountTool shareAccount].account.U_Sign componentsSeparatedByString:@","];
//    for (NSInteger i = 0 ; i < shieldList.count ; i++) {
//        
//        NSPredicate *pred = [NSPredicate predicateWithFormat:@"ID == '%@'",shieldList[i]];
//        NSArray *list = [self.modelList filteredArrayUsingPredicate:pred];
//        for (MeShield *shield in list) {
//            shield.isOK = YES;
//        }
//        
//    }
    
    [self.tableView reloadData];
    
}

#pragma mark - event response
- (void)submit:(UIBarButtonItem *)item
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在保存";
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    
//    NSString *newStr = @"";
//    NSMutableString *string = [NSMutableString string];
//    for (MeShield *shield in self.modelList) {
//        if (shield.isOK) {
//            [string appendString:[NSString stringWithFormat:@"%@,",shield.ID]];
//        }
//    }
//    if (string.length == 0) {
//        newStr = @"0";
//        
//    } else {
//       newStr = [string substringWithRange:NSMakeRange(0, string.length - 1)];
//    }
//    MLog(@"%@",newStr);
    MeShield *shield = self.modelList[0];
    NSString *newStr = shield.isOK?@"1":@"0";
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx",KUrl];
    
    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"setGroup",@"Token":[AccountTool shareAccount].account.Token,@"UClass":newStr} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MLog(@"%@",responseObject);
        
        if ([responseObject[@"SetGroup"] isEqualToString:@"Success"]) {
            
            [AccountTool shareAccount].account.U_Sign = newStr;
            
            HUD.labelText = @"保存成功";
            [HUD hide:YES afterDelay:1];
        } else {
            MLog(@"保存失败");
            HUD.labelText = @"保存失败";
            [HUD hide:YES afterDelay:1];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLog(@"%@",operation.responseString);
        MLog(@"网络异常");
        HUD.labelText = @"网络异常，请稍微再试";
        [HUD hide:YES afterDelay:1];
    }];
    
//    
//    //    更新屏蔽设定：action=setGroup&Token=xxxx&UClass=屏蔽班级ID （不管几个班以西文逗号,分割如果全部显示则不用管默认为0 比如屏蔽12班 则是 UClass=’1,2’）
//    //    成功返回 {\"SetGroup\":\"Success\"}  错误 {\"SetGroup\":\"Error\"}\
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.modelList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeShieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.model = self.modelList[indexPath.row];
    return cell;
}

#pragma mark - MeShieldCellDelegate
- (void)meShieldCell:(MeShieldCell *)cell btnClick:(UIButton *)button indexPath:(NSIndexPath *)indexPath
{
    MeShield *shield = self.modelList[indexPath.row];
    shield.isOK = button.selected;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}





@end
