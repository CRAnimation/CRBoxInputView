//
//  BearLoopManager.h
//  FenQiGuanJia
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 YunTu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BearLoopManager;

@protocol BearLoopManagerDelegate <NSObject>

@optional
//循环计数从0开始计算
- (void)loopEventInManager:(BearLoopManager *)manager withCurrentLoopIndex:(int)currentLoopIndex;
- (void)loopFinishedInManager:(BearLoopManager *)manager;

@end

@interface BearLoopManager : NSObject

@property (assign, nonatomic) int loopTotal;        // 循环总次数
@property (assign, nonatomic) CGFloat loopGapSec;   //  请求间隔(s)
@property (weak, nonatomic) id <BearLoopManagerDelegate> delegate;

- (void)createLoopQueue;    //创建轮询列队
- (void)resumeLoop;         //开始轮询
- (void)pauseLoop;           //暂停轮询
- (void)cancelLoop;         //取消并销毁轮询
- (BOOL)isLoop;             //是否处于轮询状态

@end
