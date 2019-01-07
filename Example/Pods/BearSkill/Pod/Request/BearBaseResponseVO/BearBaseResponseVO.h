//
//  BearBaseResponseVO.h
//  BiZhi
//
//  Created by Chobits on 2017/9/19.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BearBaseResponseVO : NSObject

@property (strong, nonatomic) NSURLResponse *response;
@property (strong, nonatomic) id responseObject;
@property (strong, nonatomic) NSError *error;
@property (strong, nonatomic) NSHTTPURLResponse *httpResponse;

@end
