//
//  CRBoxInputself.m
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import "CRBoxInputCellProperty.h"

@implementation CRBoxInputCellProperty

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        __weak typeof(self) weakSelf = self;
        
        // UI
        self.cellBorderColorNormal = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
        self.cellBorderColorSelected = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
        self.cellBorderColorFilled = nil;
        self.cellBgColorNormal = [UIColor whiteColor];
        self.cellBgColorSelected = [UIColor whiteColor];
        self.cellBgColorFilled = nil;
        self.cellCursorColor = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
        self.cellCursorWidth = 2;
        self.cellCursorHeight = 32;
        self.cornerRadius = 4;
        self.borderWidth = (0.5);
        
        // label
        self.cellFont = [UIFont systemFontOfSize:20];
        self.cellTextColor = [UIColor blackColor];
        
        // Security
        self.ifShowSecurity = NO;
        self.securitySymbol = @"✱";
        self.originValue = @"";
        self.securityType = CRBoxSecuritySymbolType;
        
        // Block
        self.customLineViewBlock = ^CRLineView * _Nonnull{
            return [CRLineView new];
        };
        self.customSecurityViewBlock = ^UIView * _Nonnull{
            return [weakSelf defaultCustomSecurityView];
        };
        
        // Test
        self.index = 0;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    CRBoxInputCellProperty *copy = [[self class] allocWithZone:zone];
    
    // UI
    copy.cellBorderColorNormal = [_cellBorderColorNormal copy];
    copy.cellBorderColorSelected = [_cellBorderColorSelected copy];
    if (_cellBorderColorFilled) {
        copy.cellBorderColorFilled = [_cellBorderColorFilled copy];
    }
    copy.cellBgColorNormal = [_cellBgColorNormal copy];
    copy.cellBgColorSelected = [_cellBgColorSelected copy];
    if (_cellBgColorFilled) {
        copy.cellBgColorFilled = [_cellBgColorFilled copy];
    }
    copy.cellCursorColor = [_cellCursorColor copy];
    copy.cellCursorWidth = _cellCursorWidth;
    copy.cellCursorHeight = _cellCursorHeight;
    copy.cornerRadius = _cornerRadius;
    copy.borderWidth = _borderWidth;
    
    // label
    copy.cellFont = [_cellFont copy];
    copy.cellTextColor = [_cellTextColor copy];
    
    // Security
    copy.ifShowSecurity = _ifShowSecurity;
    copy.securitySymbol = [_securitySymbol copy];
    copy.originValue = [_originValue copy];
    copy.securityType = _securityType;
    
    // Block
    copy.customLineViewBlock = [_customLineViewBlock copy];
    copy.customSecurityViewBlock = [_customSecurityViewBlock copy];
    
    // Test
    copy.index = _index;
    
    return copy;
}

- (UIView *)defaultCustomSecurityView
{
    UIView *customSecurityView = [UIView new];
    customSecurityView.backgroundColor = [UIColor clearColor];
    
    // circleView
    static CGFloat circleViewWidth = 20;
    UIView *circleView = [UIView new];
    circleView.backgroundColor = color_master;
    circleView.layer.cornerRadius = 4;
    [customSecurityView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(circleViewWidth);
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    return customSecurityView;
}

@end
