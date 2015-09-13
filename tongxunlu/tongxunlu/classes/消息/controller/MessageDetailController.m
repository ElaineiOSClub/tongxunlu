//
//  MessageDetailController.m
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MessageDetailController.h"
#import "MessageDetailCell.h"


static NSString *const cellID = @"cellID";

@interface MessageDetailController ()

@end

@implementation MessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] init];
    view.height = 50;
    view.backgroundColor = KColor(252, 252, 252);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = KColor(213, 213, 213);
    lineView.height = 1;
    lineView.width = kScreenW;
    lineView.y = 49;
    [view addSubview:lineView];
    
    UILabel *userLable = [[UILabel alloc] init];
    userLable.text = @"Admin";
    userLable.font = [UIFont systemFontOfSize:14];
    [userLable sizeToFit];
    userLable.x = 16;
    userLable.y = 8;
    [view addSubview:userLable];
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.text = @"2012-12-12 12:12";
     dateLabel.font = [UIFont systemFontOfSize:13];
    dateLabel.textColor = KColor(187, 187, 187);
    [dateLabel sizeToFit];
    dateLabel.x = 16;
    dateLabel.y = CGRectGetMaxY(userLable.frame) + 5;
    [view addSubview:dateLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发布者" forState:UIControlStateNormal];
    [button setTitleColor:KColor(247, 95, 75) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 2;
    button.layer.borderColor = [KColor(247, 95, 75) CGColor];
    button.size = CGSizeMake(45, userLable.height);
    button.y = 8;
    button.x = CGRectGetMaxX(userLable.frame) + 4;
    
    [view addSubview:button];
    self.tableView.tableHeaderView = view;
    self.tableView.bounces = NO;
    
    [self.tableView registerClass:[MessageDetailCell class] forCellReuseIdentifier:cellID];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenH - 64 - 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID
                                                              forIndexPath:indexPath];
    
    
    
    return cell;
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
