//
//  BearBaseRequestManager.m
//  BiZhi
//
//  Created by Chobits on 2017/9/19.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "BearBaseRequestManager.h"
#import <GBDeviceInfo/GBDeviceInfo.h>
#import "BearProxyManager.h"
#import "BearConstants.h"

@implementation BearBaseRequestManager

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _autoAddAgent = YES;
    }
    
    return self;
}

#pragma mark - Request
#pragma mark Get
- (void)getRequestWithURLStr:(NSString *)URLStr
                    paraDict:(NSDictionary *)paraDict
                successBlock:(void (^)(id responseObject))successBlock
                failureBlock:(void (^)(NSString *errorStr))failureBlock
{
    [self getRequestWithURLStr:URLStr
                      paraDict:paraDict
             completionHandler:^(BearBaseResponseVO *responseBaseVO) {
                 if (responseBaseVO.error) {
                     if (failureBlock) {
                         failureBlock([NSString stringWithFormat:@"请求失败:%ld", responseBaseVO.error.code]);
                     }
                 }else{
                     if (successBlock) {
                         successBlock(responseBaseVO.responseObject);
                     }
                 }
             }];
}

- (void)getRequestV2WithURLStr:(NSString *)URLStr
                    paraDict:(NSDictionary *)paraDict
                successBlock:(void (^)(id responseObject))successBlock
                failureBlock:(void (^)(NSString *errorStr, id responseObject))failureBlock
{
    [self getRequestWithURLStr:URLStr
                      paraDict:paraDict
             completionHandler:^(BearBaseResponseVO *responseBaseVO) {
                 if (responseBaseVO.error) {
                     if (failureBlock) {
                         failureBlock([NSString stringWithFormat:@"请求失败:%ld", responseBaseVO.error.code], responseBaseVO.responseObject);
                     }
                 }else{
                     if (successBlock) {
                         successBlock(responseBaseVO.responseObject);
                     }
                 }
             }];
}

- (void)getRequestWithURLStr:(NSString *)urlStr
                    paraDict:(NSDictionary *)paraDict
           completionHandler:(void (^)(BearBaseResponseVO *responseBaseVO))completionHandler
{
    AFURLSessionManager *manager = [self generateManager];
    
    NSURL *URL = [self generateGetURLWithURLStr:urlStr paraDict:paraDict];
    NSMutableURLRequest *request = [self generateRequestWithURL:URL];
    if (_autoAddAgent) {
        [self setUserAgentWithRequest:request];
    }
    
    [self baseRequestWithManager:manager
                         request:request
               completionHandler:^(BearBaseResponseVO *responseBaseVO) {
                   if (completionHandler) {
                       completionHandler(responseBaseVO);
                   }
               }];
}

#pragma mark Post
- (void)postRequestWithURLStr:(NSString *)URLStr
                     paraDict:(NSDictionary *)paraDict
                 successBlock:(void (^)(id responseObject))successBlock
                 failureBlock:(void (^)(NSString *errorStr))failureBlock
{
    [self postRequestWithURLStr:URLStr
                       paraDict:paraDict
             completionHandler:^(BearBaseResponseVO *responseBaseVO) {
                 if (responseBaseVO.error) {
                     if (failureBlock) {
                         failureBlock([NSString stringWithFormat:@"请求失败:%ld", responseBaseVO.error.code]);
                     }
                 }else{
                     if (successBlock) {
                         successBlock(responseBaseVO.responseObject);
                     }
                 }
             }];
}

- (void)postRequestWithURLStr:(NSString *)urlStr
                     paraDict:(NSDictionary *)paraDict
            completionHandler:(void (^)(BearBaseResponseVO *responseBaseVO))completionHandler
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:paraDict error:nil];
    if (_autoAddAgent) {
        [self setUserAgentWithRequest:request];
    }
    
    AFURLSessionManager *manager = [self generateManager];
    
    [self baseRequestWithManager:manager
                         request:request
               completionHandler:^(BearBaseResponseVO *responseBaseVO) {
                   if (completionHandler) {
                       completionHandler(responseBaseVO);
                   }
               }];
}

#pragma mark - 自定义Request
- (void)customRequestWithRequest:(NSMutableURLRequest *)request
                    successBlock:(void (^)(id responseObject))successBlock
                    failureBlock:(void (^)(NSString *errorStr))failureBlock
{
    BOOL haveProxyKey = [[[NSUserDefaults standardUserDefaults] objectForKey:UDProxyEnableKey] boolValue];
    if (!haveProxyKey) {
        if ([BearProxyManager getProxyStatus]) {
            if (failureBlock) {
                failureBlock(@"网络异常～");
            }
            return;
        }
    }
    
    [self customRequestWithRequest:request completionHandler:^(BearBaseResponseVO *responseBaseVO) {
        if (responseBaseVO.error) {
            if (failureBlock) {
                failureBlock([NSString stringWithFormat:@"请求失败:%ld", (long)responseBaseVO.error.code]);
            }
        }else{
            if (successBlock) {
                successBlock(responseBaseVO.responseObject);
            }
        }
    }];
}

- (void)customRequestWithRequest:(NSMutableURLRequest *)request
               completionHandler:(void (^)(BearBaseResponseVO *responseBaseVO))completionHandler
{
    if (_autoAddAgent) {
        [self setUserAgentWithRequest:request];
    }
    
    AFURLSessionManager *manager = [self generateManager];
    
    [self baseRequestWithManager:manager
                         request:request
               completionHandler:^(BearBaseResponseVO *responseBaseVO) {
                   if (completionHandler) {
                       completionHandler(responseBaseVO);
                   }
               }];
}

#pragma mark Decode
- (NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

#pragma mark DataTOjsonString
-(NSString*)DataTojsonString2:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

#pragma mark DictTojsonString
+ (NSString*)DictTojsonString:(NSDictionary *)infoDict
{
    NSMutableString *str = [NSMutableString new];
    NSArray *keys = infoDict.allKeys;
    for (int i = 0; i < [keys count]; i++) {
        NSString *keyStr = keys[i];
        NSString *tempStr = [NSString stringWithFormat:@"\"%@\":\"%@\"", keyStr, [infoDict objectForKey:keyStr]];
        [str appendString:tempStr];
        if (i < [keys count] - 1) {
            [str appendString:@","];
        }
    }
    NSString *jsonStr = [NSString stringWithFormat:@"{%@}", str];
    
    jsonStr =[jsonStr stringByReplacingOccurrencesOfString:@"(" withString:@"["];
    jsonStr =[jsonStr stringByReplacingOccurrencesOfString:@")" withString:@"]"];
    
    return jsonStr;
}

#pragma mark - New
#pragma mark - BaseRequestWithManager
- (void)baseRequestWithManager:(AFURLSessionManager *)manager
                       request:(NSURLRequest *)request
             completionHandler:(void (^)(BearBaseResponseVO *responseBaseVO))completionHandler
{
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (completionHandler) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            
            BearBaseResponseVO *responseBaseVO = [BearBaseResponseVO new];
            responseBaseVO.response = response;
            responseBaseVO.responseObject = responseObject;
            responseBaseVO.error = error;
            responseBaseVO.httpResponse = httpResponse;
            completionHandler(responseBaseVO);
        }
    }];
    [dataTask resume];
}

- (void)baseRequestWithManager:(AFURLSessionManager *)manager
                       request:(NSURLRequest *)request
                  successBlock:(void (^)(id responseObject, BearBaseResponseVO *responseBaseVO))successBlock
                  failureBlock:(void (^)(NSString *errorStr, id responseObject, BearBaseResponseVO *responseBaseVO))failureBlock
{
    [self baseRequestWithManager:manager request:request completionHandler:^(BearBaseResponseVO *responseBaseVO) {
        if (responseBaseVO.error) {
            if (failureBlock) {
                failureBlock([NSString stringWithFormat:@"请求失败:%ld", responseBaseVO.error.code], responseBaseVO.responseObject, responseBaseVO);
            }
        }else{
            if (successBlock) {
                successBlock(responseBaseVO.responseObject, responseBaseVO);
            }
        }
    }];
}

#pragma mark generateGetURL
- (NSURL *)generateGetURLWithURLStr:(NSString *)urlStr
                           paraDict:(NSDictionary *)paraDict
{
    NSURLComponents *components = [NSURLComponents componentsWithString:urlStr];
    
    NSArray<NSURLQueryItem *> *originQueryItems = components.queryItems;
    
    //Append Para
    NSMutableArray *queryItems;
    if (originQueryItems) {
        queryItems = [[NSMutableArray alloc] initWithArray:originQueryItems];
    }else{
        queryItems = [[NSMutableArray alloc] init];
    }
    
    if (paraDict) {
        for (NSString *key in paraDict.allKeys) {
            id value = [paraDict objectForKey:key];
            
            //  Dict Convert to JsonString
            if ([value isKindOfClass:[NSDictionary class]]) {
                value = [BearBaseRequestManager DictTojsonString:value];
            }
            else{
                value = [NSString stringWithFormat:@"%@", value];
            }
            
            NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:key value:value];
            [queryItems addObject:queryItem];
        }
        components.queryItems = queryItems;
    }
    
    NSURL *URL = components.URL;
    
    return URL;
}

#pragma mark - generateManager
- (AFURLSessionManager *)generateManager
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    return manager;
}

#pragma mark - generateRequestWithURL
- (NSMutableURLRequest *)generateRequestWithURL:(NSURL *)URL
{
    return [NSMutableURLRequest requestWithURL:URL];
}

#pragma mark - setUserAgentWithRequest
- (void)setUserAgentWithRequest:(NSMutableURLRequest *)request
{
    GBDeviceInfo *devInfo = [GBDeviceInfo deviceInfo];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleName"];
    if(!appName) appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if(!appName) appName = @"BearTestName";
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSString *diskTotalSize = [NSString stringWithFormat:@"%.2f", [[systemAttributes objectForKey:@"NSFileSystemSize"] floatValue]/1024/1024/1024];
    NSString *diskFreeSize = [NSString stringWithFormat:@"%.2f", [[systemAttributes objectForKey:@"NSFileSystemFreeSize"] floatValue]/1024/1024/1024];
   
    NSDictionary *baseAgentDict = @{
                                    @"appName" : appName,
                                    @"bundleId" : bundleId,
                                    @"version" : version,
                                    @"build" : [NSString stringWithFormat:@"%@", build],
                                    @"uuid": [NSString stringWithFormat:@"%@", uuid],
                                    
                                    @"diskInfo" : [NSString stringWithFormat:@"%@GB(%@GB)", diskTotalSize, diskFreeSize],
                                    
                                    @"modelString" : devInfo.modelString,
                                    @"osVersion" : [NSString stringWithFormat:@"iOS%lu.%lu.%lu", devInfo.osVersion.major, devInfo.osVersion.minor, devInfo.osVersion.patch],
                                    @"pixelsPerInch" : [NSString stringWithFormat:@"%.0fppi", devInfo.displayInfo.pixelsPerInch],
                                    @"physicalMemory" : [NSString stringWithFormat:@"%.0fG", devInfo.physicalMemory],
                                    @"cpuInfo" : [NSString stringWithFormat:@"%.0fGHz(%lu)Cache%.0fKB", devInfo.cpuInfo.frequency, devInfo.cpuInfo.numberOfCores, devInfo.cpuInfo.l2CacheSize],
                                    };
    
    for (NSString *key in baseAgentDict.allKeys) {
        [request setValue:baseAgentDict[key] forHTTPHeaderField:key];
    }
}

@end
