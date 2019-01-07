//
//  BearCutDownTimer.h
//

#import <Foundation/Foundation.h>

@protocol BearCutDownTimerDelegate <NSObject>

@optional
- (void)cutDownTimerBurnUpEvent;
- (void)cutDownTimerUpdatePerSecondEventWithDateComponents:(NSDateComponents *)dateComponents;

@end

@interface BearCutDownTimer : NSObject

@property (weak, nonatomic) id <BearCutDownTimerDelegate> delegate;

- (instancetype)init    UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new     UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithTotalSecond:(NSTimeInterval)totalSecond;

//  开始倒计时
- (void)startCutDown;

//  停止倒计时
- (void)timerInvalidate;

@end
