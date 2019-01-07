//
//  CRListVCCell.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRListVCCell.h"

@interface CRListVCCell ()
{
    UIView *_containerView;
    UIImageView *_imageView;
    UIView *_lineView;
    UILabel *_nameLabel;
}
@end

@implementation CRListVCCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    static CGFloat offXEnd = 36;
    static CGFloat lineWidth = 202;
    static CGFloat lineHeight = 2;
    
    _containerView = [UIView new];
    _containerView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(132);
        make.centerY.offset(0);
    }];
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_containerView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(42);
        make.top.offset(5);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(90);
    }];
    
    _lineView = [UIView new];
    _lineView.backgroundColor = color_master;
    [_containerView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(lineWidth);
        make.height.mas_equalTo(lineHeight);
        make.right.offset(-offXEnd);
        make.bottom.offset(-35);
    }];
    
    CGRect lineViewFrame = CGRectMake(0, 0, lineWidth, lineHeight);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lineViewFrame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(lineHeight/2, lineHeight/2)];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = lineViewFrame;
    maskLayer.path = maskPath.CGPath;
    _lineView.layer.mask = maskLayer;
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = color_master;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [_containerView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-offXEnd);
        make.bottom.offset(-9);
    }];
}

#pragma mark - Load Data
- (void)loadDataWithModel:(CRBoxInputModel *)model
{
    _nameLabel.text = model.name;
    _imageView.image = [UIImage imageNamed:model.imageName];
}

@end
