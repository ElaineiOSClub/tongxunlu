//
//  PersonListViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/19.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "PersonListViewController.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "PersonListModel.h"
#import "MJExtension.h"
#import "PersonViewController.h"
#import "MBProgressHUD.h"

static NSString *const cellID = @"cellID";

@interface PersonListViewController ()
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) NSArray *arrayList;
@end

@implementation PersonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在加载";
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];

    
    //action=getUserList&Token=XXX&CityID=城市ID
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx",KUrl];
    MLog(@"%@",[AccountTool shareAccount].account.Token);
    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"getUserList",@"Token":[AccountTool shareAccount].account.Token,@"CityID":@(_cityID)} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.arrayList = [PersonListModel objectArrayWithKeyValuesArray:responseObject];
        HUD.hidden = YES;
        [self.tableView reloadData];
        MLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLog(@"%@",operation.responseString);
        MLog(@"人员列表--%@",error);
        HUD.labelText = @"网络异常，稍后再试";
        [HUD hide:YES afterDelay:1];
    }];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrayList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    PersonListModel *model = self.arrayList[indexPath.row];
    cell.textLabel.text = model.U_Name;
    cell.detailTextLabel.text = model.C_Name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PersonListModel *model = self.arrayList[indexPath.row];
    PersonViewController *vc = [[PersonViewController alloc] init];
    vc.UserId = model.U_Id;
    
    [self.navigationController pushViewController:vc animated:YES];
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
