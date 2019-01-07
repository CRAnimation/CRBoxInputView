//
//  BearCustomNaviBarView.m
//  JKZJ
//
//  Created by apple on 16/11/4.
//  Copyright © 2016年 Yuntu Technologies (Hangzhou) Co., Ltd. All rights reserved.
//

#import "BearCustomNaviBarView.h"
#import <BearSkill/BearSkill.h>

@interface BearCustomNaviBarView ()
{
    
}

@end

@implementation BearCustomNaviBarView

+ (BearCustomNaviBarView *)commonNaviBarView
{
    BearCustomNaviBarView *naviBarView = [[BearCustomNaviBarView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT, WIDTH, 44)];
    return naviBarView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
        [self relayUI];
    }
    
    return self;
}

- (void)createUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    // popBtn
    _popBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, XX_6PN(180), YY_6PN(90))];
    [_popBtn setImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_popBtn addTarget:self action:@selector(popEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_popBtn];
    
    // titleLabel
    _titleLabel = [UILabel new];
    _titleLabel.text = @"";
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
}

- (void)relayUI
{
    if (_popBtnColor) {
        _popBtn.tintColor = _popBtnColor;
    }
    
    if (_titleColor) {
        _titleLabel.textColor = _titleColor;
    }
    
    [_popBtn BearSetRelativeLayoutWithDirection:kDIR_LEFT destinationView:nil parentRelation:YES distance:0 center:YES];
    
    [_titleLabel sizeToFit];
    [_titleLabel BearSetCenterToView:_popBtn withAxis:kAXIS_X];
    [_titleLabel BearSetCenterToParentViewWithAxis:kAXIS_X];
}

- (void)setInVC:(BearBaseViewController *)inVC
{
    _inVC = inVC;
}

- (void)popEvent
{
    if (_inVC) {
        [_inVC popSelf];
    }
}

- (void)setTitleString:(NSString *)titleString
{
    if (!titleString) {
        return;
    }
    
    _titleLabel.text = titleString;
    [self relayUI];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self relayUI];
}

#pragma mark - Usage
- (void)Usage
{
    BearCustomNaviBarView *_customNaviBarView = [BearCustomNaviBarView commonNaviBarView];
    [_customNaviBarView setTitleString:@"猩球崛起"];
//    _customNaviBarView.inVC = weakSelf;
    _customNaviBarView.backgroundColor = [UIColor clearColor];
    _customNaviBarView.titleLabel.textColor = [UIColor whiteColor];
    [_customNaviBarView.popBtn setImage:[[UIImage imageNamed:@"tool_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_customNaviBarView.popBtn setTintColor:[UIColor whiteColor]];
}

@end
