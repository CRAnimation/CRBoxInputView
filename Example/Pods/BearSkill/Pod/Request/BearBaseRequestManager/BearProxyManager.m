//
//  BearProxyManager.m
//  SuperVideo
//
//  Created by Chobits on 2017/10/30.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "BearProxyManager.h"
#import "BearHUDManager.h"
#import "BearSkill.h"
#import <CFNetwork/CFNetwork.h>

@implementation BearProxyManager

+ (BOOL)getProxyStatus
{
    NSDictionary *proxySettings = NSMakeCollectable([(NSDictionary *)CFNetworkCopySystemProxySettings() autorelease]);
    NSArray *proxies = NSMakeCollectable([(NSArray *)CFNetworkCopyProxiesForURL((CFURLRef)[NSURL URLWithString:@"http://www.baidu.com"], (CFDictionaryRef)proxySettings) autorelease]);
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    bool showProxyInfo = NO;
    if (showProxyInfo) {
        NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
        NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
        NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    }
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        //没有设置代理
        return NO;
    }
    else
    {
        //设置代理了
        return YES;
    }
}

+ (BOOL)adminStatus
{
    return [UDGET_HARD(UDProxyEnableKey) boolValue];
}

+ (void)unLockProxyModel
{
    UDSET(@YES, UDProxyEnableKey);
    BearHUDManager *hudManager = [[BearHUDManager alloc] initInView:[UIApplication sharedApplication].keyWindow];
    [hudManager textStateHUD:@"^_^"];
}

@end
