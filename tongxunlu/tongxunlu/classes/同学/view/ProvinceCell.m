//
//  ProvinceCell.m
//  tongxunlu
//
//  Created by elaine on 15/9/9.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "ProvinceCell.h"

@interface ProvinceCell()
@property (nonatomic, strong) UILabel *provinceTextLabel;
@property (nonatomic, strong) UIButton *numberTextBtn;
@end

@implementation ProvinceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.provinceTextLabel];
        
        [self.contentView addSubview:self.numberTextBtn];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.provinceTextLabel sizeToFit];
    
    self.provinceTextLabel.centerY = self.height/2;
    self.provinceTextLabel.x = 20;
    
    
    self.numberTextBtn.centerY = self.height/2;
    self.numberTextBtn.x = self.width - self.numberTextBtn.width - 20;
    
    
}

#pragma mark - lazy
- (UILabel *)provinceTextLabel
{
    if (!_provinceTextLabel) {
        _provinceTextLabel = [[UILabel alloc] init];
        _provinceTextLabel.numberOfLines = 1;
        _provinceTextLabel.font = [UIFont systemFontOfSize:16];
        _provinceTextLabel.textColor = [UIColor blackColor];
        _provinceTextLabel.text = @"湖南省";
    }
    return _provinceTextLabel;
}

- (UIButton *)numberTextBtn
{
    if (!_numberTextBtn) {
        _numberTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_numberTextBtn setTitle:@"120" forState:UIControlStateNormal];
        _numberTextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_numberTextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_numberTextBtn setBackgroundImage:[UIImage imageNamed:@"Slice 1"] forState:UIControlStateNormal];
        _numberTextBtn.size = _numberTextBtn.currentBackgroundImage.size;
        MLog(@"%@",NSStringFromCGSize(_numberTextBtn.size));
       // _numberTextBtn.enabled = NO;
        _numberTextBtn.userInteractionEnabled = NO;
    }
    return _numberTextBtn;
}



@end
