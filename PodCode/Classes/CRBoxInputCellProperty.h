//
//  CRBoxInputCellProperty.h
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CRBoxInputView/CRLineView.h>

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



#pragma mark - line
/**
 显示下划线
 默认： NO
 */
@property (assign, nonatomic) BOOL showLine;



#pragma mark - label
/**
 字体/字号
 默认：[UIFont systemFontOfSize:20];
 */
@property (copy, nonatomic) UIFont *cellFont;

/**
 字体颜色
 默认：[UIColor blackColor];
 */
@property (copy, nonatomic) UIColor *cellTextColor;



#pragma mark - Security
/**
 是否密文显示
 默认：NO
 */
@property (assign, nonatomic) BOOL ifShowSecurity;

/**
 密文符号
 默认：✱
 说明：只有ifShowSecurity=YES时，有效
 */
@property (copy, nonatomic) NSString *securitySymbol;

/**
 保存当前显示的字符
 若想一次性修改所有输入值，请使用 CRBoxInputView中的'reloadInputString'方法
 禁止修改该值！！！（除非你知道该怎么使用它。）
 */
@property (copy, nonatomic, readonly) NSString *originValue;
- (void)setMyOriginValue:(NSString *)originValue;

/**
 密文类型
 默认：CRBoxSecuritySymbolType
 类型说明：
 CRBoxSecuritySymbolType 符号类型，根据securitySymbol，originValue的内容来显示
 CRBoxSecurityCustomViewType 自定义View类型，可以自定义密文状态下的图片，View
 */
@property (assign, nonatomic) CRBoxSecurityType securityType;



#pragma mark - Placeholder
/**
 占位符默认填充值
 禁止修改该值！！！（除非你知道该怎么使用它。）
 */
@property (strong, nonatomic) NSString  *__nullable cellPlaceholderText;

/**
 占位符字体颜色
 默认：[UIColor colorWithRed:114/255.0 green:126/255.0 blue:124/255.0 alpha:0.3];
 */
@property (copy, nonatomic) UIColor *cellPlaceholderTextColor;

/**
 占位符字体/字号
 默认：[UIFont systemFontOfSize:20];
 */
@property (copy, nonatomic) UIFont *cellPlaceholderFont;



#pragma mark - Block
/**
 自定义密文View回调
 */
@property (copy, nonatomic) CustomSecurityViewBlock customSecurityViewBlock;
/**
 自定义下划线回调
 */
@property (copy, nonatomic) CustomLineViewBlock customLineViewBlock;
/**
 自定义阴影回调
 */
@property (copy, nonatomic) ConfigCellShadowBlock __nullable configCellShadowBlock;



#pragma mark - Test
@property (assign, nonatomic) NSInteger index;

@end

NS_ASSUME_NONNULL_END
