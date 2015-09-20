//
//  MeShieldCell.h
//  tongxunlu
//
//  Created by elaine on 15/9/15.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeShield;
@class MeShieldCell;

@protocol MeShieldCellDelegate <NSObject>

- (void)meShieldCell:(MeShieldCell *)cell btnClick:(UIButton *)button indexPath:(NSIndexPath *)indexPath;

@end

@interface MeShieldCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<MeShieldCellDelegate> delegate;
@property (nonatomic, strong) MeShield *model;
@end
