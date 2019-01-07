//
//  BearLanguageManager.h
//  BiZhi
//
//  Created by Chobits on 2017/11/21.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>

//封装了一个宏 用来方便输入文字--实际是文字对应的key
#define BearLocalStr(key) [[BearLanguageManager sharedManager] showText:(key)]

@interface BearLanguageManager : NSObject

@property (strong, nonatomic, readonly) NSString *systemLanguageName;

+ (BearLanguageManager *)sharedManager;

- (NSString *)showText:(NSString *)key;
- (NSString *)getChineseDisplayName;

@end
