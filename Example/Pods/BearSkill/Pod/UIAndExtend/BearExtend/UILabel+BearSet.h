//
//  UILabel+BearSet.h
//  Bear
//
//  Created by Bear on 30/12/24.
//  Copyright © 2015年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BearSet)

//  获取label的宽度
+ (CGFloat )getTitleTextWidth:(NSString *)title font:(UIFont *)font;

//  根据宽度自适应
- (void)setLabelSizeToFitWidth:(int)width;

//  中心不变，自适应
- (void)sizeToFit_DonotMoveCenter;

@end
