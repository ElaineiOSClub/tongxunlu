//
//  PersonViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonInfoCell.h"
#import "HttpTool.h"
#import "PersonInfoModel.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"


static NSString * const cellID = @"cellID";

@interface PersonViewController ()
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) NSArray *titleList;
@property (nonatomic, strong) PersonInfoModel *model;
@end

@implementation PersonViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[PersonInfoCell class] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在加载";
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    
    
    //action=getUserMess&UserId=所点击用户ID
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx",KUrl];
    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"getUserMess",@"UserId":@(_UserId)} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MLog(@"%@",responseObject);
        HUD.hidden = YES;
        PersonInfoModel *model = [PersonInfoModel objectWithKeyValues:responseObject[0]];
        NSInteger U_Birthday = [[model.U_Birthday substringWithRange:NSMakeRange(0, 4)] integerValue];
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
        NSInteger year = [dateComponent year];
        model.U_Birthday = [NSString stringWithFormat:@"%ld",year - U_Birthday + 1];
        model.U_Sex = [model.U_Sex isEqualToString:@"1"]?@"男":@"女";
        _model = model;
        
        
        self.title = model.U_Name;
        UIView *headView = [[UIView alloc] init];
        headView.height = 80;
        UILabel *label = [[UILabel alloc] init];
        label.text = model.U_Name;
        label.font = [UIFont systemFontOfSize:16];
        [label sizeToFit];
        label.centerY = headView.height/2;
        label.x = 20;
        [headView addSubview:label];
        self.tableView.tableHeaderView = headView;
        
        MLog(@"%@",model);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HUD.labelText = @"网络异常，稍后再试";
        [HUD hide:YES afterDelay:1];
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    NSDictionary *dict = self.titleList[indexPath.row];
    
    
    cell.titleLabel.text = dict.allValues[0];
    cell.contentLabel.text = [_model valueForKeyPath:dict.allKeys[0]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSDictionary *dict = self.titleList[indexPath.row];

        NSString *allString = [NSString stringWithFormat:@"tel:%@",[_model valueForKeyPath:dict.allKeys[0]]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];

    }
}


#pragma mark - lazy
- (NSArray *)titleList
{
    if (!_titleList) {
        _titleList = @[@{@"U_Phone":@"电话"},@{@"U_Birthday":@"年龄"},@{@"U_Sex":@"性别"},@{@"PR_Name":@"省"},@{@"CT_Name":@"城市"},@{@"C_Name":@"班级"},@{@"U_CurrentAdress":@"当前地址"},@{@"U_Email":@"邮箱"},@{@"U_Job":@"职业"},@{@"U_QQ":@"QQ"},@{@"U_WeChat":@"微信"}];
    }
    return _titleList;
}

//"CT_Name" = "\U91cd\U5e86\U5e02";
//"C_Name" = "\U88c5\U903c2\U73ed";
//"PR_Name" = "\U91cd\U5e86\U5e02";
//"U_Adress" = 123;
//"U_Birthday" = "2015/9/10 0:00:00";
//"U_CurrentAdress" = 123;
//"U_Email" = "lanmingo@vip.qq.com";
//"U_Job" = 123;
//"U_Name" = 123;
//"U_Phone" = 520520;
//"U_QQ" = 451256978;
//"U_Sex" = 1;
//"U_WeChat" = 451256978;

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
