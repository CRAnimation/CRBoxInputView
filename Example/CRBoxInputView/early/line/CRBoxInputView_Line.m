//
//  CRBoxInputView_Line.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRBoxInputView_Line.h"
#import "CRBoxInputCell_Line.h"

@implementation CRBoxInputView_Line

- (void)initDefaultValue
{
    [super initDefaultValue];
    [[self mainCollectionView] registerClass:[CRBoxInputCell_Line class] forCellWithReuseIdentifier:CRBoxInputView_LineID];
}

- (CRBoxInputCell_Line *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputCell_Line *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputView_LineID forIndexPath:indexPath];
    return cell;
}

@end
