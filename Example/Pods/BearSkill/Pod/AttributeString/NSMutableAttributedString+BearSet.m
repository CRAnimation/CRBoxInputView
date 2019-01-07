//
//  NSMutableAttributedString+BearSet.m
//  Pods
//
//  Created by apple on 16/5/16.
//
//

#import "NSMutableAttributedString+BearSet.h"

@implementation NSMutableAttributedString (BearSet)

//  判断单个字符是否符合某一种正则
//  演示数据：regex = @"[0-9]|[.]|[+]|[-]";
- (BOOL)judgeCharacter_regex:(NSString *)regex withStr:(NSString *)str
{
    NSPredicate *strPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([strPredicate evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

//  对符合正则的字符串中的某些字符进行富文本设置
- (void)setAttributeCharacter_regex:(NSString *)regex font:(UIFont *)font color:(UIColor *)color
{
    NSString *string = self.string;
    
    for (int i = 0; i < [string length]; i++) {
        NSRange tempRange = NSMakeRange(i, 1);
        NSString *tempStr = [string substringWithRange:tempRange];
        if ([self judgeCharacter_regex:regex withStr:tempStr]) {
            
            if (font) {
                [self addAttribute:NSFontAttributeName value:font range:tempRange];
            }
            
            if (color) {
                [self addAttribute:NSForegroundColorAttributeName value:color range:tempRange];
            }
            
        }
    }
}

//  对指定的字符串进行富文本设置
- (void)setAttributeString_specifyStr:(NSString *)specifyStr font:(UIFont *)font color:(UIColor *)color
{
    NSString *string = self.string;
    
    if ([string rangeOfString:specifyStr].location != NSNotFound) {
        
        NSRange tempRange = [string rangeOfString:specifyStr];
        
        if (font) {
            [self addAttribute:NSFontAttributeName value:font range:tempRange];
        }
        
        if (color) {
            [self addAttribute:NSForegroundColorAttributeName value:color range:tempRange];
        }
        
    }
}

//  设置行间距
- (void)setLineSpacing:(CGFloat)spacing
{
    NSString *labelText = self.string;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];//调整行间距
    
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
}

//  设置删除线
- (void)setDeleteLine
{
    NSString *string = self.string;
    
    [self setDeleteLineWithRange:NSMakeRange(0, [string length]) lineColor:[UIColor grayColor]];
}

- (void)setDeleteLineWithLineColor:(UIColor *)lineColor
{
    NSString *string = self.string;
    
    [self setDeleteLineWithRange:NSMakeRange(0, [string length]) lineColor:lineColor];
}

- (void)setDeleteLineWithRange:(NSRange)range lineColor:(UIColor *)lineColor
{
    [self addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:range];
    [self addAttribute:NSStrikethroughColorAttributeName value:lineColor range:range];
}

@end
