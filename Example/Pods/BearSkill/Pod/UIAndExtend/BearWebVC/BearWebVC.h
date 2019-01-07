//
//  BearWebVC.h
//  kzloan
//
//  Created by Chobits on 2017/9/15.
//  Copyright © 2017年 杭州傲熠网络技术有限公司. All rights reserved.
//

#import <BearSkill/BearBaseViewController.h>

@interface BearWebVC : BearBaseViewController <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

- (instancetype)initWithURLStr:(NSString *)urlStr;

@end
