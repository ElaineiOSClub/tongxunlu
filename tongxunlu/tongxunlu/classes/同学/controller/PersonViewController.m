//
//  PersonViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonInfoCell.h"


static NSString * const cellID = @"cellID";

@interface PersonViewController ()
@property (nonatomic, strong) NSArray *titleList;
@end

@implementation PersonViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"大白菜";
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    cell.titleLabel.text = self.titleList[indexPath.row];
    cell.contentLabel.text = @"188-9109-6490";
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
