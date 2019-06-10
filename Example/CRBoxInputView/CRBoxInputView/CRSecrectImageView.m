//
//  CRSecrectImageView.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/6/10.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRSecrectImageView.h"

@implementation CRSecrectImageView

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
    UIImageView *_lockImgView = [UIImageView new];
    _lockImgView.image = [UIImage imageNamed:@"smallLock"];
    [self addSubview:_lockImgView];
    [_lockImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.mas_equalTo(XX_6(23));
        make.height.mas_equalTo(XX_6(27));
    }];
}

@end
