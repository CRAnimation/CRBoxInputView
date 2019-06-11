//
//  CRBoxInputCell_CustomBox.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputCell_CustomBox.h"

@implementation CRBoxInputCell_CustomBox

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowRadius = 4;
    }
    
    return self;
}

@end
