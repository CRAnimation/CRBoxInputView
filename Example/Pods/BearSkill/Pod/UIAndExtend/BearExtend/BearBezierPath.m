//
//  BearBezierPath.m
//  AirPlaneAnimation
//
//  Created by apple on 16/10/30.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "BearBezierPath.h"

@implementation BearBezierPath

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _scaleRatio = 1.0;
        _offSetPoint = CGPointMake(0, 0);
    }
    
    return self;
}

- (void)moveToPoint:(CGPoint)point
{
    [super moveToPoint:[self bearConvertPoint:point]];
}

- (void)addLineToPoint:(CGPoint)point
{
    [super addLineToPoint:[self bearConvertPoint:point]];
}

- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2
{
    [super addCurveToPoint:[self bearConvertPoint:endPoint]
             controlPoint1:[self bearConvertPoint:controlPoint1]
             controlPoint2:[self bearConvertPoint:controlPoint2]];
}

- (CGPoint)bearConvertPoint:(CGPoint)point
{
    CGPoint convertPoint = CGPointMake(point.x * _scaleRatio + _offSetPoint.x,
                                       point.y * _scaleRatio + _offSetPoint.y);
    
    return convertPoint;
}

@end
