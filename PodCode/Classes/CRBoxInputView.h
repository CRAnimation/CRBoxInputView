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
#import "CRBoxTextView.h"

@class CRBoxInputView;

typedef void(^TextDidChangeblock)(NSString * _Nullable text, BOOL isFinished);

@interface CRBoxInputView : UIView

/**
 是否需要光标
 ifNeedCursor
 default: YES
 */
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
 验证码长度
 codeLength
 default: 4
 */
@property (nonatomic, assign) NSInteger codeLength;

/**
 是否开启密文模式
 ifNeedSecurity
 default: NO
 */
@property (assign, nonatomic) BOOL ifNeedSecurity;

/**
 显示密文的延时时间
 securityDelay
 desc: show security delay time
 default: 0.3
 */
@property (assign, nonatomic) CGFloat securityDelay;

/**
 键盘类型
 keyBoardType
 default: UIKeyboardTypeNumberPad
 */
@property (assign, nonatomic) UIKeyboardType keyBoardType;

/**
 textContentType
 描述: 你可以设置为 'nil' 或者 'UITextContentTypeOneTimeCode' 来自动获取短信验证码
 desc: You set this 'nil' or 'UITextContentTypeOneTimeCode' to auto fill verify code.
 default: nil
 */
@property (null_unspecified,nonatomic,copy) UITextContentType textContentType NS_AVAILABLE_IOS(10_0);

@property (nonatomic, strong) CRBoxTextView *textView;
@property (copy, nonatomic) TextDidChangeblock _Nullable textDidChangeblock;
@property (strong, nonatomic) CRBoxFlowLayout * _Nullable boxFlowLayout;
@property (strong, nonatomic) CRBoxInputCellProperty * _Nullable customCellProperty;
@property (strong, nonatomic, readonly) NSString  * _Nullable textValue;

/**
 装载数据和准备界面
 desc: Load and prepareView
 beginEdit: 自动开启编辑模式
 default: YES
 */
- (void)loadAndPrepareView;
- (void)loadAndPrepareViewWithBeginEdit:(BOOL)beginEdit;

/**
 清空输入
 desc: Clear all
 beginEdit: 自动开启编辑模式
 default: YES
 */
- (void)clearAll;
- (void)clearAllWithBeginEdit:(BOOL)beginEdit;

- (UICollectionView *_Nullable)mainCollectionView;

// 快速设置
// Qiuck set
- (void)quickSetSecuritySymbol:(NSString *_Nullable)securitySymbol;

// 你可以在继承的子类中调用父类方法
// You can inherit and call super
- (void)initDefaultValue;

// 你可以在继承的子类中重写父类方法
// You can inherit and rewrite
- (UICollectionViewCell *_Nullable)customCollectionView:(UICollectionView *_Nullable)collectionView cellForItemAtIndexPath:(NSIndexPath *_Nullable)indexPath;

@end
