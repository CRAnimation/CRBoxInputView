//
//  CRLineView.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/6/10.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRLineView.h"

@implementation CRLineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    static CGFloat sepLineViewHeight = 4;
    
    self.backgroundColor = color_master;
    self.layer.cornerRadius = sepLineViewHeight / 2.0;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(sepLineViewHeight);
    }];
    
    self.layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 4;
}

@end
