//
//  BearWebVC.m
//  kzloan
//
//  Created by Chobits on 2017/9/15.
//  Copyright © 2017年 杭州傲熠网络技术有限公司. All rights reserved.
//

#import "BearWebVC.h"

@interface BearWebVC ()
{
    NSString *_urlStr;
}
@end

@implementation BearWebVC

- (instancetype)initWithURLStr:(NSString *)urlStr
{
    self = [super init];
    
    if (self) {
        _urlStr = urlStr;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _webView.frame = self.contentView.bounds;
    [self loadWithURLStr:_urlStr];
}

- (void)createUI
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    _webView.backgroundColor = [UIColor grayColor];
    [_webView setScalesPageToFit:YES];
    _webView.delegate = self;
    [self.contentView addSubview:_webView];
}

- (void)loadWithURLStr:(NSString *)urlStr
{
//    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
//    NSLog(@"--absoluteStr:%@", url.absoluteString);
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:req];
}

#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHud:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHUDView];
    
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationController.title = title;
}

@end
