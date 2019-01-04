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

// cursor
@property (strong, nonatomic) UIView *cursorView;
@property (assign, nonatomic) BOOL ifNeedCursor;

@property (strong, nonatomic) CRBoxInputCellProperty *boxInputCellProperty;

// You can rewrite
- (void)valueLabelLoadData;

// Qiuck set
- (void)quickSetOriginValue:(NSString *)originValue;

@end

NS_ASSUME_NONNULL_END
