//
//  CRDetailViewController.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRDetailViewController.h"
#import "CRBoxInputView.h"
#import "CRBoxInputView_CustomBox.h"

@interface CRDetailViewController ()
{
    UIButton *_backBtn;
    UIImageView *_bigLockImageView;
    UILabel *_mainLabel;
    UILabel *_subLabel;
    UIView *_sepLineView;
    UILabel *_descriptionLabel;
    
    CRBoxInputView *_boxInputView;
    UIButton *_verifyBtn;
}
@end

@implementation CRDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createUI
{
    CGFloat offXStart = XX_6(35);
    
    _backBtn = [UIButton new];
    [_backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offXStart);
        make.top.offset(YY_6(16) + STATUS_HEIGHT);
        make.width.mas_equalTo(XX_6(24));
        make.height.mas_equalTo(XX_6(22));
    }];
    
    _bigLockImageView = [UIImageView new];
    _bigLockImageView.image = [UIImage imageNamed:@"BigLock"];
    [self.view addSubview:_bigLockImageView];
    [_bigLockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.right.offset(0);
        make.width.mas_equalTo(XX_6(154));
        make.height.mas_equalTo(XX_6(230));
    }];
    
    _mainLabel = [UILabel new];
    _mainLabel.textColor = color_master;
    _mainLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_mainLabel];
    [_mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offXStart);
        make.top.equalTo(self->_backBtn.mas_bottom).offset(13);
    }];
    
    _sepLineView = [UIView new];
    _sepLineView.backgroundColor = color_master;
    [self.view addSubview:_sepLineView];
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offXStart);
        make.top.equalTo(self->_mainLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(XX_6(166));
        make.height.mas_equalTo(2);
    }];

    _subLabel = [UILabel new];
    _subLabel.text = @"CRBoxInputView";
    _subLabel.textColor = color_master;
    _subLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:_subLabel];
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offXStart);
        make.top.equalTo(self->_sepLineView.mas_bottom).offset(2);
    }];

    _descriptionLabel = [UILabel new];
    _descriptionLabel.textColor = color_master;
    _descriptionLabel.font = [UIFont boldSystemFontOfSize:16];
    _descriptionLabel.text = @"Please enter the verification code we sent to your email address";
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_descriptionLabel];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XX_6(303));
        make.centerX.offset(0);
        make.top.equalTo(self->_subLabel.mas_bottom).offset(YY_6(24));
    }];
    
    CGFloat btnHeight = YY_6(54);
    _verifyBtn = [UIButton new];
    _verifyBtn.layer.cornerRadius = btnHeight / 2.0;
    _verifyBtn.backgroundColor = color_master;
    [_verifyBtn setTitle:@"Verify" forState:UIControlStateNormal];
    [_verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _verifyBtn.titleLabel.font = FontSize_6(21);
    [self.view addSubview:_verifyBtn];
    [_verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XX_6(297));
        make.height.mas_equalTo(btnHeight);
        make.centerX.offset(0);
    }];
}

- (void)backBtnEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Setter & Getter
- (void)setBoxInputModel:(CRBoxInputModel *)boxInputModel
{
    _boxInputModel = boxInputModel;
    
    _mainLabel.text = boxInputModel.name;
    
    switch (boxInputModel.type) {
        case CRBoxInputModelNormalType:
            {
                _boxInputView = [self generateBoxInputView_normal];
            }
            break;
            
        case CRBoxInputModelCustomBoxType:
            {
                _boxInputView = [self generateBoxInputView_customBox];
            }
            break;
            
        default:
            {
                _boxInputView = [self generateBoxInputView_normal];
            }
            break;
    }
    [self.view addSubview:_boxInputView];
    [_boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XX_6(262));
        make.height.mas_equalTo(YY_6(52));
        make.centerX.offset(0);
        make.top.equalTo(self->_bigLockImageView.mas_bottom).offset(YY_6(18));
    }];
    
    [_verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_boxInputView.mas_bottom).offset(YY_6(46));
    }];
}

- (CRBoxInputView *)generateBoxInputView_normal
{
    CRBoxInputView *_boxInputView = [CRBoxInputView new];
    [_boxInputView loadAndPrepareView];
    
    return _boxInputView;
}

- (CRBoxInputView_CustomBox *)generateBoxInputView_customBox
{
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellBgColorNormal = color_FFECEC;
    cellProperty.cellBgColorSelected = [UIColor whiteColor];
    cellProperty.cellCursorColor = color_master;
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = YY_6(27);
    cellProperty.cornerRadius = 4;
    cellProperty.borderWidth = 0;
    
    CRBoxInputView_CustomBox *_boxInputView = [CRBoxInputView_CustomBox new];
    _boxInputView.boxFlowLayout.itemSize = CGSizeMake(XX_6(52), XX_6(52));
    _boxInputView.customCellProperty = cellProperty;
    [_boxInputView loadAndPrepareView];
    
    return _boxInputView;
}

@end
