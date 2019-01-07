//
//  ApplicationOpenURLManager.h
//  Pods
//
//  Created by apple on 16/9/18.
//
//

#import <Foundation/Foundation.h>

static NSString *kPrefs_Privacy     = @"prefs:root=Privacy";
static NSString *kPrefs_Contacts    = @"prefs:root=Privacy&path=CONTACTS";
static NSString *kPrefs_Location    = @"prefs:root=LOCATION_SERVICES";
static NSString *kPrefs_ = @"";

@interface ApplicationOpenURLManager : NSObject

//  打开系统设置
+ (void)openPrefsURL:(NSString *)openURL;

@end
