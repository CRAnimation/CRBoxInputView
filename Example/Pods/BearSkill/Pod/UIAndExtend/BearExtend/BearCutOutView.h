//
//  BearCutOutView.h
//  TestCutOut
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 qiantu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BearCutOutView : UIView

- (void)setUnCutColor:(UIColor *)unCutColor cutOutFrame:(CGRect)cutOutFrame;
- (void)setUnCutColor:(UIColor *)unCutColor cutOutPath:(UIBezierPath *)cutOutPath;

@end
