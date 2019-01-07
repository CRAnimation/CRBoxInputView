//
//  CRSectionViewUIService.m
//  BiZhi
//
//  Created by Chobits on 2017/9/18.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "CRSectionViewUIService.h"
#import "CRSectionCollectionViewCell.h"

@interface CRSectionViewUIService ()

@end

@implementation CRSectionViewUIService

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRSectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRSectionCollectionViewCellID forIndexPath:indexPath];
    
    if (self.titles[indexPath.row]) {
        cell.titleLabel.text = self.titles[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_didSelectIndexPath) {
        _didSelectIndexPath(indexPath);
    }
    
    if ([_delegate respondsToSelector:@selector(CRSectionDidSelectIndexPath:)]) {
        [_delegate CRSectionDidSelectIndexPath:indexPath];
    }
    
    if ([_delegate respondsToSelector:@selector(CRSectionUIService:sectionDidSelectIndexPath:)]) {
        [_delegate CRSectionUIService:self sectionDidSelectIndexPath:indexPath];
    }
}

@end
