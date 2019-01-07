//
//  BearNavigationBar.h
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+BearSet.h"

@interface BearNavigationBar : UINavigationBar

@property (nonatomic, strong) UIColor   *navBarColor;
@property (nonatomic, strong) UIColor   *titleColor;
@property (nonatomic, strong) UIFont    *titleFont;
@property (nonatomic, strong) UIColor   *sepLineColor;

//设置状态栏是否为透明
@property (nonatomic, assign) BOOL      isNavBarClear;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)init;

- (void)reloadNaviAttribute;

@end
