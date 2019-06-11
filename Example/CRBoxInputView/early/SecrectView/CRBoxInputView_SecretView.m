//
//  CRBoxInputView_SecretView.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputView_SecretView.h"
#import "CRBoxInputCell_SecretView.h"

@implementation CRBoxInputView_SecretView

- (void)initDefaultValue
{
    [super initDefaultValue];
    [[self mainCollectionView] registerClass:[CRBoxInputCell_SecretView class] forCellWithReuseIdentifier:CRBoxInputCell_SecretViewID];
}

- (CRBoxInputCell_SecretView *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputCell_SecretView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputCell_SecretViewID forIndexPath:indexPath];
    return cell;
}

@end
