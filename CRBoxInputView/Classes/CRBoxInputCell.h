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

@property (strong, nonatomic) UILabel *valueLabel;
@property (strong, nonatomic) UIView *cursorView; // 光标
@property (assign, nonatomic) BOOL ifNeedCursor; // 是否需要光标
@property (strong, nonatomic) CABasicAnimation *opacityAnimation;

@property (strong, nonatomic) CRBoxInputCellProperty *boxInputCellProperty;

@end

NS_ASSUME_NONNULL_END
