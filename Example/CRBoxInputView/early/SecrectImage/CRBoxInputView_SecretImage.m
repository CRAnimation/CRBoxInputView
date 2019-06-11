//
//  CRBoxInputView_SecretImage.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputView_SecretImage.h"
#import "CRBoxInputCell_SecretImage.h"

@implementation CRBoxInputView_SecretImage

- (void)initDefaultValue
{
    [super initDefaultValue];
    [[self mainCollectionView] registerClass:[CRBoxInputCell_SecretImage class] forCellWithReuseIdentifier:CRBoxInputCell_SecretImageID];
}

- (CRBoxInputCell_SecretImage *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputCell_SecretImage *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputCell_SecretImageID forIndexPath:indexPath];
    return cell;
}

@end
