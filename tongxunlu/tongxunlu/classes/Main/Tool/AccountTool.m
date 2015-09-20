//
//  AccountTool.m
//  iosNav
//
//  Created by elaine on 15/5/12.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "AccountTool.h"

#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

static AccountTool *_instance;

@implementation AccountTool


- (instancetype)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

+ (instancetype)shareAccount
{
    if(_instance == nil)
    {
        _instance = [[self alloc] init];
    }
    return _instance;
}


+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


- (void)saveAccount:(Account *)account
{
    
    MLog(@"%@",kFile);
    _account = account;
    
    NSInteger U_Birthday = [[account.U_Birthday substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    NSInteger year = [dateComponent year];
    
    account.U_Birthday = [NSString stringWithFormat:@"%ld",year - U_Birthday + 1];
    
    account.U_Sex = [account.U_Sex isEqualToString:@"1"]?@"男":@"女";
    
    
    
    
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
    
}

- (void)deleteAccount
{
    [[NSFileManager defaultManager] removeItemAtPath:kFile error:nil];
}



@end
