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
    cell.placeSubViewBlock = ^(UIView * _Nonnull contentView) {
        contentView.layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
        contentView.layer.shadowOpacity = 1;
        contentView.layer.shadowOffset = CGSizeMake(0, 2);
        contentView.layer.shadowRadius = 4;
    };
    
    return cell;
}

@end
