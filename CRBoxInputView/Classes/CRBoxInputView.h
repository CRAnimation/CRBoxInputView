//
//  CRBoxInputView.h
//  CRBoxInputView
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBoxFlowLayout.h"
#import "CRBoxInputCellProperty.h"
#import "CRBoxInputCell.h"
@class CRBoxInputView;

typedef void(^TextDidChangeblock)(NSString *text, BOOL isFinished);

@interface CRBoxInputView : UIView

/**
 ifNeedCursor
 *default: YES
 */
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
 codeLength
 default: 4
 */
@property (nonatomic, assign) NSInteger codeLength;

/**
 ifNeedSecurity
 default: NO
 */
@property (assign, nonatomic) BOOL ifNeedSecurity;

/**
 show security delay time
 default: 0.3
 */
@property (assign, nonatomic) CGFloat securityDelay;

/**
 keyBoardType
 default: UIKeyboardTypeNumberPad
 */
@property (assign, nonatomic) UIKeyboardType keyBoardType;

@property (copy, nonatomic) TextDidChangeblock textDidChangeblock;
@property (strong, nonatomic) CRBoxFlowLayout *boxFlowLayout;
@property (strong, nonatomic) CRBoxInputCellProperty *customCellProperty;
@property (strong, nonatomic, readonly) NSString  *textValue;
@property (null_unspecified,nonatomic,copy) UITextContentType textContentType NS_AVAILABLE_IOS(10_0); // default is nil

- (void)loadAndPrepareView;
- (void)clearAll;
- (UICollectionView *)mainCollectionView;

// Qiuck set
- (void)quickSetSecuritySymbol:(NSString *)securitySymbol;

// You can inherit and call super
- (void)initDefaultValue;

// You can inherit and rewrite
- (UICollectionViewCell *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
