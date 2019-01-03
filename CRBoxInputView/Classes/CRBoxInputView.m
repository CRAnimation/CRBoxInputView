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
#import "CRBoxTextView.h"

typedef NS_ENUM(NSInteger, CRBoxTextChangeType) {
    CRBoxTextChangeType_NoChange,
    CRBoxTextChangeType_Insert,
    CRBoxTextChangeType_Delete,
};

@interface CRBoxInputView () <UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSInteger _oldLength;
}

@property (nonatomic, strong) CRBoxTextView *textView;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSMutableArray <NSString *> *valueArr;

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
    _oldLength = 0;
    self.securityDelay = 0.3;
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
    _oldLength = 0;
    [_valueArr removeAllObjects];
    self.textView.text = @"";
    [self.mainCollectionView reloadData];
    [self triggerBlock];
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
    
    // 判断删除/增加
    CRBoxTextChangeType boxTextChangeType = CRBoxTextChangeType_NoChange;
    if (verStr.length > _oldLength) {
        boxTextChangeType = CRBoxTextChangeType_Insert;
    }else if (verStr.length < _oldLength){
        boxTextChangeType = CRBoxTextChangeType_Delete;
    }
    
    // _valueArr
    if (boxTextChangeType == CRBoxTextChangeType_Delete) {
        [_valueArr removeLastObject];
    }else if (boxTextChangeType == CRBoxTextChangeType_Insert){
        if (verStr.length > 0) {
            if (_valueArr.count > 0) {
                [self replaceValueArrToAsteriskWithIndex:_valueArr.count - 1 needEqualToCount:NO];
            }
            NSString *subStr = [verStr substringWithRange:NSMakeRange(verStr.length - 1, 1)];
            [self->_valueArr addObject:subStr];
            [self delayAsteriskProcess];
        }
    }
    [_mainCollectionView reloadData];
    
    [self triggerBlock];
    _oldLength = verStr.length;
}

- (void)triggerBlock
{
    if (self.textDidChangeblock) {
        BOOL isFinished = _valueArr.count == _codeLength ? YES : NO;
        self.textDidChangeblock(_textView.text, isFinished);
    }
}

#pragma mark - Asterisk
// 替换*
- (void)replaceValueArrToAsteriskWithIndex:(NSInteger)index needEqualToCount:(BOOL)needEqualToCount
{
    if (needEqualToCount && index != _valueArr.count - 1) {
        return;
    }
    
    if (_valueArr.count > index && ![_valueArr[index] isEqualToString:@"✱"]) {
        [_valueArr replaceObjectAtIndex:index withObject:@"✱"];
    }
}

// 延时替换*
- (void)delayAsteriskProcess
{
    __weak typeof(self) weakSelf = self;
    [self delayAfter:_securityDelay dealBlock:^{
        if (self->_valueArr.count > 0) {
            [weakSelf replaceValueArrToAsteriskWithIndex:self->_valueArr.count-1 needEqualToCount:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_mainCollectionView reloadData];
            });
        }
    }];
}

#pragma mark - DelayBlock
- (void)delayAfter:(CGFloat)delayTime dealBlock:(void (^)(void))dealBlock
{
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime *NSEC_PER_SEC));
    dispatch_after(timer, dispatch_get_main_queue(), ^{
        if (dealBlock) {
            dealBlock();
        }
    });
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

-(CRBoxTextView *)textView{
    if (!_textView) {
        _textView = [CRBoxTextView new];
        _textView.tintColor = [UIColor clearColor];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor clearColor];
        _textView.delegate = self;
        _textView.keyboardType = UIKeyboardTypeDefault;
    }
    return _textView;
}

@end
