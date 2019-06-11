//
//  CRBoxTextView.m
//  CRBoxInputView
//
//  Created by Chobits on 2019/1/3.
//

#import "CRBoxTextView.h"

@implementation CRBoxTextView

/**
 * /禁止可被粘贴复制
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
