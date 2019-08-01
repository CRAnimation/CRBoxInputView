//
//  CRLineView.h
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/6/10.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRLineView : UIView

@property (strong, nonatomic) UIView    *lineView;

/**
 下划线颜色
 状态：未选中状态时
 默认：null
 */
@property (copy, nonatomic) UIColor *colorNormal;

/**
 下划线颜色
 状态：选中状态时
 默认：null
 */
@property (copy, nonatomic) UIColor *colorSelected;

- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
