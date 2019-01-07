///
//  BearBaseWKWebVC.m
//  AFNetworking
//
//  Created by Chobits on 2017/12/14.
//

#import "BearBaseWKWebVC.h"
#import "BearConstants.h"
#import "BearBaseRequestManager.h"

@interface BearBaseWKWebVC () <WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>
{
    NSDictionary *_paraDict;
}

@property(nonatomic,strong)NSString *originUrl;
//webView
@property(nonatomic,strong)WKWebView *webView;
//进度条
@property(nonatomic,strong)UIProgressView *progressView;

@end

@implementation BearBaseWKWebVC

- (instancetype)initWithURLStr:(NSString *)urlStr
{
    self = [super init];
    
    if (self) {
        _originUrl = urlStr;
    }
    
    return self;
}

- (instancetype)initWithURLStr:(NSString *)urlStr paraDict:(NSDictionary *)paraDict
{
    self = [super init];
    
    if (self) {
        _originUrl = urlStr;
        _paraDict = paraDict;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.webView.URL) {
        NSURL *url = [[BearBaseRequestManager new] generateGetURLWithURLStr:_originUrl paraDict:_paraDict];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatWebView];
    [self creatProgressView];
    [self addKVO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - CreateUI
- (void)creatProgressView{
    self.progressView = [[UIProgressView alloc]initWithFrame:self.contentView.bounds];
    self.progressView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.progressView];
}

//创建webView
- (void)creatWebView{
    self.webView = [[WKWebView alloc]initWithFrame:self.contentView.bounds configuration:self.config];
    [self.contentView addSubview:self.webView];
    
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
}

#pragma mark - Func
- (void)loadWithUrlStr:(NSString *)urlStr
{
    if (urlStr) {
        NSURL *url = [[BearBaseRequestManager new] generateGetURLWithURLStr:urlStr paraDict:_paraDict];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

#pragma mark - KVO
- (void)addKVO
{
    //添加KVO监听
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
}

- (void)removeKVO
{
    //移除监听
    [self.webView removeObserver:self forKeyPath:@"loading"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - KVO监听函数
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"title"]) {
        if ([BearConstants judgeStringExist:_staticTitle]) {
            self.title = _staticTitle;
        }else{
            self.title = self.webView.title;
        }
    }else if([keyPath isEqualToString:@"loading"]){
        NSLog(@"loading");
    }
    else if ([keyPath isEqualToString:@"estimatedProgress"]){
        //estimatedProgress取值范围是0-1;
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    if (!self.webView.loading) {
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        }];
    }
}

#pragma mark - WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //这里可以通过name处理多组交互
    if ([message.name isEqualToString:@"demoName"]) {
        //body只支持NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull类型
        NSLog(@"%@",message.body);
    }
    
}

#pragma mark = WKNavigationDelegate
//在发送请求之前，决定是否跳转
//-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//
//    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
//    NSLog(@"%@",hostname);
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
//        && ![hostname containsString:@".baidu.com"]) {
//        // 对于跨域，需要手动跳转
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//
//        // 不允许web内跳转
//        decisionHandler(WKNavigationActionPolicyCancel);
//    } else {
//        self.progressView.alpha = 1.0;
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//
//}
//在响应完成时，调用的方法。如果设置为不允许响应，web内容就不会传过来

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//接收到服务器跳转请求之后调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

//开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"title:%@",webView.title);
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}

//#pragma mark WKUIDelegate
//
////alert 警告框
//-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"调用alert提示框" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }]];
//    [self presentViewController:alert animated:YES completion:nil];
//    NSLog(@"alert message:%@",message);
//
//}
//
////confirm 确认框
//-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:@"调用confirm提示框" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(YES);
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(NO);
//    }]];
//    [self presentViewController:alert animated:YES completion:NULL];
//
//    NSLog(@"confirm message:%@", message);
//
//}
//
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:@"调用输入框" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.textColor = [UIColor blackColor];
//    }];
//
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler([[alert.textFields lastObject] text]);
//    }]];
//
//    [self presentViewController:alert animated:YES completion:NULL];
//}

#pragma mark - Rewrite
- (void)popSelf
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [super popSelf];
    }
}

#pragma mark - Setter & Getter
- (WKWebViewConfiguration *)config
{
    if (!_config) {
        _config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        _config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        _config.preferences.minimumFontSize = 10;
        //是否支持JavaScript
        _config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        _config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        //通过JS与webView内容交互
        _config.userContentController = [WKUserContentController new];
    }
    
    return _config;
}

- (void)dealloc
{
    [self removeKVO];
}

@end
