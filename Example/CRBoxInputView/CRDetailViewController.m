//
//  CRDetailViewController.m
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import "CRDetailViewController.h"
#import "CRBoxInputView.h"
#import "CRLineView.h"
#import "CRSecrectImageView.h"


#import "CRBoxInputView_CustomBox.h"
#import "CRBoxInputView_Line.h"

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

@property (strong, nonatomic) UILabel   *valueLabel;

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
    _descriptionLabel.text = @"The verification code you have input is";
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_descriptionLabel];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XX_6(303));
        make.centerX.offset(0);
        make.top.equalTo(self->_subLabel.mas_bottom).offset(YY_6(24));
    }];
    
    _valueLabel = [UILabel new];
    _valueLabel.textColor = color_master;
    _valueLabel.font = [UIFont boldSystemFontOfSize:24];
    _valueLabel.text = @"Empty";
    [self.view addSubview:_valueLabel];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self->_descriptionLabel.mas_bottom).offset(3);
    }];
    
    CGFloat btnHeight = YY_6(54);
    _verifyBtn = [UIButton new];
    _verifyBtn.layer.cornerRadius = btnHeight / 2.0;
    _verifyBtn.backgroundColor = color_master;
    [_verifyBtn setTitle:@"Clear" forState:UIControlStateNormal];
    [_verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_verifyBtn addTarget:self action:@selector(clearBtnEvent) forControlEvents:UIControlEventTouchUpInside];
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
            
        case CRBoxInputModelLineType:
            {
                _boxInputView = [self generateBoxInputView_line];
            }
            break;
            
        case CRBoxInputModelSecretSymbolType:
            {
                _boxInputView = [self generateBoxInputView_secretSymbol];
            }
            break;
            
        case CRBoxInputModelSecretImageType:
            {
                _boxInputView = [self generateBoxInputView_secretImage];
            }
            break;
            
        case CRBoxInputModelSecretViewType:
            {
                _boxInputView = [self generateBoxInputView_secretView];
            }
            break;
            
        default:
            {
                _boxInputView = [self generateBoxInputView_normal];
            }
            break;
    }
    
    __weak typeof(self) weakSelf = self;
    _boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        if (text.length > 0) {
            weakSelf.valueLabel.text = text;
        }else{
            weakSelf.valueLabel.text = @"Empty";
        }
    };
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

#pragma mark - Normal
- (CRBoxInputView *)generateBoxInputView_normal
{
    CRBoxInputView *_boxInputView = [CRBoxInputView new];
    [_boxInputView loadAndPrepareView];
    
    if (@available(iOS 12.0, *)) {
        _boxInputView.textContentType = UITextContentTypeOneTimeCode;
    }else if (@available(iOS 10.0, *)) {
        _boxInputView.textContentType = @"one-time-code";
    }
    
    return _boxInputView;
}

#pragma mark - CustomBox
//- (CRBoxInputView *)generateBoxInputView_customBox
//{
//    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
//    cellProperty.cellBgColorNormal = color_FFECEC;
//    cellProperty.cellBgColorSelected = [UIColor whiteColor];
//    cellProperty.cellCursorColor = color_master;
//    cellProperty.cellCursorWidth = 2;
//    cellProperty.cellCursorHeight = YY_6(27);
//    cellProperty.cornerRadius = 4;
//    cellProperty.borderWidth = 0;
//    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
//    cellProperty.cellTextColor = color_master;
//    cellProperty.configCellShadowBlock = ^(CALayer * _Nonnull layer) {
//        layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
//        layer.shadowOpacity = 1;
//        layer.shadowOffset = CGSizeMake(0, 2);
//        layer.shadowRadius = 4;
//    };
//
//    CRBoxInputView *_boxInputView = [CRBoxInputView new];
//    _boxInputView.boxFlowLayout.itemSize = CGSizeMake(XX_6(52), XX_6(52));
//    _boxInputView.customCellProperty = cellProperty;
//    [_boxInputView loadAndPrepareView];
//
//    return _boxInputView;
//}

// early
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
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
//    cellProperty.configCellShadowBlock = ^(CALayer * _Nonnull layer) {
//        layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
//        layer.shadowOpacity = 1;
//        layer.shadowOffset = CGSizeMake(0, 2);
//        layer.shadowRadius = 4;
//    };
    
    CRBoxInputView_CustomBox *_boxInputView = [CRBoxInputView_CustomBox new];
    _boxInputView.boxFlowLayout.itemSize = CGSizeMake(XX_6(52), XX_6(52));
    _boxInputView.customCellProperty = cellProperty;
    [_boxInputView loadAndPrepareView];
    
    return _boxInputView;
}

#pragma mark - Line
//- (CRBoxInputView *)generateBoxInputView_line
//{
//    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
//    cellProperty.cellCursorColor = color_FFECEC;
//    cellProperty.cellCursorWidth = 2;
//    cellProperty.cellCursorHeight = YY_6(27);
//    cellProperty.cornerRadius = 0;
//    cellProperty.borderWidth = 0;
//    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
//    cellProperty.cellTextColor = color_master;
//    cellProperty.showLine = YES;
//    cellProperty.customLineViewBlock = ^CRLineView * _Nonnull{
//        CRLineView *lineView = [CRLineView new];
//        lineView.lineView.backgroundColor = color_master;
//        [lineView.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(4);
//            make.left.right.bottom.offset(0);
//        }];
//
//        return lineView;
//    };
//
//    CRBoxInputView *_boxInputView = [CRBoxInputView new];
//    _boxInputView.boxFlowLayout.itemSize = CGSizeMake(XX_6(52), XX_6(52));
//    _boxInputView.customCellProperty = cellProperty;
//    [_boxInputView loadAndPrepareViewWithBeginEdit:NO];
//
//    return _boxInputView;
//}

- (CRBoxInputView_Line *)generateBoxInputView_line
{
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellCursorColor = color_FFECEC;
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = YY_6(27);
    cellProperty.cornerRadius = 0;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
//    cellProperty.showLine = YES;
//    cellProperty.customLineViewBlock = ^CRLineView * _Nonnull{
//        CRLineView *lineView = [CRLineView new];
//        lineView.lineView.backgroundColor = color_master;
//        [lineView.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(4);
//            make.left.right.bottom.offset(0);
//        }];
//
//        return lineView;
//    };
    
    CRBoxInputView_Line *_boxInputView = [CRBoxInputView_Line new];
    _boxInputView.boxFlowLayout.itemSize = CGSizeMake(XX_6(52), XX_6(52));
    _boxInputView.customCellProperty = cellProperty;
    [_boxInputView loadAndPrepareViewWithBeginEdit:NO];
    
    return _boxInputView;
}

#pragma mark - SecretSymbol
- (CRBoxInputView *)generateBoxInputView_secretSymbol
{
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellCursorColor = color_FFECEC;
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = YY_6(27);
    cellProperty.cornerRadius = 0;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
    cellProperty.showLine = YES;
    cellProperty.securitySymbol = @"*";//need
    
    CRBoxInputView *_boxInputView = [CRBoxInputView new];
    _boxInputView.ifNeedSecurity = YES;//need
    _boxInputView.boxFlowLayout.itemSize = CGSizeMake(XX_6(52), XX_6(52));
    _boxInputView.customCellProperty = cellProperty;
    [_boxInputView loadAndPrepareView];
    
    return _boxInputView;
}

#pragma mark - SecretImage
- (CRBoxInputView *)generateBoxInputView_secretImage
{
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellCursorColor = color_FFECEC;
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = YY_6(27);
    cellProperty.cornerRadius = 0;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
    cellProperty.showLine = YES;
    cellProperty.securityType = CRBoxSecurityCustomViewType;//need
    cellProperty.customSecurityViewBlock = ^UIView * _Nonnull{
        CRSecrectImageView *secrectImageView = [CRSecrectImageView new];
        secrectImageView.image = [UIImage imageNamed:@"smallLock"];
        secrectImageView.imageWidth = 23;
        secrectImageView.imageHeight = 27;
        return secrectImageView;
    };
    
    CRBoxInputView *_boxInputView = [CRBoxInputView new];
    _boxInputView.ifNeedSecurity = YES;//need
    _boxInputView.boxFlowLayout.itemSize = CGSizeMake(XX_6(52), XX_6(52));
    _boxInputView.customCellProperty = cellProperty;
    [_boxInputView loadAndPrepareView];
    
    return _boxInputView;
}

#pragma mark - SecretView
- (CRBoxInputView *)generateBoxInputView_secretView
{
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellCursorColor = color_FFECEC;
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = YY_6(27);
    cellProperty.cornerRadius = 0;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
    cellProperty.showLine = YES;
    cellProperty.securityType = CRBoxSecurityCustomViewType;//need
    cellProperty.customSecurityViewBlock = ^UIView * _Nonnull{
        UIView *customSecurityView = [UIView new];
        customSecurityView.backgroundColor = [UIColor clearColor];
        
        // circleView
        static CGFloat circleViewWidth = 20;
        UIView *circleView = [UIView new];
        circleView.backgroundColor = color_master;
        circleView.layer.cornerRadius = 4;
        [customSecurityView addSubview:circleView];
        [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(circleViewWidth);
            make.centerX.offset(0);
            make.centerY.offset(0);
        }];
        
        return customSecurityView;
    };
    
    CRBoxInputView *_boxInputView = [CRBoxInputView new];
    _boxInputView.ifNeedSecurity = YES;//need
    _boxInputView.boxFlowLayout.itemSize = CGSizeMake(XX_6(52), XX_6(52));
    _boxInputView.customCellProperty = cellProperty;
    [_boxInputView loadAndPrepareView];
    
    return _boxInputView;
}

#pragma mark - BtnEvent
- (void)clearBtnEvent
{
    [_boxInputView clearAll];
}

@end
