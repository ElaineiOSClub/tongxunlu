//
//  MeShieldViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/15.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MeShieldViewController.h"
#import "MeShieldCell.h"

static NSString *const cellID = @"cellID";

@interface MeShieldViewController ()<MeShieldCellDelegate>

@end

@implementation MeShieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    [item setTintColor:KColor(0, 203, 95)];
    self.navigationItem.rightBarButtonItem = item;
    

    [self.tableView registerNib:[UINib nibWithNibName:@"MeShieldCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    

}

#pragma mark - event response
- (void)submit:(UIBarButtonItem *)item
{
    MLog(@"提交");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeShieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark - MeShieldCellDelegate
- (void)meShieldCell:(MeShieldCell *)cell btnClick:(UIButton *)button indexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}





@end
