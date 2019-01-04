//
//  CRBoxInputCell.m
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import "CRBoxInputCell.h"
#import "Masonry.h"

@interface CRBoxInputCell ()
{
    
}

@property (strong, nonatomic) UILabel *valueLabel;
@property (strong, nonatomic) CABasicAnimation *opacityAnimation;

@end

@implementation CRBoxInputCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)initPara
{
    self.ifNeedCursor = YES;
    self.userInteractionEnabled = NO;
}

- (void)createUI
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
        make.width.mas_equalTo(2);
        make.centerX.offset(0);
        make.top.offset(5);
        make.bottom.offset(-5);
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
    [self removeCustomSecurityView];
    
    if (self.boxInputCellProperty.originValue && self.boxInputCellProperty.originValue.length > 0) {
        if (self.boxInputCellProperty.ifShowSecurity) {
            if (self.boxInputCellProperty.securityType == CRBoxSecurityType_Symbol) {
                _valueLabel.text = self.boxInputCellProperty.securitySymbol;
            }else if (self.boxInputCellProperty.securityType == CRBoxSecurityType_CustomView) {
                _valueLabel.hidden = YES;
                [self addCustomSecurityView];
            }
            
        }else{
            _valueLabel.text = self.boxInputCellProperty.originValue;
        }
    }else{
        _valueLabel.text = @"";
    }
}

#pragma mark - Custom security view
- (void)addCustomSecurityView
{
    [self.customSecurityView removeFromSuperview];
    [self.contentView addSubview:self.customSecurityView];
    [self.customSecurityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)removeCustomSecurityView
{
    if (self.boxInputCellProperty.securityType == CRBoxSecurityType_CustomView && self.customSecurityView.superview) {
        [self.customSecurityView removeFromSuperview];
    }
}

#pragma mark - Qiuck set
- (void)quickSetOriginValue:(NSString *)originValue {
    self.boxInputCellProperty.originValue = originValue;
    [self valueLabelLoadData];
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
    }else{
        self.layer.borderColor = self.boxInputCellProperty.cellBorderColorNormal.CGColor;
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
    self.backgroundColor = boxInputCellProperty.cellBgColor;
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
        _customSecurityView = [UIView new];
        _customSecurityView.backgroundColor = [UIColor orangeColor];
    }
    
    return _customSecurityView;
}

@end
