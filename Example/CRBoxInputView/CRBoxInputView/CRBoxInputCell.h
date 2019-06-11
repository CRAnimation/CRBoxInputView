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

/**
 cursor
 You should not use these properties, unless you know what you are doing.
 */
@property (strong, nonatomic) UIView *cursorView;
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
 boxInputCellProperty
 You should not use these properties, unless you know what you are doing.
 */
@property (strong, nonatomic) CRBoxInputCellProperty *boxInputCellProperty;

// 你可以在继承的子类中重写父类方法
// You can inherit and rewrite
- (UIView *)createCustomSecurityView __deprecated_msg("Please use `customSecurityViewBlock` in CRBoxInputCellProperty.");

@end

NS_ASSUME_NONNULL_END
