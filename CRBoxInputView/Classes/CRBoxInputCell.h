//
//  CRBoxInputCell.h
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBoxInputCellProperty.h"

NS_ASSUME_NONNULL_BEGIN

#define CRBoxCursoryAnimationKey @"CRBoxCursoryAnimationKey"
#define CRBoxInputCellID @"CRBoxInputCellID"

@interface CRBoxInputCell : UICollectionViewCell

// 光标
@property (strong, nonatomic) UIView *cursorView;
@property (assign, nonatomic) BOOL ifNeedCursor;

@property (strong, nonatomic) CRBoxInputCellProperty *boxInputCellProperty;

- (void)quickSetOriginValue:(NSString *)originValue;

// 待重写
- (void)valueLabelLoadData;

@end

NS_ASSUME_NONNULL_END
