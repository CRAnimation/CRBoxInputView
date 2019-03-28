//
//  CRBoxInputCell.m
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import "CRBoxInputCell.h"
#import <Masonry/Masonry.h>

@interface CRBoxInputCell ()
{
    
}

@property (strong, nonatomic) UILabel *valueLabel;
@property (strong, nonatomic) CABasicAnimation *opacityAnimation;
@property (strong, nonatomic) UIView *customSecurityView;

@end

@implementation CRBoxInputCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUIBase];
    }
    
    return self;
}

- (void)initPara
{
    self.ifNeedCursor = YES;
    self.userInteractionEnabled = NO;
}

- (void)createUIBase
{
    [self initPara];
    
    _valueLabel = [UILabel new];
    _valueLabel.font = [UIFont systemFontOfSize:38];
    [self.contentView addSubview:_valueLabel];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    _cursorView = [UIView new];
    [self.contentView addSubview:_cursorView];
    [_cursorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    [self initCellProperty];
}

- (void)initCellProperty
{
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    self.boxInputCellProperty = cellProperty;
}

- (void)valueLabelLoadData
{
    _valueLabel.hidden = NO;
    [self hideCustomSecurityView];
    
    BOOL hasOriginValue = self.boxInputCellProperty.originValue && self.boxInputCellProperty.originValue.length > 0;
    if (hasOriginValue) {
        if (self.boxInputCellProperty.ifShowSecurity) {
            if (self.boxInputCellProperty.securityType == CRBoxSecuritySymbolType) {
                _valueLabel.text = self.boxInputCellProperty.securitySymbol;
            }else if (self.boxInputCellProperty.securityType == CRBoxSecurityCustomViewType) {
                _valueLabel.hidden = YES;
                [self showCustomSecurityView];
            }
            
        }else{
            _valueLabel.text = self.boxInputCellProperty.originValue;
        }
    }else{
        _valueLabel.text = @"";
    }
}

#pragma mark - Custom security view
- (void)showCustomSecurityView
{
    if (!self.customSecurityView.superview) {
        [self.contentView addSubview:self.customSecurityView];
        [self.customSecurityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    
    self.customSecurityView.alpha = 1;
}

- (void)hideCustomSecurityView
{
    self.customSecurityView.alpha = 0;
}

#pragma mark - Setter & Getter
- (CABasicAnimation *)opacityAnimation
{
    if (!_opacityAnimation) {
        _opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityAnimation.fromValue = @(1.0);
        _opacityAnimation.toValue = @(0.0);
        _opacityAnimation.duration = 0.9;
        _opacityAnimation.repeatCount = HUGE_VALF;
        _opacityAnimation.removedOnCompletion = YES;
        _opacityAnimation.fillMode = kCAFillModeForwards;
        _opacityAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    
    return _opacityAnimation;
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.layer.borderColor = self.boxInputCellProperty.cellBorderColorSelected.CGColor;
        self.backgroundColor = self.boxInputCellProperty.cellBgColorSelected;
    }else{
        BOOL hasFill = _valueLabel.text.length > 0 ? YES : NO;
        UIColor *cellBorderColor = self.boxInputCellProperty.cellBorderColorNormal;
        UIColor *cellBackgroundColor = self.boxInputCellProperty.cellBgColorNormal;
        if (hasFill) {
            if (self.boxInputCellProperty.cellBorderColorFilled) {
                cellBorderColor = self.boxInputCellProperty.cellBorderColorFilled;
            }
            if (self.boxInputCellProperty.cellBgColorFilled) {
                cellBackgroundColor = self.boxInputCellProperty.cellBgColorFilled;
            }
        }
        self.layer.borderColor = cellBorderColor.CGColor;
        self.backgroundColor = cellBackgroundColor;
    }
    
    if (_ifNeedCursor) {
        if (selected) {
            _cursorView.hidden= NO;
            [_cursorView.layer addAnimation:self.opacityAnimation forKey:CRBoxCursoryAnimationKey];
        }else{
            _cursorView.hidden= YES;
            [_cursorView.layer removeAnimationForKey:CRBoxCursoryAnimationKey];
        }
    }else{
        _cursorView.hidden= YES;
    }
}

- (void)setBoxInputCellProperty:(CRBoxInputCellProperty *)boxInputCellProperty
{
    _boxInputCellProperty = boxInputCellProperty;
    
    _cursorView.backgroundColor = boxInputCellProperty.cellCursorColor;
    [_cursorView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(boxInputCellProperty.cellCursorWidth);
        make.height.mas_equalTo(boxInputCellProperty.cellCursorHeight);
    }];
    self.layer.cornerRadius = boxInputCellProperty.cornerRadius;
    self.layer.borderWidth = boxInputCellProperty.borderWidth;
    
    if (boxInputCellProperty.cellFont) {
        _valueLabel.font = boxInputCellProperty.cellFont;
    }
    
    if (boxInputCellProperty.cellTextColor) {
        _valueLabel.textColor = boxInputCellProperty.cellTextColor;
    }
    
    [self valueLabelLoadData];
}

- (UIView *)customSecurityView
{
    if (!_customSecurityView) {
        _customSecurityView = [self createCustomSecurityView];
    }
    
    return _customSecurityView;
}

#pragma mark - You can rewrite
- (UIView *)createCustomSecurityView
{
    UIView *customSecurityView = [UIView new];
    customSecurityView.backgroundColor = [UIColor clearColor];
    
    // circleView
    static CGFloat circleViewWidth = 20;
    UIView *circleView = [UIView new];
    circleView.backgroundColor = [UIColor orangeColor];
    circleView.layer.cornerRadius = circleViewWidth / 2;
    [customSecurityView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(circleViewWidth);
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    return customSecurityView;
}

@end
