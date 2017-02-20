//
//  MLCollectionViewCell.m
//  MLHorizontalCollectionViewFlowLayout
//
//  Created by Wang Mengqi on 17/2/20.
//  Copyright © 2017年 Wang Mengqi. All rights reserved.
//

#import "MLCollectionViewCell.h"

@interface MLCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MLCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self afterView];
        [self resize];
    }
    return self;
}

- (void)afterView{
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.titleLabel];
}

- (void)resize{
    CGRect frame = _titleLabel.frame;
    frame.origin.x = 5.0;
    _titleLabel.frame = frame;
    CGPoint center = _titleLabel.center;
    center.y = self.frame.size.height/2;
    _titleLabel.center = center;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _titleLabel;
}

- (void)setText:(NSString *)text
{
    _titleLabel.text = text;
    [_titleLabel sizeToFit];
    [self resize];
}

+ (CGSize)size:(NSString *)text
{
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)
                       options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{
                                 NSFontAttributeName : [UIFont systemFontOfSize:12.0]
                                 } context:nil];
    return CGSizeMake(textRect.size.width + 10.0, 20.0);
}

@end
