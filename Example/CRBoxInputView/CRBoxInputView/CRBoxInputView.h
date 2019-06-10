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

/**
 textContentType
 desc: You set this 'nil' or 'UITextContentTypeOneTimeCode' to auto fill verify code.
 default: nil
 */
@property (null_unspecified,nonatomic,copy) UITextContentType textContentType NS_AVAILABLE_IOS(10_0);

@property (copy, nonatomic) TextDidChangeblock _Nullable textDidChangeblock;
@property (strong, nonatomic) CRBoxFlowLayout * _Nullable boxFlowLayout;
@property (strong, nonatomic) CRBoxInputCellProperty * _Nullable customCellProperty;
@property (strong, nonatomic, readonly) NSString  * _Nullable textValue;

// loadAndPrepareView is default beginEdit to YES.
- (void)loadAndPrepareView;
- (void)loadAndPrepareViewWithBeginEdit:(BOOL)beginEdit;

// clearAll is default beginEdit to YES.
- (void)clearAll;
- (void)clearAllWithBeginEdit:(BOOL)beginEdit;

- (UICollectionView *_Nullable)mainCollectionView;

// Qiuck set
- (void)quickSetSecuritySymbol:(NSString *_Nullable)securitySymbol;

// You can inherit and call super
- (void)initDefaultValue;

// You can inherit and rewrite
- (UICollectionViewCell *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *_Nullable)indexPath;

@end
