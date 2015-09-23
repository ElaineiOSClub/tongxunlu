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

@interface SearchViewController ()<UISearchBarDelegate,UITextFieldDelegate>
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;

    //self.navigationItem.titleView = self.searchBar;
    
//    self.searchBar.width = 150;
//    self.searchBar.height = 40;
    
     self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    [self.searchBar becomeFirstResponder];
    
    
    _textField = [[UITextField alloc] init];
    _textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qq_active_search_finder_grey"]];
    _textField.leftViewMode = UITextFieldViewModeAlways;
//    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"搜索:职业或者名字";
    _textField.size = CGSizeMake(MAXFLOAT, 30);
    _textField.delegate = self;
    _textField.font = [UIFont systemFontOfSize:15];
    [_textField setReturnKeyType:UIReturnKeySearch];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.navigationItem.titleView = _textField;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    [rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName : KColor(0, 203, 95)} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [_textField becomeFirstResponder];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在加载";
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    
    
    //TokenService.asxh?action=serch&Token=XXX&Job=xxx&Name=XXX 根据工作和姓名搜索 条件需编码 URLENCODE
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx?action=serch&Token=%@&Name=%@",KUrl,[AccountTool shareAccount].account.Token,textField.text];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    [HttpTool httpToolGet:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MLog(@"%@",responseObject);
        self.arrayList = [PersonListModel objectArrayWithKeyValuesArray:responseObject];
        HUD.hidden = YES;
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLog(@"%@",operation.responseString);
        MLog(@"%@",error);
        HUD.labelText = @"网络异常";
        [HUD hide:YES afterDelay:1];
    }];

    return YES;
}

- (void)cancel
{
    [self.textField resignFirstResponder];
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
     NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/TokenService.ashx?action=serch&Token=%@&Name=%@",KUrl,[AccountTool shareAccount].account.Token,searchBar.text];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    [HttpTool httpToolGet:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MLog(@"%@",responseObject);  
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
