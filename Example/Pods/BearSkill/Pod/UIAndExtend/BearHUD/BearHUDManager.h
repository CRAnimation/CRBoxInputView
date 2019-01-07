//
//  BearHUDManager.h
//  Pods
//
//  Created by Chobits on 2017/9/24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface BearHUDManager : NSObject 

@property (nonatomic, strong) MBProgressHUD *stateHud;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@property (strong, nonatomic) UIView *customView;

- (instancetype)initInView:(UIView *)inView;

#pragma mark - MBProgressHUD
- (void)textStateHUD:(NSString *)text;
- (void)textStateHUD:(NSString *)text finishBlock:(void (^)())finishBlock;
- (void)showHud:(NSString *)text;
- (void)hideHUDView;

@end
