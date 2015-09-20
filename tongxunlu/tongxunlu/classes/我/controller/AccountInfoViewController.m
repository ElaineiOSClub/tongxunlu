//
//  AccountInfoViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "PersonInfoCell.h"
#import "AccountTool.h"

#import "MeModifyViewController.h"

static NSString *const cellID = @"cellID";

@interface AccountInfoViewController ()
@property (nonatomic, strong) NSArray *titleList;
@end

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号信息";
    
    UIView *headView = [[UIView alloc] init];
    headView.height = 80;
    UILabel *label = [[UILabel alloc] init];
    label.text = [AccountTool shareAccount].account.U_Name;
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    label.centerY = headView.height/2;
    label.x = 20;
    [headView addSubview:label];
    self.tableView.tableHeaderView = headView;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerClass:[PersonInfoCell class] forCellReuseIdentifier:cellID];
    
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
    cell.contentLabel.text = [[AccountTool shareAccount].account valueForKeyPath:dict.allKeys[0]];
    
    
    if ([dict.allValues[0] isEqualToString:@"电话"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.titleList[indexPath.row];

    if ([dict.allValues[0] isEqualToString:@"电话"]) {
        MeModifyViewController *vc = [[MeModifyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

    
}


#pragma mark - lazy
- (NSArray *)titleList
{
    if (!_titleList) {
        _titleList = @[@{@"U_Phone":@"电话"},@{@"U_Birthday":@"生日"},@{@"U_Sex":@"性别"},@{@"PR_Name":@"省"},@{@"CT_Name":@"城市"},@{@"C_Name":@"班级"},@{@"U_CurrentAdress":@"当前地址"},@{@"U_Email":@"邮箱"},@{@"U_Job":@"职业"},@{@"U_QQ":@"QQ"},@{@"U_WeChat":@"微信"}];
    }
    return _titleList;
}



@end
