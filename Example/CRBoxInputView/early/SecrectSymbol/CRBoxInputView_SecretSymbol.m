//
//  CRBoxInputView_SecretSymbol.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputView_SecretSymbol.h"
#import "CRBoxInputCell_SecretSymbol.h"

@implementation CRBoxInputView_SecretSymbol

- (void)initDefaultValue
{
    [super initDefaultValue];
    [[self mainCollectionView] registerClass:[CRBoxInputCell_SecretSymbol class] forCellWithReuseIdentifier:CRBoxInputCell_SecretSymbolID];
}

- (CRBoxInputCell_SecretSymbol *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputCell_SecretSymbol *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputCell_SecretSymbolID forIndexPath:indexPath];
    return cell;
}

@end
