//
//  BearNetCheckUtils.m
//  AFNetworking
//
//  Created by Chobits on 2017/11/15.
//

#import "BearNetCheckUtils.h"
#import <Reachability/Reachability.h>

@implementation BearNetCheckUtils

+ (BOOL)isReachableViaWiFi
{
    return ([[Reachability reachabilityForLocalWiFi] isReachableViaWiFi]);
}

+ (BOOL)isReachableViaWWAN
{
    return ([[Reachability reachabilityForInternetConnection] isReachableViaWWAN]);
}

+ (BOOL)isReachable
{
    if ([[Reachability reachabilityForInternetConnection] isReachable]) {
        return YES;
    }
    return NO;
}

+ (void)showNetLog
{
    BOOL isReachable = [BearNetCheckUtils isReachable];
    BOOL isWWAN = [BearNetCheckUtils isReachableViaWWAN];
    BOOL isWifi = [BearNetCheckUtils isReachableViaWiFi];
    NSLog(@"--isReachable:%@", isReachable ? @"YES" : @"NO");
    NSLog(@"--isWWAN:%@", isWWAN ? @"YES" : @"NO");
    NSLog(@"--isWifi:%@", isWifi ? @"YES" : @"NO");
    NSLog(@"===");
}

@end
