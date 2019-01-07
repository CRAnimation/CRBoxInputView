//
//  BearBaseViewController.m
//

#import "BearBaseViewController.h"
#import "BearHUDCustomView.h"
#import "UIView+BearSet.h"
#import "BearConstants.h"
#import "BearDefines.h"
#import <Masonry/Masonry.h>

@interface BearBaseViewController () <UIGestureRecognizerDelegate>
{
    UIImageView   *   _bgImageView;
    NSArray       *   _hiddenLeftItems;
    NSArray       *   _hiddenRightItems;
}

@end

@implementation BearBaseViewController

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.hideNavigationBarWhenPush = NO;
        _ifPopToRootView = NO;
        _ifAddBackButton = YES;
        _ifDismissView = NO;
        _ifAddPopGR = YES;
        _ifTapResignFirstResponder = NO;
        _imgNameBack = @"BearSkill_NaviBack";
        self.statusBarStyle = UIStatusBarStyleLightContent;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        if (self.navigationController.viewControllers.count > 1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = _ifAddPopGR;
        } else {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
    [self addNaviView];
    [self addContentView];
    
    if (over_iOS11) {
        [self.view addSubview:self.customStatusView];
    }
    
    if (_ifTapResignFirstResponder) {
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignCurrentFirstResponder)];
        tapGR.delegate = self;
        [self.contentView addGestureRecognizer:tapGR];
    }
    
    [self refreshBaseViewsMasonry];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        if (self.navigationController.viewControllers.count > 1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = _ifAddPopGR;
        } else {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_viewWillDisappearBlock) {
        _viewWillDisappearBlock();
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_removeSelfAfterDidDisappear) {
        
        //  界面消失后，将self从self.navigationController.viewControllers中移除
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        if ([tempArray count] > 1) {
            
            for (int i = 0; i < [tempArray count]; i++) {
                id tempVC = tempArray[i];
                if (tempVC == self) {
                    [tempArray removeObjectAtIndex:i];
                    break;
                }
            }
            self.navigationController.viewControllers = tempArray;
        }
        
    }
    
    
    if (_viewDidDisappearBlock) {
        _viewDidDisappearBlock();
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissViewController) name:@"disMiss" object:nil];
}

#pragma mark - createUI

- (void)createUI
{}

- (void)addContentView
{
    [self.view addSubview:self.contentView];
}

- (void)addNaviView
{
    if (self.hideNavigationBarWhenPush) {
        if (self.navigationBar.superview) {
            [self.navigationBar removeFromSuperview];
        }
    }else{
        if (self.navigationBar.superview != self.view) {
            [self.view addSubview:self.navigationBar];
        }
    }
}

#pragma mark - 返回（back）

- (void)paningGestureReceive:(id)sender
{
    [self popSelf];
}

- (void)popSelf
{
    //  _popToDestinationVC
    if (_popToDestinationVC) {
        [BearConstants popToDestinationVC:_popToDestinationVC inVC:self];
        return;
    }
    
    //  _popToDestiantionClassName
    else if (_popToDestiantionClassName && [BearConstants judgeStringExist:_popToDestiantionClassName]) {
        [BearConstants popToDestinationVCClassName:_popToDestiantionClassName inVC:self];
        return;
    }
    
    //  push
    else if (_ifPopToRootView) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    //  present
    else if (_ifDismissView) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    
    //  pop
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)dismissViewController
{
    [self.navigationController dismissViewControllerAnimated:NO completion:^{}];
}

- (void)dismissModalViewController
{
    [BearConstants resignCurrentFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - 状态栏

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark - 键盘收回

- (void)resignCurrentFirstResponder
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow endEditing:YES];
}

#pragma mark - navigationBar 设置

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    UINavigationItem * navItem = [[self.navigationBar items] lastObject];
    if (navItem.leftBarButtonItem == nil && [self.navigationController.viewControllers count] > 1 && self.ifAddBackButton) {
        [self addLeftBarButtonItem:[self createBackBarButonItem] animation:NO];
    }
}

- (UIBarButtonItem *)createBackBarButonItem
{
    UIButton *backBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 74/3.0, 74/3.0)];
    
    if (_naviBackBtnTintColor) {
        [backBarButton setImage:[[UIImage imageNamed:_imgNameBack] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [backBarButton setTintColor:_naviBackBtnTintColor];
    }else{
        [backBarButton setImage:[UIImage imageNamed:_imgNameBack] forState:UIControlStateNormal];
    }
    
    backBarButton.imageView.contentMode = UIViewContentModeCenter;
    [backBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 0)];
    backBarButton.adjustsImageWhenHighlighted = NO;
    [backBarButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBarButton];
    backBarButtonItem.style = UIBarButtonItemStylePlain;
    
    return backBarButtonItem;
}

#pragma mark 设置标题

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UINavigationItem * navItem = (UINavigationItem *)[[self.navigationBar items] lastObject];
    
    [navItem setTitle:title];
}

#pragma mark - Navi Item

- (void)addTitleView:(UIView *)titleview
{
    UINavigationItem *navItem = (UINavigationItem *)[[self.navigationBar items] lastObject];
    [navItem setTitleView:titleview];
}

- (void)addLeftBarButtonItem:(UIBarButtonItem *)item animation:(BOOL)animation
{
    UINavigationItem * navItem = (UINavigationItem *)[[self.navigationBar items] lastObject];
    NSArray * items = [navItem leftBarButtonItems];
    
    if (item && items && [items count]) {
        items = [items arrayByAddingObject:item];
        [navItem setLeftBarButtonItems:items animated:animation];
    } else {
        self.navigationItem.backBarButtonItem = item;
        [navItem setLeftBarButtonItem:item animated:animation];
    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)item animation:(BOOL)animation
{
    UINavigationItem * navItem = (UINavigationItem *)[[self.navigationBar items] lastObject];
    NSArray * items = [navItem rightBarButtonItems];
    
    if (item && items && [items count]) {
        items = [items arrayByAddingObject:item];
        [navItem setRightBarButtonItems:items animated:animation];
    } else {
        [navItem setRightBarButtonItem:item animated:animation];
    }
}

- (void)hideLeftBarButtonItemsAnimation:(BOOL)animation
{
    UINavigationItem * navItem = (UINavigationItem *)[[self.navigationBar items] lastObject];
    if ([navItem leftBarButtonItems]) {
        _hiddenLeftItems = [navItem leftBarButtonItems];
    }
    [self addLeftBarButtonItem:nil animation:animation];
}

- (void)showLeftBarButtonItemsAnimation:(BOOL)animation
{
    UINavigationItem * navItem = (UINavigationItem *)[[self.navigationBar items] lastObject];
    if (_hiddenLeftItems && _hiddenLeftItems.count > 0) {
        [navItem setLeftBarButtonItems:_hiddenLeftItems animated:animation];
    }
}

- (void)hideRightBarButtonItemsAnimation:(BOOL)animation
{
    UINavigationItem * navItem = (UINavigationItem *)[[self.navigationBar items] lastObject];
    if ([navItem rightBarButtonItems]) {
        _hiddenRightItems = [navItem rightBarButtonItems];
    }
    [self addRightBarButtonItem:nil animation:animation];
}

- (void)showRightBarButtonItemsAnimation:(BOOL)animation
{
    UINavigationItem * navItem = (UINavigationItem *)[[self.navigationBar items] lastObject];
    if (_hiddenRightItems && _hiddenRightItems.count > 0) {
        [navItem setRightBarButtonItems:_hiddenRightItems animated:animation];
    }
}

#pragma mark - HUD
- (void)textStateHUD:(NSString *)text
{
    [self.hudManager textStateHUD:text];
}

- (void)textStateHUD:(NSString *)text finishBlock:(void (^)(void))finishBlock
{
    [self.hudManager textStateHUD:text finishBlock:^{
        if (finishBlock) {
            finishBlock();
        }
    }];
}

- (void)showHud:(NSString *)text
{
    [self.hudManager showHud:text];
}

- (void)hideHUDView
{
    [self.hudManager hideHUDView];
}

#pragma mark - Func

//  当前是否为Navi的顶层
- (BOOL)IsSelfTopMostOfNav
{
    return [self.navigationController.topViewController isEqual:self];
}

#pragma mark - Rotate Orientation
// 该方法不知什么原因，每次旋转屏幕都会调用四次
// 暂时不使用该方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self refreshContentViewMasonry];
    
    [self shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
}

-(void)shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    // 竖屏
    if (orientation == UIDeviceOrientationPortrait
        ||orientation == UIDeviceOrientationPortraitUpsideDown)
    {
        if ([BearConstants getIsXSeries]) {
            self.customStatusView.hidden = NO;
        }
    } else { // 横屏
        if ([BearConstants getIsXSeries]) {
            self.customStatusView.hidden = YES;
        }
    }
}

#pragma mark - System Update Constraints

- (void)refreshContentViewFrame __attribute__((deprecated("该方法已被弃用")))
{
    
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
}

// 改方法第一次创建时会多次调用
// 暂时不使用该方法
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [self refreshBaseViewsMasonry];
}

#pragma mark - Refresh Masonry
//  刷新ContentView的Frame
- (void)refreshBaseViewsMasonry
{
    [self refreshNavigationBarMasonry];
    [self refreshContentViewMasonry];
}

- (void)refreshContentViewMasonry
{
//    CGFloat bottomHeight = self.hidesBottomBarWhenPushed ? 0 : TABBAR_HEIGHT;
//    if (@available(iOS 11.0, *)) {
//        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].delegate.window.safeAreaInsets;
//        bottomHeight += safeAreaInsets.bottom;
//    }
    
    [self.view addSubview:self.contentView];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.hideNavigationBarWhenPush) {
            make.top.offset(STATUS_HEIGHT);
        }else{
            make.top.equalTo(self.navigationBar.mas_bottom);
        }
        
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
}

- (void)refreshNavigationBarMasonry
{
    //    _navigationBar
    if (!self.hideNavigationBarWhenPush) {
        if (over_iOS10) {
            [self.navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.right.offset(0);
                make.top.offset(STATUS_HEIGHT);
                make.height.mas_equalTo(NAVIGATIONBAR_HEIGHT);
            }];
            
        }else{
            [self.navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.right.offset(0);
                make.top.offset(0);
                make.height.mas_equalTo(NAV_STA);
            }];
        }
    }
}

#pragma mark - Setter & Getter
- (BearHUDManager *)hudManager
{
    if (!_hudManager) {
        _hudManager = [[BearHUDManager alloc] initInView:self.contentView];
    }
    
    return _hudManager;
}

- (UIView *)customStatusView
{
    if (!_customStatusView) {
        _customStatusView = [[UIView alloc] init];
    }
    
    return _customStatusView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return _contentView;
}

- (void)setHideNavigationBarWhenPush:(BOOL)hideNavigationBarWhenPush
{
    _hideNavigationBarWhenPush = hideNavigationBarWhenPush;
    
    // customStatusView 
    if (over_iOS11) {
        if (_hideNavigationBarWhenPush) {
            if (self.customStatusView) {
                [self.customStatusView removeFromSuperview];
            }
        }else{
            if (self.customStatusView.superview != self.view) {
                [self.view addSubview:self.customStatusView];
                [self.customStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.offset(0);
                    make.left.offset(0);
                    make.right.offset(0);
                    make.height.mas_equalTo(STATUS_HEIGHT);
                }];
            }
        }
    }
}

- (BearNavigationBar *)navigationBar
{
    if (!_navigationBar)
    {
        _navigationBar = [[BearNavigationBar alloc] init];
        _navigationBar.delegate = self;
        
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@""];
        [_navigationBar setItems:@[item]];
    }
    return _navigationBar;
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"disMiss" object:nil];
}

@end
