//
//  MeOutCell.m
//  tongxunlu
//
//  Created by elaine on 15/9/10.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MeOutCell.h"

@implementation MeOutCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews
{
    [super layoutSubviews];
//    
//    NSLog(@"%f",self.textLabel.width);
//    self.textLabel.x = self.width/2 - self.textLabel.width/2;
}

@end
