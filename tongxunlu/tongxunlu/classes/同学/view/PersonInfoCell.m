//
//  PersonInfoCell.m
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "PersonInfoCell.h"

@interface PersonInfoCell()


@end

@implementation PersonInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.x = 20;
    self.titleLabel.y = 10;
    
    self.contentLabel.size = [self.contentLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.contentLabel.y = CGRectGetMaxY(self.titleLabel.frame) + 5;
    self.contentLabel.x = 20;
    
}


#pragma mark - lazy
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = KColor(0,203,90);
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
        
    }
    return _contentLabel;
}


@end
