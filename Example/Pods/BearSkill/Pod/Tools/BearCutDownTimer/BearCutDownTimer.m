//
//  BearCutDownTimer.m
//

#import "BearCutDownTimer.h"

@interface BearCutDownTimer ()
{
    NSTimer         *_timer;
    BOOL            timeStart;
    NSTimeInterval  _totalSecond;
}

@end

@implementation BearCutDownTimer

- (instancetype)initWithTotalSecond:(NSTimeInterval)totalSecond
{
    self = [super init];
    
    if (self) {
        _totalSecond = totalSecond;
    }
    
    return self;
}

- (void)startCutDown
{
    void (^StartTimer)() = ^(){
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        timeStart = YES;
    };
    
    if (!_timer) {
        if (StartTimer) {
            StartTimer();
        }
    }else{
        
        if (!_timer.valid) {
            if (StartTimer) {
                StartTimer();
            }
        }
    }
}

- (void)timerFireMethod:(NSTimer *)theTimer
{
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *endTime = [[NSDateComponents alloc] init];    //初始化目标时间...
    NSDate *today = [NSDate date];    //得到当前时间
    
    NSDate *date = [NSDate dateWithTimeInterval:_totalSecond sinceDate:today];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    static int year;
    static int month;
    static int day;
    static int hour;
    static int minute;
    static int second;
    if(timeStart) {//从NSDate中取出年月日，时分秒，但是只能取一次
        year = [[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
        month = [[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
        day = [[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
        hour = [[dateString substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[dateString substringWithRange:NSMakeRange(14, 2)] intValue];
        second = [[dateString substringWithRange:NSMakeRange(17, 2)] intValue];
        timeStart= NO;
    }
    
    [endTime setYear:year];
    [endTime setMonth:month];
    [endTime setDay:day];
    [endTime setHour:hour];
    [endTime setMinute:minute];
    [endTime setSecond:second];
    NSDate *todate = [cal dateFromComponents:endTime]; //把目标时间装载入date
    
    //用来得到具体的时差，是为了统一成北京时间
    unsigned int unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
//    NSString *fen = [NSString stringWithFormat:@"%02ld", (long)[d minute]];
//    NSString *miao = [NSString stringWithFormat:@"%02ld", (long)[d second]];
    
    if([d minute] > 0 || [d second] > 0) {
        
        //计时尚未结束，do_something
        if ([_delegate respondsToSelector:@selector(cutDownTimerUpdatePerSecondEventWithDateComponents:)]) {
            [_delegate cutDownTimerUpdatePerSecondEventWithDateComponents:d];
        }
        
    } else {
        
        //计时结束，do_something
        [theTimer invalidate];
        
        if ([_delegate respondsToSelector:@selector(cutDownTimerBurnUpEvent)]) {
            [_delegate cutDownTimerBurnUpEvent];
        }
        
    }
}

- (void)timerInvalidate
{
    if (_timer) {
        [_timer invalidate];
    }
}

- (void)dealloc
{
    [self timerInvalidate];
}

@end
