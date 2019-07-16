//
//  CRListViewController.m
//  CRBoxInputView
//
//  Created by BearRan on 01/03/2019.
//  Copyright (c) 2019 BearRan. All rights reserved.
//

#import "CRListViewController.h"
#import "CRDetailViewController.h"
#import "CRListVCCell.h"
#import "CRBoxInputModel.h"

@interface CRListViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_mainTableView;
    UILabel *_titleLabel;
    NSMutableArray *_dataArr;
}
@end

@implementation CRListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self generateDataArr];
    [self createUI];
}

- (void)generateDataArr
{
    _dataArr = [NSMutableArray new];
    CRBoxInputModel *model;
    
    model = [CRBoxInputModel new];
    model.name = @"Normal";
    model.imageName = @"demoImg_Normal";
    model.type = CRBoxInputModelNormalType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Placeholder";
    model.imageName = @"demoImg_Normal";
    model.type = CRBoxInputModelPlaceholderType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Custom Box";
    model.imageName = @"demoImg_CustomBox";
    model.type = CRBoxInputModelCustomBoxType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Line";
    model.imageName = @"demoImg_Line";
    model.type = CRBoxInputModelLineType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Secret Symbol";
    model.imageName = @"demoImg_SecretSymbol";
    model.type = CRBoxInputModelSecretSymbolType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Secret Image";
    model.imageName = @"demoImg_SecretImage";
    model.type = CRBoxInputModelSecretImageType;
    [_dataArr addObject:model];
    
    model = [CRBoxInputModel new];
    model.name = @"Secret View";
    model.imageName = @"demoImg_SecretView";
    model.type = CRBoxInputModelSecretViewType;
    [_dataArr addObject:model];
}

- (void)createUI
{
    _titleLabel = [UILabel new];
    _titleLabel.text = @"CRBoxInputView";
    _titleLabel.textColor = color_master;
    _titleLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(YY_6(30) + STATUS_HEIGHT);
        make.left.offset(XX_6(35));
    }];
    
    _mainTableView = [UITableView new];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_titleLabel.mas_bottom).offset(YY_6(22));
        make.left.right.bottom.offset(0);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YY_6(157);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    CRListVCCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[CRListVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CRBoxInputModel *model = _dataArr[indexPath.row];
    [cell loadDataWithModel:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputModel *model = _dataArr[indexPath.row];
    CRDetailViewController *destinationVC = [CRDetailViewController new];
    destinationVC.boxInputModel = model;
    [self.navigationController pushViewController:destinationVC animated:YES];
}

@end
