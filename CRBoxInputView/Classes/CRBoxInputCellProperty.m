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
        
        // UI
        self.cellBorderColorNormal = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
        self.cellBorderColorSelected = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
        self.cellBgColor = [UIColor whiteColor];
        self.cellCursorColor = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
        self.cornerRadius = 4;
        self.borderWidth = (0.5);
        
        // label
//        self.cellFont = nil;
//        self.cellTextColor = nil;
        
        // Security
        self.ifShowSecurity = NO;
        self.securitySymbol = @"✱";
        self.originValue = @"";
        self.securityType = CRBoxSecurityType_Symbol;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    CRBoxInputCellProperty *copy = [[self class] allocWithZone:zone];
    
    // UI
    copy.cellBorderColorNormal = [_cellBorderColorNormal copy];
    copy.cellBorderColorSelected = [_cellBorderColorSelected copy];
    copy.cellBgColor = [_cellBgColor copy];
    copy.cellCursorColor = [_cellCursorColor copy];
    copy.cornerRadius = _cornerRadius;
    copy.borderWidth = _borderWidth;
    
    // label
    if (_cellFont) {
        copy.cellFont = [_cellFont copy];
    }
    if (_cellTextColor) {
        copy.cellTextColor = [_cellTextColor copy];
    }
    
    // Security
    copy.ifShowSecurity = _ifShowSecurity;
    copy.securitySymbol = [_securitySymbol copy];
    copy.originValue = [_originValue copy];
    copy.securityType = _securityType;
    
    
    return copy;
}

@end
