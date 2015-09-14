//
//  AccountInfoViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "PersonInfoCell.h"


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
    label.text = @"大白菜";
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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.titleLabel.text = self.titleList[indexPath.row];
    cell.contentLabel.text = @"139-7482-9837";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



#pragma mark - lazy
- (NSArray *)titleList
{
    if (!_titleList) {
        _titleList = @[@"手机号",@"学校",@"班级",@"家庭地址",@"QQ",@"微信",@"邮箱"];
    }
    return _titleList;
}


@end
