//
//  BearBaseViewController.h
//

#import <UIKit/UIKit.h>
#import <BearSkill/BearNavigationBar.h>
#import "BearHUDManager.h"

typedef void(^ViewDidDisappearBlock)(void);
typedef void(^ViewWillDisappearBlock)(void);

@interface BearBaseViewController : UIViewController <UINavigationBarDelegate>
{
    UIButton        *_reloadMask;
}

@property (strong, nonatomic) UIView                *   customStatusView;           //iOS11以上，并且竖屏状态下使用
@property (nonatomic, strong) BearNavigationBar     *   navigationBar;
@property (nonatomic, strong) UIView                *   contentView;
@property (strong, nonatomic) BearHUDManager        *   hudManager;
@property (nonatomic, strong) UIViewController      *   popToDestinationVC;         //跳转回指定VC
@property (nonatomic, strong) NSString              *   popToDestiantionClassName;  //跳转回指定class
@property (strong, nonatomic) BearBaseViewController  *   aheadVC;                    //从哪里跳来的VC，适用于Push和Present，便于找到上一个VC

@property (nonatomic, strong) NSString              *   imgNameBack;                //返回按钮图片名称
@property (nonatomic, strong) UIColor               *   naviBackBtnTintColor;       //导航器返回按钮tintColor
@property (assign, nonatomic) UIStatusBarStyle          statusBarStyle;             //状态栏颜色

@property (nonatomic, assign) BOOL                      hideNavigationBarWhenPush;
@property (nonatomic, assign) BOOL                      ifPopToRootView;
@property (nonatomic, assign) BOOL                      ifAddBackButton;
@property (nonatomic, assign) BOOL                      ifDismissView;
@property (nonatomic, assign) BOOL                      ifAddPopGR;                           //  是否添加原生手势返回标记
@property (nonatomic, assign) BOOL                      ifTapResignFirstResponder;
@property (nonatomic, assign) BOOL                      removeSelfAfterDidDisappear;          //  自己消失后从navi移除

@property (copy, nonatomic) ViewDidDisappearBlock     viewDidDisappearBlock;
@property (copy, nonatomic) ViewWillDisappearBlock    viewWillDisappearBlock;

- (void)resignCurrentFirstResponder;
- (void)createUI;
- (void)popSelf;
- (void)dismissModalViewController;

#pragma mark - Navi Item
- (void)addTitleView:(UIView *)titleview;
- (UIBarButtonItem *)createBackBarButonItem;
- (void)addLeftBarButtonItem:(UIBarButtonItem *)item animation:(BOOL)animation;
- (void)addRightBarButtonItem:(UIBarButtonItem *)item animation:(BOOL)animation;
- (void)hideLeftBarButtonItemsAnimation:(BOOL)animation;
- (void)showLeftBarButtonItemsAnimation:(BOOL)animation;
- (void)hideRightBarButtonItemsAnimation:(BOOL)animation;
- (void)showRightBarButtonItemsAnimation:(BOOL)animation;

#pragma mark - HUD
- (void)textStateHUD:(NSString *)text;
- (void)textStateHUD:(NSString *)text finishBlock:(void (^)(void))finishBlock;
- (void)showHud:(NSString *)text;
- (void)hideHUDView;

#pragma mark - Func
//  当前是否为Navi的顶层
- (BOOL)IsSelfTopMostOfNav;
//  刷新ContentView的Frame
- (void)refreshContentViewFrame __attribute__((deprecated("该方法已被弃用")));

@end
