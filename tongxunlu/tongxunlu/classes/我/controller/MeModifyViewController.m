//
//  MeModifyViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/21.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MeModifyViewController.h"
#import "AccountTool.h"
#import "HttpTool.h"

@interface MeModifyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@end

@implementation MeModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电话号码";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : KColor(0, 203, 95)} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = item;
    
    self.phoneField.text = [AccountTool shareAccount].account.U_Phone;
    [self.phoneField becomeFirstResponder];
    
}

- (void)save
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
