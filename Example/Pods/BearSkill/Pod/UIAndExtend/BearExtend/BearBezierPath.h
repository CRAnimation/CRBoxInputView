//
//  BearBezierPath.h
//  AirPlaneAnimation
//
//  Created by apple on 16/10/30.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BearBezierPath : UIBezierPath

@property (assign, nonatomic) CGFloat scaleRatio;   // 所有点坐标的缩放比例
@property (assign, nonatomic) CGPoint offSetPoint;  // 所有点坐标的偏移

@end
