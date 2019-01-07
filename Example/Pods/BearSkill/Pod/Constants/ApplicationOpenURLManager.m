//
//  ApplicationOpenURLManager.m
//  Pods
//
//  Created by apple on 16/9/18.
//
//

#import "ApplicationOpenURLManager.h"
#import "BearDefines.h"

@implementation ApplicationOpenURLManager

//  打开系统设置
+ (void)openPrefsURL:(NSString *)openURL
{
    NSURL *url;
    
    if (over_iOS10) {
        url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    }
    else{
        url = [NSURL URLWithString:openURL];
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    else{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"无法进行跳转，请手动前往设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    }
}

@end
