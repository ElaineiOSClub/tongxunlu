//
//  MeShieldCell.m
//  tongxunlu
//
//  Created by elaine on 15/9/15.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MeShieldCell.h"

@interface MeShieldCell()
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation MeShieldCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)btnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(meShieldCell:btnClick:indexPath:)]) {
        [self.delegate meShieldCell:self btnClick:sender indexPath:self.indexPath];
    }
}

@end
