//
//  CRSectionView.m
//  BiZhi
//
//  Created by Chobits on 2017/9/18.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "CRSectionView.h"
#import "CRSectionCollectionViewCell.h"
#import <BearSkill/BearSkill.h>

@interface CRSectionView () <CRSectionViewDataSource>

@property (strong, nonatomic) UICollectionView *mainCollectionView;
@property (strong, nonatomic) CRSectionViewUIService *sectionUIService;
@property (strong, nonatomic) CRSectionFlowLayout *sectionFlowLayout;
@property (strong, nonatomic) UIView *indicatorLineView;
@property (assign, nonatomic) CGFloat animationDuring;

@end

@implementation CRSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initPara];
        [self calculatePara];
        
        __weak typeof(self) weakSelf = self;
        self.dataSource = weakSelf;
        [self reloadDataSource];
        
        self.backgroundColor = [UIColor grayColor];
        [self createUI];
        [self scrollToIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animate:NO];
    }
    
    return self;
}

- (void)initPara
{
    self.sepLineSize = CGSizeMake(100, 2);
    self.gapX = 5;
    self.animationDuring = 0.3;
    self.needSelectAutoScroll = YES;
    self.sepLineColor = [UIColor blackColor];
}

- (void)calculatePara
{
    self.itemSize = CGSizeMake(self.sepLineSize.width, self.height - self.sepLineSize.height);
    self.edgeInset = UIEdgeInsetsMake(0, 20, self.sepLineSize.height, 20);
}

- (void)createUI
{
    [self addSubview:self.mainCollectionView];
}

#pragma mark - Setter & Getter
#pragma mark mainCollectionView
- (UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.sectionFlowLayout];
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        [_mainCollectionView registerClass:[CRSectionCollectionViewCell class] forCellWithReuseIdentifier:CRSectionCollectionViewCellID];
    }
    
    return _mainCollectionView;
}

#pragma mark sectionFlowLayout
- (CRSectionFlowLayout *)sectionFlowLayout
{
    if (!_sectionFlowLayout) {
        if ([_dataSource respondsToSelector:@selector(sectionFlowLayoutInCRSectionView:)]) {
            _sectionFlowLayout = [_dataSource sectionFlowLayoutInCRSectionView:self];
        }
    }
    
    return _sectionFlowLayout;
}

#pragma mark indicatorLineView
- (UIView *)indicatorLineView
{
    if (!_indicatorLineView) {
        if ([_dataSource respondsToSelector:@selector(indicatorLineViewInCRSectionView:)]) {
            _indicatorLineView = [_dataSource indicatorLineViewInCRSectionView:self];
        }
    }
    
    return _indicatorLineView;
}

#pragma mark dataSource
- (void)setDataSource:(id<CRSectionViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self calculatePara];
    [self reloadDataSource];
}

#pragma mark - Function

- (void)reloadDataSource
{
    if ([_dataSource respondsToSelector:@selector(sectionUIServiceInCRSectionView:)]) {
        self.sectionUIService = [_dataSource sectionUIServiceInCRSectionView:self];
        self.mainCollectionView.delegate = self.sectionUIService;
        self.mainCollectionView.dataSource = self.sectionUIService;
        
        __weak typeof(self) weakSelf = self;
        self.sectionUIService.didSelectIndexPath = ^(NSIndexPath *indexPath) {
            if (weakSelf.needSelectAutoScroll) {
                [weakSelf scrollToIndexPath:indexPath animate:YES];
            }
        };
    }
    
    if ([_dataSource respondsToSelector:@selector(sectionFlowLayoutInCRSectionView:)]) {
        self.sectionFlowLayout = [_dataSource sectionFlowLayoutInCRSectionView:self];
        self.mainCollectionView.collectionViewLayout = self.sectionFlowLayout;
    }
    
    if ([_dataSource respondsToSelector:@selector(indicatorLineViewInCRSectionView:)]) {
        
        // clean
        if (_indicatorLineView) {
            [_indicatorLineView removeFromSuperview];
            _indicatorLineView = nil;
        }
        
        // add
        _indicatorLineView = [_dataSource indicatorLineViewInCRSectionView:self];
        if (_indicatorLineView) {
            [self.mainCollectionView addSubview:_indicatorLineView];
            [_indicatorLineView setMaxY:self.mainCollectionView.height];
        }
    }
}

- (void)reloadData
{
    [self.mainCollectionView reloadData];
}

- (void)indicatorScrollToIndex:(NSInteger)index
{
    CGSize itemSize = self.sectionFlowLayout.itemSize;
    UIEdgeInsets edgeInset = self.sectionFlowLayout.sectionInset;
    CGFloat gapX = self.sectionFlowLayout.minimumLineSpacing;
    
    CGFloat indicatorX = edgeInset.left + index * (gapX + itemSize.width);
    [self.indicatorLineView setX:indicatorX];
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath
{
    [self indicatorScrollToIndex:indexPath.row];
    [self.mainCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath animate:(BOOL)animate
{
    if (animate) {
        
        [UIView animateWithDuration:self.animationDuring animations:^{
            if ([_delegate respondsToSelector:@selector(sectionView:willScrollToIndexPath:)]) {
                [_delegate sectionView:self willScrollToIndexPath:indexPath];
            }
            [self scrollToIndexPath:indexPath];
        } completion:^(BOOL finished) {
            if ([_delegate respondsToSelector:@selector(sectionView:didScrollToIndexPath:)]) {
                [_delegate sectionView:self didScrollToIndexPath:indexPath];
            }
        }];
    }else{
        
        if ([_delegate respondsToSelector:@selector(sectionView:willScrollToIndexPath:)]) {
            [_delegate sectionView:self willScrollToIndexPath:indexPath];
        }
        [self scrollToIndexPath:indexPath];
        if ([_delegate respondsToSelector:@selector(sectionView:didScrollToIndexPath:)]) {
            [_delegate sectionView:self didScrollToIndexPath:indexPath];
        }
    }
}

#pragma mark - CRSectionViewDataSource
- (__kindof CRSectionViewUIService *)sectionUIServiceInCRSectionView:(CRSectionView *)CRSectionView
{
    CRSectionViewUIService *sectionUIService = [CRSectionViewUIService new];
    sectionUIService.titles = @[@"test1", @"test2", @"test3", @"test4", @"test5", @"test6"];
    return sectionUIService;
}

- (__kindof CRSectionFlowLayout *)sectionFlowLayoutInCRSectionView:(CRSectionView *)crSectionView
{
    CRSectionFlowLayout *sectionFlowLayout = [CRSectionFlowLayout new];
    sectionFlowLayout.itemSize = crSectionView.itemSize;
    sectionFlowLayout.sectionInset = crSectionView.edgeInset;
    sectionFlowLayout.minimumLineSpacing = crSectionView.gapX;
    return sectionFlowLayout;
}

- (UIView *)indicatorLineViewInCRSectionView:(CRSectionView *)crSectionView
{
    UIView *indicatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                         crSectionView.height - crSectionView.sepLineSize.height,
                                                                         crSectionView.sepLineSize.width,
                                                                         crSectionView.sepLineSize.height)];
    indicatorLineView.backgroundColor = _sepLineColor;
    return indicatorLineView;
}

@end
