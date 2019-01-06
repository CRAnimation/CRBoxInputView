//
//  CRBoxInputCell_CustomSecurity.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/6.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputCell_CustomSecurity.h"

@interface CRBoxInputCell_CustomSecurity ()

@end

@implementation CRBoxInputCell_CustomSecurity

- (UIImageView *)createCustomSecurityView
{
    UIImageView *customSecurityView = [UIImageView new];
    customSecurityView.image = [UIImage imageNamed:@"密码"];

    return customSecurityView;
}

@end
