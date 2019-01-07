//
//  BearHUDManager.m
//  Pods
//
//  Created by Chobits on 2017/9/24.
//
//

#import "BearHUDManager.h"
#import <BearSkill/BearSkill.h>

@interface BearHUDManager () <MBProgressHUDDelegate>
{
    UIView *_inView;
}

@end

@implementation BearHUDManager

- (instancetype)initInView:(UIView *)inView
{
    self = [super init];
    
    if (self) {
        _inView = inView;
        [_inView addSubview:self.stateHud];
    }
    
    return self;
}

#pragma mark - HUD Func

- (void)addHudInView
{
    [self.stateHud removeFromSuperview];
    [_inView addSubview:self.stateHud];
    [_inView bringSubviewToFront:self.stateHud];
}

- (void)hudClean
{
    self.stateHud.detailsLabel.text = @"";
    self.stateHud.label.text = @"";
}

- (void)customHUDLoadingAnimation
{
    if (self.customView) {
        self.stateHud.mode = MBProgressHUDModeCustomView;
        self.stateHud.customView = self.customView;
    }else{
        self.stateHud.mode = MBProgressHUDModeIndeterminate;
    }
    
    [self.stateHud showAnimated:YES];
}

#pragma mark - MBProgressHUD
- (void)textStateHUD:(NSString *)text
{
    [self addHudInView];
    [self hudClean];
    
    for (UIImageView *imageView in self.stateHud.subviews)
    {
        if ([imageView isKindOfClass:[UIImageView class]])
            imageView.hidden = YES;
    }
    
    if ([BearConstants judgeStringExist:text]) {
        self.stateHud.detailsLabel.text = text;
    }
    
    [BearConstants processInMainThreadWithBlock:^{
        if (text && text.length > 0) {
            self.stateHud.mode = MBProgressHUDModeText;
            [self.stateHud showAnimated:YES];
            [self.stateHud hideAnimated:NO afterDelay:1.7f];
        } else {
            [self hideHUDView];
        }
    }];
}

- (void)textStateHUD:(NSString *)text finishBlock:(void (^)())finishBlock
{
    [self textStateHUD:text];
    
    [BearConstants delayAfter:1.7 dealBlock:^{
        if (finishBlock) {
            finishBlock();
        }
    }];
}

- (void)showHud:(NSString *)text
{
    [self addHudInView];
    [self hudClean];
    if ([BearConstants judgeStringExist:text]) {
        self.stateHud.label.text = text;
    }
    
    [self customHUDLoadingAnimation];
}

- (void)hideHUDView
{
    [self.stateHud hideAnimated:NO afterDelay:0];
}

#pragma mark - MBProgressHUD Delegate

- (void)hudWasHidden:(MBProgressHUD *)ahud
{
    [self.stateHud removeFromSuperview];
}

#pragma mark - Setter & Getter
@synthesize stateHud = _stateHud;
- (MBProgressHUD *)stateHud
{
    if (!_stateHud) {
        _stateHud = [[MBProgressHUD alloc] initWithView:_inView];
        _stateHud.label.font = [UIFont systemFontOfSize:13.0f];
        _stateHud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _stateHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _stateHud.contentColor = [UIColor whiteColor];
        _stateHud.label.text = @"";
        _stateHud.detailsLabel.text = @"";
        _stateHud.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
        _stateHud.detailsLabel.textColor = [UIColor whiteColor];
        _stateHud.delegate = self;
    }
    
    return _stateHud;
}

- (void)setStateHud:(MBProgressHUD *)stateHud
{
    _stateHud = stateHud;
}

@end
