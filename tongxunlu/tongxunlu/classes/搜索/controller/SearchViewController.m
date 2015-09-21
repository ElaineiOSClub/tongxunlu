//
//  SearchViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/20.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "SearchViewController.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "PersonListModel.h"
#import "PersonViewController.h"
#import "AccountTool.h"
#import "MBProgressHUD.h"

static NSString *const cellID = @"cellID";

@interface SearchViewController ()<UISearchBarDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *arrayList;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;

    self.navigationItem.titleView = self.searchBar;
    
//    self.searchBar.width = 150;
//    self.searchBar.height = 40;
    
     self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    [self.searchBar becomeFirstResponder];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
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



#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn=[searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在加载";
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];

    
    //TokenService.asxh?action=serch&Token=XXX&Job=xxx&Name=XXX 根据工作和姓名搜索 条件需编码 URLENCODE
     NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx",KUrl];
    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"serch",@"Token":[AccountTool shareAccount].account.Token,@"Name":searchBar.text}  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.arrayList = [PersonListModel objectArrayWithKeyValuesArray:responseObject];
        HUD.hidden = YES;
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLog(@"%@",operation.responseString);
        MLog(@"%@",error);
        HUD.labelText = @"网络异常";
        [HUD hide:YES afterDelay:1];
    }];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
    UIButton *btn=[self.searchBar valueForKey:@"_cancelButton"];
    btn.enabled = YES;
}




@end
