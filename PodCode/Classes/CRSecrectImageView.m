//
//  CRSecrectImageView.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/6/10.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRSecrectImageView.h"
#import <Masonry/Masonry.h>

@interface CRSecrectImageView()
{
    UIImageView *_lockImgView;
}
@end

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
    _lockImgView = [UIImageView new];
    _lockImgView.image = [UIImage imageNamed:@"smallLock"];
    [self addSubview:_lockImgView];
    [_lockImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.mas_equalTo(23);
        make.height.mas_equalTo(27);
    }];
}

#pragma mark - Setter & Getter
- (void)setImage:(UIImage *)image
{
    _image = image;
    _lockImgView.image = image;
}

- (void)setImageWidth:(CGFloat)imageWidth
{
    _imageWidth = imageWidth;
    [_lockImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageWidth);
    }];
}

- (void)setImageHeight:(CGFloat)imageHeight
{
    _imageHeight = imageHeight;
    [_lockImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(imageHeight);
    }];
}

@end
