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
@class CRBoxInputView;

typedef void(^TextDidChangeblock)(NSString *text, BOOL isFinished);

@protocol CRBoxInputViewDelegate <NSObject>

- (UIView *)cellCustomSecurityViewAtIndex:(NSInteger)index;

@end

@interface CRBoxInputView : UIView

/**
 是否需要光标
 *default: YES
 */
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
 验证码的长度
 default: 4
 */
@property (nonatomic, assign) NSInteger codeLength;

/**
 是否启用密码模式
 default: NO
 */
@property (assign, nonatomic) BOOL ifNeedSecurity;

/**
 密码模式延时时间
 default: 0.3
 */
@property (assign, nonatomic) CGFloat securityDelay;

@property (assign, nonatomic) UIKeyboardType keyBoardType;
@property (copy, nonatomic) TextDidChangeblock textDidChangeblock;
@property (strong, nonatomic) CRBoxFlowLayout *boxFlowLayout;
@property (strong, nonatomic) CRBoxInputCellProperty *customCellProperty;
@property (weak, nonatomic) id <CRBoxInputViewDelegate> delegate;

- (void)loadAndPrepareView;
- (void)clearAll;

// Qiuck set
- (void)quickSetSecuritySymbol:(NSString *)securitySymbol;

@end
