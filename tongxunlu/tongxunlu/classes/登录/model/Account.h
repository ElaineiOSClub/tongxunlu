//
//  Account.h
//  iosNav
//
//  Created by elaine on 15/5/12.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *cookie;
@property (nonatomic, copy) NSString *imageStr;
@end
