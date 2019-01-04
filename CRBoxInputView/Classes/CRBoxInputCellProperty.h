//
//  CRBoxInputCellProperty.h
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRBoxInputCellProperty : NSObject <NSCopying>

// UI
@property (copy, nonatomic) UIColor *cellBorderColorNormal;
@property (copy, nonatomic) UIColor *cellBorderColorSelected;
@property (copy, nonatomic) UIColor *cellBgColor;
@property (copy, nonatomic) UIColor *cellCursorColor; //光标颜色
@property (assign, nonatomic) CGFloat cornerRadius;
@property (assign, nonatomic) CGFloat borderWidth;

// label
@property (copy, nonatomic) UIFont *cellFont;
@property (copy, nonatomic) UIColor *cellTextColor;

// Security
@property (assign, nonatomic) BOOL ifShowSecurity;
@property (copy, nonatomic) NSString *securitySymbol;
@property (copy, nonatomic) NSString *originValue;

@end

NS_ASSUME_NONNULL_END
