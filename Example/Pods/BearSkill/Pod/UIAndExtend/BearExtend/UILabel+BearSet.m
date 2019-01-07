//
//  UILabel+BearSet.m
//  Bear
//
//  Created by Bear on 30/12/24.
//  Copyright © 2015年 Bear. All rights reserved.
//

#import "UILabel+BearSet.h"
#import "UIView+BearSet.h"

@implementation UILabel (BearSet)

//  获取label文字的宽度
+ (CGFloat )getTitleTextWidth:(NSString *)title font:(UIFont *)font
{
    CGFloat titleWidth;
    
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.text = title;
    tempLabel.font = font;
    [tempLabel sizeToFit];
    titleWidth = CGRectGetWidth(tempLabel.frame);
    
    return titleWidth;
}

//   根据宽度自适应
- (void)setLabelSizeToFitWidth:(int)width
{
    [self setWidth:0];
    [self setHeight:0];
    self.numberOfLines = 0;
    [self sizeToFit];
    CGFloat textHeight = CGRectGetHeight(self.frame);
    int label_Width = [UILabel getTitleTextWidth:self.text font:self.font];
    int rows = ((label_Width % width) == 0 ? label_Width/width: label_Width/width+1);
    [self setWidth:width];
    [self setHeight:rows * textHeight];
}

//  中心不变，自适应
- (void)sizeToFit_DonotMoveCenter
{
    CGPoint tempCenter = self.center;
    [self sizeToFit];
    self.center = tempCenter;
}

@end
