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

@interface CRBoxInputView : UIView

/**
 是否需要光标
 default: YES
 */
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
 验证码的长度
 default: 4
 */
@property (nonatomic, assign) NSInteger codeLength;

/**
 是否启用*号
 default: NO
 */
@property (assign, nonatomic) BOOL ifNeedSecurity;

/**
 *号延时时间
 default: 0.3
 */
@property (assign, nonatomic) CGFloat securityDelay;

@property (assign, nonatomic) UIKeyboardType keyBoardType;
@property (copy, nonatomic) TextDidChangeblock textDidChangeblock;
@property (strong, nonatomic) CRBoxFlowLayout *boxFlowLayout;
@property (strong, nonatomic) CRBoxInputCellProperty *boxInputCellProperty;

-(void)loadAndPrepareView;
-(void)clearAll;

@end
