//
//  BearWindowHUDManager.m
//  Pods
//
//  Created by Chobits on 2017/9/24.
//
//

#import "BearWindowHUDManager.h"

static BearWindowHUDManager *__sharedManager;

@implementation BearWindowHUDManager

+ (BearWindowHUDManager *)sharedManager
{
    if (!__sharedManager) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        __sharedManager = [[BearWindowHUDManager alloc] initInView:window];
    }
    
    return __sharedManager;
}

@end
