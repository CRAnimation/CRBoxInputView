//
//  CRBoxInputView_CustomSecurity.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/6.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputView_CustomSecurity.h"
#import "CRBoxInputCell_CustomSecurity.h"

@implementation CRBoxInputView_CustomSecurity

- (void)initDefaultValue
{
    [super initDefaultValue];
    [[self mainCollectionView] registerClass:[CRBoxInputCell_CustomSecurity class] forCellWithReuseIdentifier:CRBoxInputCell_CustomSecurityID];
}

- (CRBoxInputCell_CustomSecurity *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputCell_CustomSecurity *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputCell_CustomSecurityID forIndexPath:indexPath];
    return cell;
}

@end
