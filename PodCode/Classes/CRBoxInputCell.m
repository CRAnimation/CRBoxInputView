//
//  CRBoxInputCell.m
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import "CRBoxInputCell.h"
#import <Masonry/Masonry.h>
#import "CRLineView.h"

@interface CRBoxInputCell ()
{
    
}

@property (strong, nonatomic) UILabel *valueLabel;
@property (strong, nonatomic) CABasicAnimation *opacityAnimation;
@property (strong, nonatomic) UIView *customSecurityView;

@property (strong, nonatomic) CRLineView *lineView;

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
    
    // 默认字体配置
    __weak typeof(self) weakSelf = self;
    void (^defaultTextConfig)(void) = ^{
        if (weakSelf.boxInputCellProperty.cellFont) {
            weakSelf.valueLabel.font = weakSelf.boxInputCellProperty.cellFont;
        }
        
        if (weakSelf.boxInputCellProperty.cellTextColor) {
            weakSelf.valueLabel.textColor = weakSelf.boxInputCellProperty.cellTextColor;
        }
    };
    
    // 占位字符字体配置
    void (^placeholderTextConfig)(void) = ^{
        if (weakSelf.boxInputCellProperty.cellFont) {
            weakSelf.valueLabel.font = weakSelf.boxInputCellProperty.cellPlaceholderFont;
        }
        
        if (weakSelf.boxInputCellProperty.cellTextColor) {
            weakSelf.valueLabel.textColor = weakSelf.boxInputCellProperty.cellPlaceholderTextColor;
        }
    };
    
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
        defaultTextConfig();
    }else{
        BOOL hasPlaceholderText = self.boxInputCellProperty.cellPlaceholderText && self.boxInputCellProperty.cellPlaceholderText.length > 0;
        // 有占位字符
        if (hasPlaceholderText) {
            _valueLabel.text = self.boxInputCellProperty.cellPlaceholderText;
            placeholderTextConfig();
        }
        // 空
        else{
            _valueLabel.text = @"";
            defaultTextConfig();
        }
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
    // Must add this judge. Otherwise _customSecurityView maybe null, and cause error.
    if (_customSecurityView) {
        self.customSecurityView.alpha = 0;
    }
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
    
    if (_lineView) {
        // 未选中
        if (!selected) {
            if (self.boxInputCellProperty.originValue.length > 0 && _lineView.underlineColorFilled) {
                // 有内容
                _lineView.lineView.backgroundColor = _lineView.underlineColorFilled;
            }else if (_lineView.underlineColorNormal) {
                // 无内容
                _lineView.lineView.backgroundColor = _lineView.underlineColorNormal;
            }else{
                // 默认
                _lineView.lineView.backgroundColor = CRColorMaster;
            }
        }
        // 已选中
        else if (selected && _lineView.underlineColorSelected){
            _lineView.lineView.backgroundColor = _lineView.underlineColorSelected;
        }
        // 默认
        else{
            _lineView.lineView.backgroundColor = CRColorMaster;
        }
        
        _lineView.selected = selected;
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
    
    [self valueLabelLoadData];
}

- (UIView *)customSecurityView
{
    if (!_customSecurityView) {
        // Compatiable for 0.19 verion and earlier.
        if ([self respondsToSelector:@selector(createCustomSecurityView)]) {
            _customSecurityView = [self createCustomSecurityView];
        }
        else if(_boxInputCellProperty.customSecurityViewBlock){
            NSAssert(_boxInputCellProperty.customSecurityViewBlock, @"customSecurityViewBlock can not be null！");
            _customSecurityView = _boxInputCellProperty.customSecurityViewBlock();
        }
    }
    
    return _customSecurityView;
}

- (void)layoutSubviews
{
    __weak typeof(self) weakSelf = self;
    
    if (_boxInputCellProperty.showLine && !_lineView) {
        NSAssert(_boxInputCellProperty.customLineViewBlock, @"customLineViewBlock can not be null！");
        _lineView = _boxInputCellProperty.customLineViewBlock();
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.offset(0);
        }];
    }
    
    if (_boxInputCellProperty.configCellShadowBlock) {
        _boxInputCellProperty.configCellShadowBlock(weakSelf.layer);
    }
    
    [super layoutSubviews];
}

@end
