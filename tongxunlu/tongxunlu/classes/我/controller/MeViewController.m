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

@interface MeViewController ()
@property (nonatomic, strong) NSArray *modelList;
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
    accountInfo.classStr = @"";
    
    MeModel *authorityInfo = [[MeModel alloc] init];
    authorityInfo.text = @"权限屏蔽";
    authorityInfo.imageStr = @"icon_setting_merge";
    authorityInfo.classStr = @"";
    
    self.modelList = @[accountInfo,authorityInfo];
    

    
    
    
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
