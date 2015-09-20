//
//  MessageCell.h
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageList;

@interface MessageCell : UITableViewCell
@property (nonatomic, strong) MessageList *model;
@end
