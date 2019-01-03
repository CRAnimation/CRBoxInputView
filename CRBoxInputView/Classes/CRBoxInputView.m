//
//  CRBoxInputView.m
//  CRBoxInputView
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import "CRBoxInputView.h"
#import "Masonry.h"
#import "CRBoxInputCell.h"

@interface CRBoxInputView () <UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    
}

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSMutableArray *valueArr;

@end

@implementation CRBoxInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultValue];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefaultValue];
    }
    
    return self;
}

-(void)initDefaultValue{
    //初始化默认值
    self.codeLength = 4;
    self.ifNeedCursor = YES;
    self.backgroundColor = [UIColor clearColor];
    _valueArr = [NSMutableArray new];
    [self beginEdit];
}

-(void)loadAndPrepareView{
    
    if (_codeLength<=0) {
        NSAssert(NO, @"请输入大于0的验证码位数");
        return;
    }
    
    [self addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    //添加textView
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - TextViewEdit
-(void)beginEdit{
    [self.textView becomeFirstResponder];
}

-(void)endEdit{
    [self.textView resignFirstResponder];
}

-(void)clearAll{
    self.textView.text = @"";
    [self textViewDidChange:self.textView];
    [self beginEdit];
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    
    NSString *verStr = textView.text;
    
    //有空格去掉空格
    verStr = [verStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (verStr.length >= _codeLength) {
        verStr = [verStr substringToIndex:_codeLength];
        [self endEdit];
    }
    textView.text = verStr;
    
    // _valueArr
    [_valueArr removeAllObjects];
    [verStr enumerateSubstringsInRange:NSMakeRange(0, verStr.length) options:(NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [self->_valueArr addObject:substring];
    }];
    [_mainCollectionView reloadData];
    
    if (self.textDidChangeblock) {
        BOOL isFinished = _valueArr.count == _codeLength ? YES : NO;
        self.textDidChangeblock(verStr, isFinished);
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _codeLength;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRBoxInputCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputCellID forIndexPath:indexPath];
    
    if (_boxInputCellProperty) {
        cell.boxInputCellProperty = _boxInputCellProperty;
    }
    cell.ifNeedCursor = self.ifNeedCursor;
    
    NSUInteger focusIndex = _valueArr.count;
    cell.selected = indexPath.row == focusIndex ? YES : NO;
    if (_valueArr.count > 0 && indexPath.row <= focusIndex - 1) {
        cell.valueLabel.text = _valueArr[indexPath.row];
    }else{
        cell.valueLabel.text = @"";
    }
    
    return cell;
}

#pragma mark - Setter & Getter
-(UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.boxFlowLayout];
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        [_mainCollectionView registerClass:[CRBoxInputCell class] forCellWithReuseIdentifier:CRBoxInputCellID];
    }
    
    return _mainCollectionView;
}

-(CRBoxFlowLayout *)boxFlowLayout
{
    if (!_boxFlowLayout) {
        _boxFlowLayout = [CRBoxFlowLayout new];
        _boxFlowLayout.itemSize = CGSizeMake(42, 47);
    }
    
    return _boxFlowLayout;
}

- (void)setCodeLength:(NSInteger)codeLength
{
    _codeLength = codeLength;
    self.boxFlowLayout.itemNum = codeLength;
}

-(void)setKeyBoardType:(UIKeyboardType)keyBoardType{
    _keyBoardType = keyBoardType;
    self.textView.keyboardType = keyBoardType;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.tintColor = [UIColor clearColor];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor clearColor];
        _textView.delegate = self;
        _textView.keyboardType = UIKeyboardTypeDefault;
//        [_textView canPerformAction:<#(nonnull SEL)#> withSender:<#(nullable id)#>]
    }
    return _textView;
}

@end
