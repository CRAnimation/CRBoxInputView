//
//  BearNavigationBar.m
//

#import "BearNavigationBar.h"
#import "UIView+BearSet.h"
#import "BearDefines.h"
#import "UIImage-Helpers.h"

@interface BearNavigationBar ()

@property (strong, nonatomic) UIView  *sepLineView;

@end

@implementation BearNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    _titleColor = [UIColor whiteColor];
    _titleFont = [UIFont boldSystemFontOfSize:18];
    
    [self reloadNaviAttribute];
    
    self.shadowImage = [[UIImage alloc] init];
}


- (void)setNavTextColor:(UIColor *)navTextColor
{
    // 导航栏 字体、颜色
    //原借款专家色值 #define navTextColor UIColorFromHEX(0x000000)
    if (navTextColor) {
        _titleColor = navTextColor;
    }
    
    [self reloadNaviAttribute];
}

- (void)reloadNaviAttribute
{
    // 导航栏 字体、颜色
    NSDictionary *attrs = @{ NSForegroundColorAttributeName:_titleColor,
                             NSFontAttributeName:_titleFont,
                             NSShadowAttributeName:[[NSShadow alloc] init]};
    [self setTitleTextAttributes:attrs];
}

//  解决NavigationBar按钮点击，相应范围过大的问题
//  参考：http://blog.csdn.net/shaobo8910/article/details/45057051
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self pointInside:point withEvent:event]) {
        self.userInteractionEnabled = YES;
    }else{
        self.userInteractionEnabled = NO;
    }
    
    return [super hitTest:point withEvent:event];
}

#pragma mark - Setter & Getter
- (void)setNavBarColor:(UIColor *)navBarColor
{
    _navBarColor = navBarColor;
    
    if (_navBarColor)
    {
        [self setBackgroundImage:[UIImage imageWithColor:_navBarColor] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [[UIImage alloc] init];
    }
}

- (void)setIsNavBarClear:(BOOL)isNavBarClear
{
    _isNavBarClear = isNavBarClear;
    
    if (_isNavBarClear) {
        [self setTranslucent:YES]; //则状态栏及导航栏底部为透明的
    } else {
        [self setTranslucent:NO];
    }
}

#pragma mark - Rewrite

@synthesize sepLineColor = _sepLineColor;

- (void)setSepLineColor:(UIColor *)sepLineColor
{
    _sepLineColor = sepLineColor;
    
    
    self.sepLineView.backgroundColor = _sepLineColor;
}


@synthesize sepLineView = _sepLineView;

- (UIView *)sepLineView
{
    if (!_sepLineView) {
        _sepLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
        [self addSubview:_sepLineView];
        [_sepLineView BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:nil parentRelation:YES distance:0 center:YES];
    }
    
    return _sepLineView;
}

@end
