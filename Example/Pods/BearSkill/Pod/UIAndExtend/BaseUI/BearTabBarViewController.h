//
//  BearTabBarViewController.h
//

#import <UIKit/UIKit.h>

@interface BearTabBarViewController : UITabBarController

- (instancetype)initWithViewControllers:(NSMutableArray *)viewControllers
                                 titles:(NSArray *)titles
                          imageNameStrs:(NSArray *)imageNameStrs
                  imageNameSelectedStrs:(NSArray *)imageNameSelectedStrs
                              tintColor:(UIColor *)tintColor
                        backgroundColor:(UIColor *)backgroundColor;

- (instancetype)initWithViewControllers:(NSMutableArray *)viewControllers
                                 titles:(NSArray *)titles
                          imageNameStrs:(NSArray *)imageNameStrs
                  imageNameSelectedStrs:(NSArray *)imageNameSelectedStrs
                              tintColor:(UIColor *)tintColor
                        backgroundColor:(UIColor *)backgroundColor
                     tabBarItemUIOffSet:(UIOffset)tabBarItemUIOffSet;

- (instancetype)initWithViewControllers:(NSMutableArray *)viewControllers
                                 titles:(NSArray *)titles
                          imageNameStrs:(NSArray *)imageNameStrs
                  imageNameSelectedStrs:(NSArray *)imageNameSelectedStrs
                         imageTintColor:(UIColor *)imageTintColor
                         titleTintColor:(UIColor *)titleTintColor
                        backgroundColor:(UIColor *)backgroundColor
                     tabBarItemUIOffSet:(UIOffset)tabBarItemUIOffSet;

- (void)setAllImageInsets:(UIEdgeInsets)edgeInsets;

@end
