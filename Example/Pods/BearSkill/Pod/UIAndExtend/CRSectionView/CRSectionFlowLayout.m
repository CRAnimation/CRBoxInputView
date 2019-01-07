//
//  CRSectionFlowLayout.m
//  BiZhi
//
//  Created by Chobits on 2017/9/18.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "CRSectionFlowLayout.h"

@implementation CRSectionFlowLayout

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initPara];
    }
    
    return self;
}

- (void)initPara
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}

@end
