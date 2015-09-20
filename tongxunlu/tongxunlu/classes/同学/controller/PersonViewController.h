//
//  PersonViewController.h
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonListModel.h"
@interface PersonViewController : UITableViewController
@property (nonatomic, assign) NSInteger UserId;
@property (nonatomic, strong) PersonListModel *personModel;
@end
