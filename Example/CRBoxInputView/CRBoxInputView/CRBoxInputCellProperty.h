//
//  CRBoxInputCellProperty.h
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRLineView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CRBoxSecurityType) {
    CRBoxSecuritySymbolType,
    CRBoxSecurityCustomViewType,
};

typedef UIView *_Nonnull(^CustomSecurityViewBlock)(void);
typedef CRLineView *_Nonnull(^CustomLineViewBlock)(void);
typedef void(^ConfigCellShadowBlock)(CALayer *layer);

@interface CRBoxInputCellProperty : NSObject <NSCopying>

#pragma mark - UI

/**
 cell边框宽度
 默认：0.5
 */
@property (assign, nonatomic) CGFloat borderWidth;

/**
 cell边框颜色
 状态：未选中状态时
 默认：[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1]
 */
@property (copy, nonatomic) UIColor *cellBorderColorNormal;

/**
 cell边框颜色
 状态：选中状态时
 默认：[UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1]
 */
@property (copy, nonatomic) UIColor *cellBorderColorSelected;

/**
 cell边框颜色
 状态：无填充文字，未选中状态时
 默认：与cellBorderColorFilled相同
 */
@property (copy, nonatomic) UIColor *__nullable cellBorderColorFilled;

/**
 cell背景颜色
 状态：无填充文字，未选中状态时
 默认：[UIColor whiteColor]
 */
@property (copy, nonatomic) UIColor *cellBgColorNormal;

/**
 cell背景颜色
 状态：选中状态时
 默认：[UIColor whiteColor]
 */
@property (copy, nonatomic) UIColor *cellBgColorSelected;

/**
 cell背景颜色
 状态：填充文字后，未选中状态时
 默认：与cellBgColorFilled相同
 */
@property (copy, nonatomic) UIColor *__nullable cellBgColorFilled;


/**
 光标颜色
 默认： [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1]
 */
@property (copy, nonatomic) UIColor *cellCursorColor;

/**
 光标宽度
 默认： 2
 */
@property (assign, nonatomic) CGFloat cellCursorWidth;

/**
 光标高度
 默认： 32
 */
@property (assign, nonatomic) CGFloat cellCursorHeight;

/**
 圆角
 默认： 4
 */
@property (assign, nonatomic) CGFloat cornerRadius;

#pragma mark - label
@property (copy, nonatomic) UIFont *cellFont;
@property (copy, nonatomic) UIColor *cellTextColor;

#pragma mark - line
@property (assign, nonatomic) BOOL showLine;

#pragma mark - Security
@property (assign, nonatomic) BOOL ifShowSecurity;
@property (copy, nonatomic) NSString *securitySymbol;
@property (copy, nonatomic) NSString *originValue;
@property (assign, nonatomic) CRBoxSecurityType securityType;

#pragma mark - Block
@property (copy, nonatomic) CustomSecurityViewBlock customSecurityViewBlock;
@property (copy, nonatomic) CustomLineViewBlock customLineViewBlock;
@property (copy, nonatomic) ConfigCellShadowBlock __nullable configCellShadowBlock;

#pragma mark - Test
@property (assign, nonatomic) NSInteger index;

@end

NS_ASSUME_NONNULL_END
