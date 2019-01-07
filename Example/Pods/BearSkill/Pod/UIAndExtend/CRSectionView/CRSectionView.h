//
//  CRSectionView.h
//  BiZhi
//
//  Created by Chobits on 2017/9/18.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRSectionViewUIService.h"
#import "CRSectionFlowLayout.h"
@class CRSectionView;

@protocol CRSectionViewDataSource <NSObject>

@required
- (__kindof CRSectionViewUIService *)sectionUIServiceInCRSectionView:(CRSectionView *)crSectionView;
@optional
- (__kindof CRSectionFlowLayout *)sectionFlowLayoutInCRSectionView:(CRSectionView *)crSectionView;
- (UIView *)indicatorLineViewInCRSectionView:(CRSectionView *)crSectionView;

@end

@protocol CRSectionViewDelegate <NSObject>

- (void)sectionView:(CRSectionView *)sectionView didScrollToIndexPath:(NSIndexPath *)indexPath;
- (void)sectionView:(CRSectionView *)sectionView willScrollToIndexPath:(NSIndexPath *)indexPath;

@end


@interface CRSectionView : UIView

@property (assign, nonatomic) CGSize itemSize;
@property (assign, nonatomic) CGSize sepLineSize;
@property (strong, nonatomic) UIColor *sepLineColor;
@property (assign, nonatomic) UIEdgeInsets edgeInset;
@property (assign, nonatomic) CGFloat gapX;
@property (assign, nonatomic) BOOL needSelectAutoScroll;

@property (weak, nonatomic) id <CRSectionViewDataSource> dataSource;
@property (weak, nonatomic) id <CRSectionViewDelegate> delegate;

@property (strong, nonatomic, readonly) UICollectionView *mainCollectionView;
@property (strong, nonatomic, readonly) CRSectionViewUIService *sectionUIService;

//Rewrite
- (void)initPara;
- (void)calculatePara;

//Func
- (void)reloadData;
- (void)scrollToIndexPath:(NSIndexPath *)indexPath animate:(BOOL)animate;

@end
