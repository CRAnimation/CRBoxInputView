//
//  BearProxyManager.h
//  SuperVideo
//
//  Created by Chobits on 2017/10/30.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UDProxyEnableKey @"UDProxyEnableKey"

@interface BearProxyManager : NSObject

+ (BOOL)getProxyStatus;
+ (void)unLockProxyModel;
+ (BOOL)adminStatus;

@end
