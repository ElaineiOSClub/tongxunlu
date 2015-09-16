//
//  AccountTool.h
//  iosNav
//
//  Created by elaine on 15/5/12.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountTool : NSObject
+ (instancetype)shareAccount;

- (void)saveAccount:(Account *)account;

@property (nonatomic, strong) Account *account;

@end
