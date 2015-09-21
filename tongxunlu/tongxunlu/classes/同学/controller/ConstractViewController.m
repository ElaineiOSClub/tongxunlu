//
//  ConstractViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/9.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "ConstractViewController.h"
#import "ProvinceCell.h"

#import "PersonViewController.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "MJExtension.h"
#import "ConstractCityViewController.h"
#import "ConstractProvinceModel.h"

#import "MBProgressHUD.h"

#import "SearchViewController.h"
#import "MainNavigationViewController.h"

static NSString *const cellID = @"cell";

@interface ConstractViewController ()
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) NSMutableArray *arrayList;
@end

@implementation ConstractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系人";
    [self.tableView registerClass:[ProvinceCell class] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [[UIView alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:KColor(0, 203, 95)} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)search
{
    
    SearchViewController *vc = [[SearchViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
//    MainNavigationViewController *nav = [[MainNavigationViewController alloc] initWithRootViewController:vc];
//    
//    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在加载";
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];

    //    /AppDo/TokenService.ashx
    //    获取省列表：action=getProvinceList&Token=XXX
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx",KUrl];
    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"getProvinceList",@"Token":[AccountTool shareAccount].account.Token} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MLog(@"%@",responseObject);
        
        self.arrayList = [ConstractProvinceModel objectArrayWithKeyValuesArray:responseObject];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"UserNum == 0"];
        
        [self.arrayList removeObjectsInArray:[self.arrayList filteredArrayUsingPredicate:pred]];
        
        MLog(@"%@",self.arrayList);
        HUD.hidden = YES;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLog(@"%@",operation.responseString);
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
    ProvinceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
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
    
    ConstractCityViewController *cityVC = [[ConstractCityViewController alloc] initWithStyle:UITableViewStylePlain];
    ConstractProvinceModel *model = self.arrayList[indexPath.row];
    cityVC.provinceId  = model.ProvinceId;
    [self.navigationController pushViewController:cityVC animated:YES];
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
