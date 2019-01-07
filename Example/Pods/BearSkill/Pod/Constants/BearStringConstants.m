//
//  BearStringConstants.m
//  AFNetworking
//
//  Created by Chobits on 2017/10/24.
//

#import "BearStringConstants.h"

@implementation BearStringConstants

// 判断字符串是否包含字符串
+ (BOOL)judgeOriginStr:(NSString *)originStr containStr:(NSString *)containStr
{
    NSRange range = [originStr rangeOfString:containStr];
    if (range.location == NSNotFound) {
        return NO;
    }else{
        return YES;
    }
}

// 获取prefixStr和suffixStr之间的字符串
+ (NSString *)getContentFromOriginStr:(NSString *)originStr
                            prefixStr:(NSString *)prefixStr
                            suffixStr:(NSString *)suffixStr
{
    NSRange prefixRange = [originStr rangeOfString:prefixStr];
    NSRange suffixRange = [originStr rangeOfString:suffixStr];
    
    if (prefixRange.location == NSNotFound || suffixRange.location == NSNotFound) {
        return nil;
    }
    
    NSUInteger contentStrLocation = prefixRange.location + prefixStr.length;
    NSUInteger contentStrLength = suffixRange.location - contentStrLocation;
    
    NSString *contentStr = [originStr substringWithRange:NSMakeRange(contentStrLocation, contentStrLength)];
    
    return contentStr;
}

// json->Dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// dict->Json
+ (NSString*)convertToJSONData:(id)infoDict
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

@end
