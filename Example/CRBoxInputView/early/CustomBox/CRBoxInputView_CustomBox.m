//
//  CRBoxInputView_CustomBox.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputView_CustomBox.h"
#import "CRBoxInputCell_CustomBox.h"

@implementation CRBoxInputView_CustomBox

- (void)initDefaultValue
{
    [super initDefaultValue];
    [[self mainCollectionView] registerClass:[CRBoxInputCell_CustomBox class] forCellWithReuseIdentifier:CRBoxInputCell_CustomBoxID];
}

- (CRBoxInputCell_CustomBox *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputCell_CustomBox *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputCell_CustomBoxID forIndexPath:indexPath];
    return cell;
}

@end
