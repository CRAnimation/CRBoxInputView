//
//  BearCutDownBtn.m
//

#import "BearCutDownBtn.h"
#import "BearCutDownTimer.h"
#import <BearSkill/UIView+BearSet.h>

@interface BearCutDownBtn () <BearCutDownTimerDelegate>
{
    BearCutDownTimer *_cutDownTimer;
}

@end

@implementation BearCutDownBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _totalSecond = 60;
        _autoSizeToFit = NO;
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    self.btnStringNormal = @"获取验证码";
    self.btnStringRetry = @"重新获取";
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
}

- (void)setBtnStringNormal:(NSString *)btnStringNormal
{
    _btnStringNormal = btnStringNormal;
    
    [self setTitle:_btnStringNormal forState:UIControlStateNormal];
    if (_autoSizeToFit) {
        [self sizeToFit_DonotMoveCenter];
    }
    
    if ([_delegate respondsToSelector:@selector(cutDownBtnTitleHasChanged:)]) {
        [_delegate cutDownBtnTitleHasChanged:self];
    }
}

- (void)setBtnStringUnEnable:(NSString *)btnStringUnEnable
{
    _btnStringUnEnable = btnStringUnEnable;
    
    [self setTitle:_btnStringUnEnable forState:UIControlStateDisabled];
    if (_autoSizeToFit) {
        [self sizeToFit_DonotMoveCenter];
    }
    
    if ([_delegate respondsToSelector:@selector(cutDownBtnTitleHasChanged:)]) {
        [_delegate cutDownBtnTitleHasChanged:self];
    }
}

- (void)startCutDown
{
    if (!_cutDownTimer) {
        _cutDownTimer = [[BearCutDownTimer alloc] initWithTotalSecond:_totalSecond];
        _cutDownTimer.delegate = self;
    }
    
    self.enabled = NO;
    
    int totalSecondIntValue = (int)_totalSecond;
    self.btnStringUnEnable = [NSString stringWithFormat:@"%02d秒后重发", totalSecondIntValue];
    [_cutDownTimer startCutDown];
}


#pragma mark - BearCutDownTimerDelegate

- (void)cutDownTimerBurnUpEvent
{
    self.enabled = YES;
    self.btnStringNormal = _btnStringRetry;
}

- (void)cutDownTimerUpdatePerSecondEventWithDateComponents:(NSDateComponents *)dateComponents
{
    NSString *secondStr = [NSString stringWithFormat:@"%02ld", (long)[dateComponents second] + [dateComponents minute] * 60 + [dateComponents hour] * 3600];
    self.btnStringUnEnable = [NSString stringWithFormat:@"%@秒后重发", secondStr];
}

@end
