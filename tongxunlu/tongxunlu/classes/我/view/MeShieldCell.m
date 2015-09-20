//
//  MeShieldCell.m
//  tongxunlu
//
//  Created by elaine on 15/9/15.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MeShieldCell.h"
#import "MeShield.h"

@interface MeShieldCell()
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation MeShieldCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setModel:(MeShield *)model
{
    _model = model;
    self.classLabel.text = model.name;
    self.btn.selected = model.isOK;
}


- (IBAction)btnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(meShieldCell:btnClick:indexPath:)]) {
        sender.selected = !sender.selected;
        [self.delegate meShieldCell:self btnClick:sender indexPath:self.indexPath];
    }
}

@end
