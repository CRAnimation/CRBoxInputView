//
//  NSMutableAttributedString+BearSet.h
//  Pods
//
//  Created by apple on 16/5/16.
//
//


//
//  富文本设置
//  适用于 UILabel, UITextField, UITextView
//  适用于所有的AttributeString
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (BearSet)

//  判断单个字符是否符合某一种正则
- (BOOL)judgeCharacter_regex:(NSString *)regex withStr:(NSString *)str;

//  对符合正则的字符串中的某些字符进行富文本设置
- (void)setAttributeCharacter_regex:(NSString *)regex font:(UIFont *)font color:(UIColor *)color;

//  对指定的字符串进行富文本设置
- (void)setAttributeString_specifyStr:(NSString *)specifyStr font:(UIFont *)font color:(UIColor *)color;

//  设置行间距
- (void)setLineSpacing:(CGFloat)spacing;

//  设置删除线
- (void)setDeleteLine;
- (void)setDeleteLineWithLineColor:(UIColor *)lineColor;
- (void)setDeleteLineWithRange:(NSRange)range lineColor:(UIColor *)lineColor;

@end
