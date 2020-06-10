//
//  CRLineView.h
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/6/10.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define CRColorMaster [UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]

@interface CRLineView : UIView

typedef void(^CRLineViewSelectChangeBlock)(CRLineView *lineView, BOOL selected);

@property (strong, nonatomic) UIView    *lineView;
@property (assign, nonatomic) BOOL      selected;

/**
 下划线颜色
 状态：未选中状态，且没有填充文字时
 默认：[UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]
 */
@property (copy, nonatomic) UIColor *underlineColorNormal;

/**
 下划线颜色
 状态：选中状态时
 默认：[UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]
 */
@property (copy, nonatomic) UIColor *underlineColorSelected;

/**
 下划线颜色
 状态：未选中状态，且有填充文字时
 默认：[UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]
 */
@property (copy, nonatomic) UIColor *underlineColorFilled;

/**
 选择状态改变时回调
 */
@property (copy, nonatomic) CRLineViewSelectChangeBlock __nullable selectChangeBlock;

- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
