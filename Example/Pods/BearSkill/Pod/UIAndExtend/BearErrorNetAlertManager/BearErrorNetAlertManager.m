//
//  BearErrorNetAlertManager.m
//  SuperVideo
//
//  Created by Chobits on 2017/11/13.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "BearErrorNetAlertManager.h"
#import "BearSkill.h"

@interface BearErrorNetAlertManager ()
{
    UIView *_contentView;
}

@end

@implementation BearErrorNetAlertManager

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self createUI];
        [self relayUI];
    }
    
    return self;
}

- (void)createUI
{
    _alertManager = [BearAlertManager new];
    __weak typeof(_alertManager) weakAlertManager = _alertManager;
    weakAlertManager.contentTapBlock = ^{
        [weakAlertManager fadeOut];
        [self retryBtnEvent];
    };
    
    _contentView = [[UIView alloc] init];
    _contentView.userInteractionEnabled = YES;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 8;
    _contentView.layer.masksToBounds = YES;
    
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"BearImg_空白页"];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_contentView addSubview:_imageView];
    
    _noticeLabel = [UILabel new];
    _noticeLabel.numberOfLines = 0;
    _noticeLabel.textAlignment = NSTextAlignmentCenter;
    _noticeLabel.font = [UIFont systemFontOfSize:15];
    _noticeLabel.text = @"请检查您的网络～";
    _noticeLabel.textColor = [UIColor blackColor];
    [_contentView addSubview:_noticeLabel];
    
    _retryBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    _retryBtn.userInteractionEnabled = NO;
//    [_retryBtn addTarget:self action:@selector(retryBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    _retryBtn.layer.borderWidth = 1.0;
    _retryBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _retryBtn.layer.cornerRadius = 5.0;
    [_retryBtn setTitle:@"点击重试" forState:UIControlStateNormal];
    _retryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_retryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_contentView addSubview:_retryBtn];
}

- (void)relayUI
{
    CGFloat offX = XX_6(30);
    CGFloat offY = YY_6(20);
    CGFloat gapY = YY_6(15);
    
    [_noticeLabel setWidth:WIDTH * 0.6];
    [_noticeLabel sizeToFit];
    if (_noticeLabel.width < WIDTH * 0.4) {
        [_noticeLabel setWidth:WIDTH * 0.4];
    }
    [_contentView setWidth:_noticeLabel.width + 2 * offX];
    
    CGRect imageViewFrame = [UIView caculateBoundsRemainWHRatio_referWidth:@196 referHeight:@128 setSort:kSetNeed_Width setValue:@XX_6(196/2.0)];
    _imageView.frame = imageViewFrame;
    [_imageView BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:nil parentRelation:YES distance:offY center:YES];
    
    [_noticeLabel sizeToFit];
    [_noticeLabel BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_imageView parentRelation:NO distance:gapY center:YES];
    
    [_retryBtn BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_noticeLabel parentRelation:NO distance:gapY center:YES];
    
    [_contentView setHeight:_retryBtn.maxY + offY];
}

#pragma mark - Event
- (void)retryBtnEvent
{
    if (_retryClickBlock) {
        _retryClickBlock();
    }
}

#pragma mark - Show
- (void)showWithErrorStr:(NSString *)errorStr
{
    [self setErrorStr:errorStr];
    [self show];
}

- (void)show
{
    [_alertManager createAlertBgViewWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    [_alertManager setContentView:_contentView];
    [_alertManager showInViewAndFadeIn:[UIApplication sharedApplication].keyWindow];
}

- (void)setErrorStr:(NSString *)errorStr
{
    _noticeLabel.text = errorStr;
    [self relayUI];
}

- (void)showInView:(UIView *)inView
{
    [_alertManager createAlertBgViewWithFrame:inView.bounds];
    [_alertManager setContentView:_contentView];
    [_alertManager showInViewAndFadeIn:inView];
}

#pragma mark - Usage
- (void)Usage
{
    [[BearErrorNetAlertManager new] show];
    [[BearErrorNetAlertManager new] showWithErrorStr:@"Error"];
}

@end
