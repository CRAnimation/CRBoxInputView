//
//  BearErrorNetAlertManager.h
//  SuperVideo
//
//  Created by Chobits on 2017/11/13.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BearAlertManager.h"

typedef void (^RetryClickBlock) (void);

@interface BearErrorNetAlertManager : NSObject

@property (strong, nonatomic) BearAlertManager *alertManager;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) UIButton *retryBtn;
@property (copy, nonatomic) RetryClickBlock retryClickBlock;

- (void)show;
- (void)showWithErrorStr:(NSString *)errorStr;

- (void)relayUI;
- (void)setErrorStr:(NSString *)errorStr;
- (void)showInView:(UIView *)inView;

#pragma mark - Usage
- (void)Usage;

@end
