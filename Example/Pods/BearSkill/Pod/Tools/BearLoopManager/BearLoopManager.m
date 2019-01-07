//
//  BearLoopManager.m
//  FenQiGuanJia
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 YunTu. All rights reserved.
//

#import "BearLoopManager.h"

@interface BearLoopManager ()
{
    dispatch_queue_t        _queue;
    dispatch_source_t       _timer;
    int                     _queueRefCount;
}

@end

@implementation BearLoopManager

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _loopTotal = INT_MAX;
        _loopGapSec = 10;
    }
    
    return self;
}

- (void)createLoopQueue
{
    if (_timer) {
        [self cancelLoop];
    }
    
    __weak typeof(self) weakSelf = self;
    _queueRefCount = 1;
    __block int currentLoopCount = 1;//循环计数从1开始计算
    _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
    
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, _loopGapSec * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //  最后一个
        if (currentLoopCount > _loopTotal) {
            if ([_delegate respondsToSelector:@selector(loopFinishedInManager:)]) {
                [_delegate loopFinishedInManager:weakSelf];
            }
        }
        //  Loop
        else if (currentLoopCount <= _loopTotal){
            if ([_delegate respondsToSelector:@selector(loopEventInManager:withCurrentLoopIndex:)]) {
                [_delegate loopEventInManager:weakSelf withCurrentLoopIndex:currentLoopCount - 1];
            }
            currentLoopCount++;
        }
    });
}

#pragma mark - Loop Control

- (void)resumeLoop
{
    if (_timer && _queueRefCount > 0) {
        dispatch_resume(_timer);    //恢复
        _queueRefCount--;
    }
}

- (void)pauseLoop
{
    if (_timer && _queueRefCount == 0) {
        dispatch_suspend(_timer);  //挂起
        _queueRefCount = 1;
    }
}

- (void)cancelLoop
{
    if (_timer) {
        dispatch_source_cancel(_timer);  //停止
    }
}

- (BOOL)isLoop
{
    if (_queueRefCount == 0) {
        return YES;
    }
    
    return NO;
}

- (void)dealloc
{
    [self cancelLoop];
}

#pragma mark - Demo Use
- (void)demoUse
{
    BearLoopManager *manager = [BearLoopManager new];
    manager.loopTotal = 10;
    manager.loopGapSec = 3.5;
    [manager createLoopQueue];
    
}

@end
