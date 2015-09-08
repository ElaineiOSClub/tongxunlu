//
//  NSString+Extension.m
//  iosNav
//
//  Created by elaine on 15/8/25.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)containsStringWithios7:(NSString *)aString
{
    NSRange range = [self rangeOfString:aString];
    if (range.length > 0) {
        return YES;
    }
    return NO;
}
@end
