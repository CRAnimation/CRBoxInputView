//
//  BearActivityManager.h
//  BiZhi
//
//  Created by Chobits on 2017/9/21.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BearActivityManager : NSObject

@property (strong, nonatomic) NSString *fileName;

- (NSObject *)activityInfo;
- (BOOL)updateActivityInfo:(NSObject *)info;

@end
