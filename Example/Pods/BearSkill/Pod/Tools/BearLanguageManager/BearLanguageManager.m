//
//  BearLanguageManager.m
//  BiZhi
//
//  Created by Chobits on 2017/11/21.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "BearLanguageManager.h"

static BearLanguageManager *__kSharedManager;

@interface BearLanguageManager ()

@property (strong, nonatomic) NSString *systemLanguageName;

@end

@implementation BearLanguageManager

+ (BearLanguageManager *)sharedManager
{
    if (!__kSharedManager) {
        __kSharedManager = [BearLanguageManager new];
    }
    
    return __kSharedManager;
}

-(NSString *)showText:(NSString *)key
{
    NSString *showStr = NSLocalizedStringFromTable(key, @"BZLocalized", nil);
    if (!showStr || showStr.length == 0) {
        showStr = @"";
    }
    
    return showStr;
}

- (NSString *)getChineseDisplayName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
    NSString *chineseDisplayName = [[NSBundle bundleWithPath:path] localizedStringForKey:@"CFBundleDisplayName" value:nil table:@"InfoPlist"];
    return chineseDisplayName;
}

#pragma mark - Setter & Getter
- (NSString *)systemLanguageName
{
    if (!_systemLanguageName) {
        NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString *language = [appLanguages objectAtIndex:0];
        
        if ([language containsString:@"zh-Hans"]) {
            language = @"zh-Hans";
        }else{
            language = @"en";
        }
        _systemLanguageName = language;
    }
    
    return _systemLanguageName;
}

@end
