//
//  BearFirstScreenAdView.m
//  BiZhi
//
//  Created by Chobits on 2017/9/24.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "BearFirstScreenAdView.h"
#import "BearCutDownTimer.h"
#import <BearSkill/BearSkill.h>

@interface BearFirstScreenAdView () <BearCutDownTimerDelegate>

@property (assign, nonatomic) int totalSecond;
@property (strong, nonatomic) UIButton *cutDownBtn;
@property (strong, nonatomic) BearCutDownTimer *cutDownTimer;
@property (strong, nonatomic) UITapGestureRecognizer *tapGR;

@end

@implementation BearFirstScreenAdView

- (instancetype)initWithFrame:(CGRect)frame totalSecond:(int)totalSecond
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _totalSecond = totalSecond;
        [self initPara];
        [self createUI];
        
        [self addGestureRecognizer:self.tapGR];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame totalSecond:4];
}

- (void)initPara
{
    _cutDownTimer = [[BearCutDownTimer alloc] initWithTotalSecond:_totalSecond];
    _cutDownTimer.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)startCutDown
{
    _cutDownBtn.hidden = NO;
    [_cutDownTimer startCutDown];
}

- (void)createUI
{
    _contentImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_contentImageView];
    
    _cutDownBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
    _cutDownBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _cutDownBtn.layer.cornerRadius = 5;
    _cutDownBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    NSString *titleStr = [NSString stringWithFormat:@"%d秒后关闭", _totalSecond];
    [_cutDownBtn setTitle:titleStr forState:UIControlStateNormal];
    [_cutDownBtn addTarget:self action:@selector(cutDownBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cutDownBtn];
    _cutDownBtn.hidden = YES;
    
    [_cutDownBtn setMaxX:self.width - 10];
    [_cutDownBtn setY:25];
}

#pragma mark - Event
- (void)cutDownBtnEvent
{
    if ([_delegate respondsToSelector:@selector(firstScreenViewDidClickCloseBtn)]) {
        [_delegate firstScreenViewDidClickCloseBtn];
    }
}

- (void)tapBgEvent
{
    if ([_delegate respondsToSelector:@selector(firstScreenViewDidTapBg)]) {
        [_delegate firstScreenViewDidTapBg];
    }
}

#pragma mark - BearCutDownTimerDelegate
- (void)cutDownTimerUpdatePerSecondEventWithDateComponents:(NSDateComponents *)dateComponents
{
    NSString *titleStr = [NSString stringWithFormat:@"%ld秒后关闭", (long)[dateComponents second]];
    [_cutDownBtn setTitle:titleStr forState:UIControlStateNormal];
}

- (void)cutDownTimerBurnUpEvent
{
    if ([_delegate respondsToSelector:@selector(firstScreenAdViewDidBurnUp)]) {
        [_delegate firstScreenAdViewDidBurnUp];
    }
}

#pragma mark - Setter & Getter
- (UITapGestureRecognizer *)tapGR
{
    if (!_tapGR) {
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgEvent)];
        _tapGR.numberOfTapsRequired = 1;
    }
    
    return _tapGR;
}

@end
