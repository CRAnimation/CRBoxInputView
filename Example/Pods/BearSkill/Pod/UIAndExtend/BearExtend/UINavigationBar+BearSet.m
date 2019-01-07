//
//  UINavigationBar+BearSet.m
//  Pods
//
//  Created by Chobits on 2017/9/5.
//
//

#import "UINavigationBar+BearSet.h"
#import "UIImage-Helpers.h"

@implementation UINavigationBar (BearSet)

- (void)setNaviBackgroundColor:(UIColor *)backgroundColor
{
    if (backgroundColor) {
        [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    // 导航栏 颜色
    NSDictionary *attrs = @{ NSForegroundColorAttributeName:titleColor,
                             NSShadowAttributeName:[[NSShadow alloc] init]};
    [self setTitleTextAttributes:attrs];
}

- (void)setFont:(UIFont *)font
{
    // 导航栏 字体
    NSDictionary *attrs = @{ NSFontAttributeName:font,
                             NSShadowAttributeName:[[NSShadow alloc] init]};
    [self setTitleTextAttributes:attrs];
}

- (void)setLeftBarButtonItemTitleColor:(UIColor *)color
{
    UINavigationItem * navItem = (UINavigationItem *)[[self items] lastObject];
    NSArray <UIBarButtonItem *> * items = [navItem leftBarButtonItems];
    
    if (items && [items count] > 0) {
        
        [items enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIBarButtonItem *barButtonItem = obj;
            [barButtonItem setTintColor:color];
        }];
    }
}

@end
