//
//  CRBoxInputView_SecretView.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputView_SecretView.h"
#import "CRBoxInputCell_SecretView.h"
#import "CRLineView.h"

@implementation CRBoxInputView_SecretView

- (void)initDefaultValue
{
    [super initDefaultValue];
    [[self mainCollectionView] registerClass:[CRBoxInputCell_SecretView class] forCellWithReuseIdentifier:CRBoxInputCell_SecretViewID];
}

- (CRBoxInputCell_SecretView *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputCell_SecretView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputCell_SecretViewID forIndexPath:indexPath];
    
    __weak typeof(self) weakSelf = self;
//    cell.placeSubViewBlock = ^(UIView * _Nonnull contentView) {
//        [weakSelf addSepLineView:contentView];
//    };
    
    return cell;
}

- (void)addSepLineView:(UIView *)contentView
{
    UIView *_sepLineView = [CRLineView new];
    [contentView addSubview:_sepLineView];
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
    }];
}

- (UIView *)myCustomSecurityView
{
    UIView *customSecurityView = [UIImageView new];
    
    UIView *rectangleView = [UIView new];
    rectangleView.layer.cornerRadius = 4;
    rectangleView.backgroundColor = color_master;
    [customSecurityView addSubview:rectangleView];
    [rectangleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(XX_6(24));
    }];
    
    rectangleView.layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
    rectangleView.layer.shadowOpacity = 1;
    rectangleView.layer.shadowOffset = CGSizeMake(0, 2);
    rectangleView.layer.shadowRadius = 4;
    
    return customSecurityView;
}

@end
