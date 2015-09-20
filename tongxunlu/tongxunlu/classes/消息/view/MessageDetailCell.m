//
//  MessageDetailCell.m
//  tongxunlu
//
//  Created by elaine on 15/9/13.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "MessageDetailCell.h"
#import "MessageDetail.h"

@interface MessageDetailCell()
@property (nonatomic, strong) UILabel *titleTextLabel;
@property (nonatomic, strong) UILabel *contentTextLabel;
@end

@implementation MessageDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleTextLabel];
        [self addSubview:self.contentTextLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self tmp];
    }
    return self;
}

- (void)tmp
{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:@"十大商店就是大神见到手十大商"];
    [attributed addAttribute:NSFontAttributeName value:self.titleTextLabel.font range:NSMakeRange(0, attributed.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,attributed.length)];
    self.titleTextLabel.attributedText = attributed;
    
    attributed = [[NSMutableAttributedString alloc] initWithString:@"啥的阿什顿阿山地晒U盾会死啊啥都会卡仕达看哈但是的撒旦很快就撒谎就看到撒谎就肯定会快睡觉奥号地块和卡萨很快就好可适当回喀什的 "];
    [attributed addAttribute:NSFontAttributeName value:self.contentTextLabel.font range:NSMakeRange(0, attributed.length)];
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,attributed.length)];
    self.contentTextLabel.attributedText = attributed;
    
}

- (void)setMessage:(MessageDetail *)message
{
    _message = message;
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:_message.PN_Title];
    [attributed addAttribute:NSFontAttributeName value:self.titleTextLabel.font range:NSMakeRange(0, attributed.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,attributed.length)];
    self.titleTextLabel.attributedText = attributed;
    
    attributed = [[NSMutableAttributedString alloc] initWithString:_message.PN_Content];
    [attributed addAttribute:NSFontAttributeName value:self.contentTextLabel.font range:NSMakeRange(0, attributed.length)];
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    [attributed addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,attributed.length)];
    self.contentTextLabel.attributedText = attributed;
    
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleTextLabel.size = [self.titleTextLabel sizeThatFits:CGSizeMake(kScreenW - 20, MAXFLOAT)];
    self.titleTextLabel.x = 10;
    self.titleTextLabel.y = 20;
    
    self.contentTextLabel.size =[self.contentTextLabel sizeThatFits:CGSizeMake(kScreenW - 20, MAXFLOAT)];
    self.contentTextLabel.y = CGRectGetMaxY(self.titleTextLabel.frame) + 20;
    self.contentTextLabel.x = 10;
    
}

#pragma mark - lazy

- (UILabel *)titleTextLabel
{
    if (!_titleTextLabel) {
        _titleTextLabel = [[UILabel alloc] init];
        _titleTextLabel.font = [UIFont systemFontOfSize:20];
        _titleTextLabel.numberOfLines = 0;
    }
    return _titleTextLabel;
}

- (UILabel *)contentTextLabel
{
    if (!_contentTextLabel) {
        _contentTextLabel = [[UILabel alloc] init];
        _contentTextLabel.font = [UIFont systemFontOfSize:16];
        _contentTextLabel.numberOfLines = 0;
    }
    return _contentTextLabel;
}

@end
