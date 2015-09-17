//
//  CityCell.m
//  tongxunlu
//
//  Created by elaine on 15/9/17.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "CityCell.h"
#import "ConstractCityModel.h"

@interface CityCell()
@property (nonatomic, strong) UILabel *cityTextLabel;
@property (nonatomic, strong) UIButton *numberTextBtn;
@end

@implementation CityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.cityTextLabel];
        
        [self.contentView addSubview:self.numberTextBtn];
    }
    return self;
}

- (void)setModel:(ConstractCityModel *)model
{
    _model = model;
    self.cityTextLabel.text = model.CityName;
    [self.numberTextBtn setTitle:[NSString stringWithFormat:@"%ld",model.UserNum] forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.cityTextLabel sizeToFit];
    
    self.cityTextLabel.centerY = self.height/2;
    self.cityTextLabel.x = 20;
    
    
    self.numberTextBtn.centerY = self.height/2;
    self.numberTextBtn.x = self.width - self.numberTextBtn.width - 20;
    
    
}

#pragma mark - lazy
- (UILabel *)cityTextLabel
{
    if (!_cityTextLabel) {
        _cityTextLabel = [[UILabel alloc] init];
        _cityTextLabel.numberOfLines = 1;
        _cityTextLabel.font = [UIFont systemFontOfSize:16];
        _cityTextLabel.textColor = [UIColor blackColor];
        _cityTextLabel.text = @"湖南省";
    }
    return _cityTextLabel;
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
