//
//  CRDetailViewController.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRDetailViewController.h"

@interface CRDetailViewController ()
{
    UIButton *_backBtn;
    UIImageView *_bigLockImageView;
    UILabel *_mainLabel;
    UILabel *_subLabel;
    UIView *_sepLineView;
    UILabel *_descriptionLabel;
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
    static CGFloat offXStart = 35;
    
    _backBtn = [UIButton new];
    [_backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offXStart);
        make.top.offset(36);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(22);
    }];
    
    _bigLockImageView = [UIImageView new];
    _bigLockImageView.image = [UIImage imageNamed:@"BigLock"];
    [self.view addSubview:_bigLockImageView];
    [_bigLockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.right.offset(0);
        make.width.mas_equalTo(154);
        make.height.mas_equalTo(230);
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
        make.width.mas_equalTo(166);
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
        make.width.mas_equalTo(303);
        make.centerX.offset(0);
        make.top.equalTo(self->_subLabel.mas_bottom).offset(24);
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
}

@end
