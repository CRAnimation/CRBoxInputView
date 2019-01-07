//
//  CRBoxInputCell_SecretView.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputCell_SecretView.h"

@implementation CRBoxInputCell_SecretView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSepLineView];
    }
    
    return self;
}

- (void)addSepLineView
{
    static CGFloat sepLineViewHeight = 4;
    
    UIView *_sepLineView = [UIView new];
    _sepLineView.backgroundColor = color_master;
    _sepLineView.layer.cornerRadius = sepLineViewHeight / 2.0;
    [self.contentView addSubview:_sepLineView];
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(sepLineViewHeight);
    }];
    
    _sepLineView.layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
    _sepLineView.layer.shadowOpacity = 1;
    _sepLineView.layer.shadowOffset = CGSizeMake(0, 2);
    _sepLineView.layer.shadowRadius = 4;
}

- (UIView *)createCustomSecurityView
{
    UIView *customSecurityView = [UIImageView new];
    
    UIView *rectangleView = [UIView new];
    rectangleView.layer.cornerRadius = 4;
    rectangleView.backgroundColor = color_master;
    [customSecurityView addSubview:rectangleView];
    [rectangleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(XX_6(24));
    }];
    
    rectangleView.layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
    rectangleView.layer.shadowOpacity = 1;
    rectangleView.layer.shadowOffset = CGSizeMake(0, 2);
    rectangleView.layer.shadowRadius = 4;
    
    return customSecurityView;
}

@end
