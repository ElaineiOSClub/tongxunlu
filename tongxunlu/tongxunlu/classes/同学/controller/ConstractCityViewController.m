//
//  ConstractCityViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/17.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "ConstractCityViewController.h"
#import "CityCell.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "ConstractCityModel.h"
#import "MJExtension.h"
#import "PersonListViewController.h"
#import "MBProgressHUD.h"

@interface ConstractCityViewController ()
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) NSMutableArray *arrayList;
@end

static NSString * const cellID = @"cellID";

@implementation ConstractCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[CityCell class] forCellReuseIdentifier:cellID];
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
    
    //获取市列表：action=getCity&Token=XXX&ProvinceID=省份ID
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx",KUrl];
    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"getCity",@"Token":[AccountTool shareAccount].account.Token,@"ProvinceID":@(self.provinceId)} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MLog(@"%@",responseObject);
        HUD.hidden = YES;
        self.arrayList = [ConstractCityModel objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLog(@"%@",error);
        HUD.labelText = @"网络异常，稍后再试";
        [HUD hide:YES afterDelay:1];
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.arrayList[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ConstractCityModel *model = self.arrayList[indexPath.row];
    PersonListViewController *vc = [[PersonListViewController alloc] initWithStyle:UITableViewStylePlain];
    vc.cityID = model.CityId;
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
