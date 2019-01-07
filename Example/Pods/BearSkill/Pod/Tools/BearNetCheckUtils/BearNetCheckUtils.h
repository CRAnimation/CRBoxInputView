//
//  BearNetCheckUtils.h
//  AFNetworking
//
//  Created by Chobits on 2017/11/15.
//

#import <Foundation/Foundation.h>

@interface BearNetCheckUtils : NSObject

+ (BOOL)isReachableViaWiFi;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachable;

+ (void)showNetLog;

@end
