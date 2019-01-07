//
//  CAShapeLayer+BearSet.m
//  BiZhi
//
//  Created by Chobits on 2017/11/17.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "CAShapeLayer+BearSet.h"

@implementation CAShapeLayer (BearSet)

//暂停动画
- (void)pauseAnimation
{
    if (self.speed == 0) {
        return;
    }
    
    //（0-5）
    //开始时间：0
    //    myView.layer.beginTime
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    self.timeOffset = pauseTime;
    
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    self.speed = 0;
    
}

//恢复动画
- (void)resumeAnimation
{
    if (self.speed != 0) {
        return;
    }
    
    //1.将动画的时间偏移量作为暂停的时间点
    CFTimeInterval pauseTime = self.timeOffset;
    
    //2.计算出开始时间
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    
    [self setTimeOffset:0];
    [self setBeginTime:begin];
    
    self.speed = 1;
}

@end
