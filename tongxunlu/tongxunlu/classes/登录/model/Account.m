//
//  Account.m
//  iosNav
//
//  Created by elaine on 15/5/12.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "Account.h"

@implementation Account


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.cookie forKey:@"cookie"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.cookie = [aDecoder decodeObjectForKey:@"cookie"];
    }
    return self;
}

@end
