//
//  BearAlertManager.m
//

#import "BearAlertManager.h"
#import "UIView+BearSet.h"

static NSString *kAnimationKey_FadeInAlertViewScale = @"AnimationKey_FadeInAlertViewScale";
static NSString *kAnimationKey_FadeOutAlertViewScale = @"AnimationKey_FadeOutAlertViewScale";

@interface BearAlertManager()<CAAnimationDelegate>
{
    
}

@end

@implementation BearAlertManager
{
    UIView          *_bgView;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _scaleAniamtionDuration = 0.45;
        _needTapBgToFadeOut = YES;
    }
    
    return self;
}

- (void)createAlertBgViewWithFrame:(CGRect)frame
{
    _bgView = [[UIView alloc]initWithFrame:frame];
    _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
    [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapEvent)]];
    _bgView.userInteractionEnabled = YES;
}

#pragma mark - Event
- (void)contentViewTapEvent
{
    if (_contentTapBlock) {
        _contentTapBlock();
    }
}

- (void)bgTapEvent
{
    if (_bgTapBlock) {
        _bgTapBlock();
    }
    
    if (_needTapBgToFadeOut) {
        [self fadeOut];
    }
}

#pragma mark - Fade & Aniamtion
- (void)fadeOut
{
    [self fadeOutScaleAniamtionWithLayer:_contentView.layer];
}

- (void)fadeIn
{
    [self fadeInScaleAniamtionWithLayer:_contentView.layer];
}

- (void)showInViewAndFadeIn:(UIView *)inView
{
    [inView addSubview:_bgView];
    [self fadeIn];
}

- (void)fadeInScaleAniamtionWithLayer:(CALayer *)layer
{
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.delegate = self;
    keyFrameAnimation.keyPath = @"transform.scale";
    NSArray *array_my = @[@0.2, @1.1, @0.95, @1.0];
    keyFrameAnimation.values = array_my;
    keyFrameAnimation.duration = _scaleAniamtionDuration;
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    [layer addAnimation:keyFrameAnimation forKey:kAnimationKey_FadeInAlertViewScale];
}

- (void)fadeOutScaleAniamtionWithLayer:(CALayer *)layer
{
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.delegate = self;
    keyFrameAnimation.keyPath = @"transform.scale";
    NSArray *array_my = @[@1.0, @0.95, @1.1, @0.2];
    keyFrameAnimation.values = array_my;
    keyFrameAnimation.duration = _scaleAniamtionDuration;
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    [layer addAnimation:keyFrameAnimation forKey:kAnimationKey_FadeOutAlertViewScale];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([_contentView.layer animationForKey:kAnimationKey_FadeInAlertViewScale] == anim) {
        
    }else if ([_contentView.layer animationForKey:kAnimationKey_FadeOutAlertViewScale] == anim) {
        [self cleanBlock];
    }
}

#pragma mark - Dealloc & Clean
- (void)cleanBlock
{
    if (_bgView) {
        [_bgView removeFromSuperview];
        _bgView = nil;
    }
    
    _bgTapBlock = nil;
    _contentTapBlock = nil;
}

#pragma mark - Setter & Getter
- (void)setContentView:(UIView *)contentView
{
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    _contentView.userInteractionEnabled = YES;
    [_contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapEvent)]];
    [_bgView addSubview:_contentView];
    [_contentView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

#pragma mark - Usage
- (void)Usage
{
    UIImageView *alertImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    alertImageView.backgroundColor = [UIColor orangeColor];
    alertImageView.image = [UIImage imageNamed:@"Img_IndexAlert"];
    alertImageView.layer.cornerRadius = 4;
    
    BearAlertManager *alertManager = [BearAlertManager new];
    __weak typeof(alertManager) wealAlertManager = alertManager;
    alertManager.contentTapBlock = ^{
        [wealAlertManager fadeOut];
    };
    [alertManager createAlertBgViewWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    [alertManager setContentView:alertImageView];
    [alertManager showInViewAndFadeIn:[UIApplication sharedApplication].keyWindow];
}

@end
