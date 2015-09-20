//
//  MessageCell.m
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MessageCell.h"
#import "MessageList.h"

@interface MessageCell()
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *userNameTextLabel;
@property (nonatomic, strong) UILabel *dateTextLabel;
@property (nonatomic, strong) UILabel *titleTextLabel;
@end

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleImageView];
        [self addSubview:self.userNameTextLabel];
        [self addSubview:self.dateTextLabel];
        [self addSubview:self.titleTextLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    return self;
}

- (void)setModel:(MessageList *)model
{
    _model = model;
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:model.Title];
    [attributed addAttribute:NSFontAttributeName value:self.titleTextLabel.font range:NSMakeRange(0, attributed.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,attributed.length)];
    self.titleTextLabel.attributedText = attributed;
    
    self.userNameTextLabel.text = model.Sender;
    self.dateTextLabel.text = model.PushTime;
    
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.titleImageView.centerY = self.height/2;
//    self.titleImageView.x = 10;
    [self.userNameTextLabel sizeToFit];
    self.userNameTextLabel.x = 16;
    self.userNameTextLabel.y = 10;
    
    [self.dateTextLabel sizeToFit];
    self.dateTextLabel.x = CGRectGetMaxX(self.userNameTextLabel.frame) + 10;
    self.dateTextLabel.y = self.userNameTextLabel.y;
    
    self.titleTextLabel.size = [self.titleTextLabel sizeThatFits:CGSizeMake(kScreenW - 16 - 40, MAXFLOAT)];
//    self.titleTextLabel.size = [self.titleTextLabel.attributedText boundingRectWithSize:CGSizeMake(kScreenW - 16 - 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    
    self.titleTextLabel.x = 16;
    self.titleTextLabel.y = CGRectGetMaxY(self.dateTextLabel.frame) + 10;
    
}

#pragma mark - lazy
- (UILabel *)userNameTextLabel
{
    if (!_userNameTextLabel) {
        _userNameTextLabel = [[UILabel alloc] init];
        _userNameTextLabel.font = [UIFont systemFontOfSize:13];
        _userNameTextLabel.textColor = KColor(63, 141, 172);
        _userNameTextLabel.text = @"Admin";
    }
    return _userNameTextLabel;
}

- (UILabel *)dateTextLabel
{
    if (!_dateTextLabel) {
        _dateTextLabel = [[UILabel alloc] init];
        _dateTextLabel.font = [UIFont systemFontOfSize:13];
        _dateTextLabel.textColor = KColor(187, 187, 187);
        _dateTextLabel.text = @"2015-12-12 20:23";
    }
    return _dateTextLabel;
}

- (UILabel *)titleTextLabel
{
    if (!_titleTextLabel) {
        _titleTextLabel = [[UILabel alloc] init];
        _titleTextLabel.font = [UIFont systemFontOfSize:16];
        _titleTextLabel.numberOfLines = 0;
        _titleTextLabel.text = @"献给永阳迷茫和孤独的你";
        [_titleTextLabel setLineBreakMode:NSLineBreakByCharWrapping];
    }
    return _titleTextLabel;
}

//- (UIImageView *)titleImageView
//{
//    if (!_titleImageView) {
//        _titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Message_128px_1142175_easyicon"]];
//        _titleImageView.size = CGSizeMake(40, 40);
//    }
//    return _titleImageView;
//}


@end
