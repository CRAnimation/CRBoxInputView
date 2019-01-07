//
//  CRSectionCollectionViewCell.m
//  BiZhi
//
//  Created by Chobits on 2017/9/18.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "CRSectionCollectionViewCell.h"

@interface CRSectionCollectionViewCell ()

@end

@implementation CRSectionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createTitleLabel];
    }
    
    return self;
}

- (void)createTitleLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    self.backgroundColor = [UIColor whiteColor];
}

@end
