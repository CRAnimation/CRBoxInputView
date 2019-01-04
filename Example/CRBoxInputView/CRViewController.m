//
//  CRViewController.m
//  CRBoxInputView
//
//  Created by BearRan on 01/03/2019.
//  Copyright (c) 2019 BearRan. All rights reserved.
//

#import "CRViewController.h"
#import "Masonry.h"
#import "CRBoxInputView.h"

#define CRBOX_UIColorFromHEX(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CRViewController ()
{
    CRBoxInputView *_boxInputView;
}
@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self createUI];
}

- (void)createUI
{
    CGFloat offX = 30;
    
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellBgColor = [UIColor clearColor];
    cellProperty.cellBorderColorSelected = CRBOX_UIColorFromHEX(0x979797);
    cellProperty.cellCursorColor = CRBOX_UIColorFromHEX(0x979797);
    cellProperty.cornerRadius = 0;
    cellProperty.securityType = CRBoxSecurityType_CustomView;
    
    _boxInputView = [CRBoxInputView new];
    [self.view addSubview:_boxInputView];
    _boxInputView.codeLength = 6;
    _boxInputView.ifNeedCursor = YES;
    _boxInputView.keyBoardType = UIKeyboardTypeNumberPad;
    _boxInputView.ifNeedSecurity = YES;
    _boxInputView.customCellProperty = cellProperty;
    _boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        if (isFinished) {
            NSLog(@"--text:%@", text);
        }
    };
    [_boxInputView loadAndPrepareView];
    [_boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        make.centerY.offset(0);
        make.height.mas_equalTo(47);
    }];
    
    UIButton *clearBtn = [UIButton new];
    [clearBtn addTarget:self action:@selector(clearBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.width.height.mas_equalTo(100);
        make.centerX.offset(0);
    }];
}

- (void)clearBtnEvent
{
    [_boxInputView clearAll];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
