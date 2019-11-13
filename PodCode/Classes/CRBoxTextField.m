//
//  CRBoxTextField.m
//  CRBoxInputView
//
//  Created by Chobits on 2019/1/3.
//

#import "CRBoxTextField.h"

@implementation CRBoxTextField

/**
 * /禁止可被粘贴复制
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
