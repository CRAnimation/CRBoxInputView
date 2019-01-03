//
//  CRBoxInputself.m
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import "CRBoxInputCellProperty.h"

@implementation CRBoxInputCellProperty

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.cellBorderColorNormal = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
        self.cellBorderColorSelected = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
        self.cellBgColor = [UIColor whiteColor];
        self.cellCursorColor = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
        self.cornerRadius = 4;
        self.borderWidth = (0.5);
    }
    
    return self;
}

@end
