//
//  BearActivityManager.m
//  BiZhi
//
//  Created by Chobits on 2017/9/21.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "BearActivityManager.h"

@interface BearActivityManager () <NSCoding>

@end

@implementation BearActivityManager

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        if (!_fileName) {
            _fileName = @"BearActivityFile";
        }
    }
    
    return self;
}

- (NSObject *)activityInfo
{
    NSString *filePath = [self activityFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        NSObject *info = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (info) {
            return info;
        }
    }
    
    return nil;
}

- (BOOL)updateActivityInfo:(NSObject *)info
{
    NSString *filePath = [self activityFilePath];
    
    return [NSKeyedArchiver archiveRootObject:info toFile:filePath];
}

- (NSString *)activityFilePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [path stringByAppendingPathComponent:_fileName];
    
    return fullPath;
}

@end
