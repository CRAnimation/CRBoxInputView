<a id="Header_Start"></a> ![CRBoxInputViewHeadImg.png](/ReadmeResources/HeadImg.png "CRBoxInputViewHeadImg.png")
[![CI Status](https://img.shields.io/travis/CRAnimation/CRBoxInputView.svg?style=flat)](https://travis-ci.org/CRAnimation/CRBoxInputView)
[![Version](https://img.shields.io/cocoapods/v/CRBoxInputView.svg?style=flat)](https://cocoapods.org/pods/CRBoxInputView)
[![License](https://img.shields.io/cocoapods/l/CRBoxInputView.svg?style=flat)](https://cocoapods.org/pods/CRBoxInputView)
[![Platform](https://img.shields.io/cocoapods/p/CRBoxInputView.svg?style=flat)](https://cocoapods.org/pods/CRBoxInputView)

> You can use this widget for verify code, password input or phone number input. It support verify code auto fill in iOS12.<br/>I hope you can like this!

### [中文文档](https://github.com/CRAnimation/CRBoxInputView#Header_Start) [/ English](https://github.com/CRAnimation/CRBoxInputView/blob/master/README_en.md#Header_Start)

## Installation

CRBoxInputView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CRBoxInputView'
```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
![iPhone 8 Copy 2.png](/ReadmeResources/ScreenShoot1.png "iPhone 8 Copy 2.png")


## Quick Guide
| Type  | Image |
| :-------------: | :-------------: |
| [Base](#Anchor_Base) | ![Normal.png](/ReadmeResources/1Normal.png "Normal.png")  |
| [CustomBox](#Anchor_CustomBox)  | ![CustomBox.png](/ReadmeResources/2CustomBox.png "CustomBox.png")  |
| [Line](#Anchor_Line)  | ![Line.png](/ReadmeResources/3Line.png "Line.png")  |
| [SecretSymbol](#Anchor_SecretSymbol)  | ![SecretSymbol.png](/ReadmeResources/4SecretSymbol.png "SecretSymbol.png")  |
| [SecretImage](#Anchor_SecretImage)  | ![SecretImage.png](/ReadmeResources/5SecretImage.png "SecretImage.png")  |
| [SecretView](#Anchor_SecretView)  | ![SecretView.png](/ReadmeResources/6SecretView.png "SecretView.png") |

## Usage

### <a id="Anchor_Base"></a>Base

![Normal.png](/ReadmeResources/1Normal.png "Normal.png")

Insert code where you need.
``` objc
CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
[boxInputView loadAndPrepareView];
[self.view addSubview:boxInputView];
```


<br/>

### <a id="Anchor_CustomBox"></a>CustomBox
![CustomBox.png](/ReadmeResources/2CustomBox.png "CustomBox.png")
#### Step1:
Create custom class [reference here.](#Create_custom_class)
#### Step2:
modify **CRBoxInputCell_Custom** class inherit from `CRBoxInputCell`.m file
``` objc
- (instancetype)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];

if (self) {
self.layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
self.layer.shadowOpacity = 1;
self.layer.shadowOffset = CGSizeMake(0, 2);
self.layer.shadowRadius = 4;
}

return self;
}
```
#### Step3:
Insert code where you need.
``` objc
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

CRBoxInputView_Custom *boxInputView = [[CRBoxInputView_Custom alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
boxInputView.boxFlowLayout.itemSize = CGSizeMake(50, 50);
boxInputView.customCellProperty = cellProperty;
[boxInputView loadAndPrepareView];
```


<br/>

### <a id="Anchor_Line"></a>Line
![Line.png](/ReadmeResources/3Line.png "Line.png")
#### Step1:
Create custom class [reference here.](#Create_custom_class)
#### Step2:
modify **CRBoxInputCell_Custom** class inherit from `CRBoxInputCell`.m file
``` objc
- (instancetype)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];

if (self) {
[self addSepLineView];
}

return self;
}

- (void)addSepLineView
{
static CGFloat sepLineViewHeight = 4;

UIView *_sepLineView = [UIView new];
_sepLineView.backgroundColor = color_master;
_sepLineView.layer.cornerRadius = sepLineViewHeight / 2.0;
[self.contentView addSubview:_sepLineView];
[_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
make.left.right.bottom.offset(0);
make.height.mas_equalTo(sepLineViewHeight);
}];

_sepLineView.layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
_sepLineView.layer.shadowOpacity = 1;
_sepLineView.layer.shadowOffset = CGSizeMake(0, 2);
_sepLineView.layer.shadowRadius = 4;
}
```
#### Step3:
Insert code where you need.
``` objc
CRBoxInputView_Custom *boxInputView = [[CRBoxInputView_Custom alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
[boxInputView loadAndPrepareView];
[self.view addSubview:boxInputView];
```


<br/>

### <a id="Anchor_SecretSymbol"></a>SecretSymbol
![SecretSymbol.png](/ReadmeResources/4SecretSymbol.png "SecretSymbol.png")

Insert code where you need.
``` objc
CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
cellProperty.securitySymbol = @"*";

CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
boxInputView.ifNeedSecurity = YES;
boxInputView.customCellProperty = cellProperty;
[boxInputView loadAndPrepareView];
[self.view addSubview:boxInputView];
```


<br/>

### <a id="Anchor_SecretImage"></a>SecretImage
![SecretImage.png](/ReadmeResources/5SecretImage.png "SecretImage.png")
#### Step1:
Create custom class [reference here.](#Create_custom_class)
#### Step2:
modify **CRBoxInputCell_Custom** class inherit from `CRBoxInputCell`.m file
``` objc
// Rewrite custom security view in here
- (UIView *)createCustomSecurityView
{
UIView *customSecurityView = [UIView new];

UIImageView *_lockImgView = [UIImageView new];
_lockImgView.image = [UIImage imageNamed:@"smallLock"];
[customSecurityView addSubview:_lockImgView];
[_lockImgView mas_makeConstraints:^(MASConstraintMaker *make) {
make.centerX.offset(0);
make.centerY.offset(0);
make.width.mas_equalTo(XX_6(23));
make.height.mas_equalTo(XX_6(27));
}];

return customSecurityView;
}
```
#### Step3:
Insert code where you need.
``` objc
CRBoxInputView_Custom *boxInputView = [[CRBoxInputView_Custom *boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
boxInputView.ifNeedSecurity = YES;
[boxInputView loadAndPrepareView];
[self.view addSubview:boxInputView];
```


<br/>

### <a id="Anchor_SecretView"></a>SecretView
![SecretView.png](/ReadmeResources/6SecretView.png "SecretView.png")
#### Step1:
Create custom class [reference here.](#Create_custom_class)
#### Step2:
modify **CRBoxInputCell_Custom** class inherit from `CRBoxInputCell`.m file
``` objc
// Rewrite custom security view in here
- (UIView *)createCustomSecurityView
{
UIView *customSecurityView = [UIImageView new];

UIView *rectangleView = [UIView new];
rectangleView.layer.cornerRadius = 4;
rectangleView.backgroundColor = color_master;
[customSecurityView addSubview:rectangleView];
[rectangleView mas_makeConstraints:^(MASConstraintMaker *make) {
make.centerX.offset(0);
make.centerY.offset(0);
make.width.height.mas_equalTo(XX_6(24));
}];

rectangleView.layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
rectangleView.layer.shadowOpacity = 1;
rectangleView.layer.shadowOffset = CGSizeMake(0, 2);
rectangleView.layer.shadowRadius = 4;

return customSecurityView;
}
```
#### Step3:
Insert code where you need.
``` objc
CRBoxInputView_Custom *boxInputView = [[CRBoxInputView_Custom *boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
boxInputView.ifNeedSecurity = YES;
[boxInputView loadAndPrepareView];
[self.view addSubview:boxInputView];
```


<br/>

### <a id="Create_custom_class"></a>Create custom class
#### Step1:
Create **CRBoxInputView_Custom** inherit from `CRBoxInputView`.
.h file
``` objc
#import <CRBoxInputView/CRBoxInputView.h>

@interface CRBoxInputView_Custom : CRBoxInputView
@end
```
.m file
``` objc
#import "CRBoxInputView_Custom.h"
#import "CRBoxInputCell_Custom.h"

@implementation CRBoxInputView_Custom

- (void)initDefaultValue
{
[super initDefaultValue];

// CollectionView Register Class
[[self mainCollectionView] registerClass:[CRBoxInputCell_Custom class] forCellWithReuseIdentifier:CRBoxInputCell_CustomID];
}

// Rewrite this method
- (CRBoxInputCell_Custom *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
CRBoxInputCell_Custom *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputCell_CustomID forIndexPath:indexPath];
return cell;
}

@end
```

#### Step2:
Create **CRBoxInputCell_Custom** inherit from `CRBoxInputCell`.
And define yourself cellId.
.h file
``` objc
#import <CRBoxInputView/CRBoxInputView.h>

// Define yourself cellId
#define CRBoxInputCell_CustomID @"CRBoxInputCell_CustomID"

@interface CRBoxInputCell_Custom : CRBoxInputCell
@end
```
.m file
``` objc
#import "CRBoxInputCell_Custom.h"

@implementation CRBoxInputCell_Custom

- (instancetype)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];

if (self) {
// You can code here
}

return self;
}

// You can create custom security view in here
- (UIView *)createCustomSecurityView
{
UIView *customSecurityView = [UIView new];
return customSecurityView;
}

@end
```

## Properties And Functions
`CRBoxInputCellProperty` class
``` objc
// UI
self.cellBorderColorNormal = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
self.cellBorderColorSelected = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
self.cellBgColorNormal = [UIColor whiteColor];
self.cellBgColorSelected = [UIColor whiteColor];
self.cellCursorColor = [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1];
self.cellCursorWidth = 2;
self.cellCursorHeight = 32;
self.cornerRadius = 4;
self.borderWidth = (0.5);

// label
self.cellFont = [UIFont systemFontOfSize:20];
self.cellTextColor = [UIColor blackColor];

// Security
self.ifShowSecurity = NO;
self.securitySymbol = @"✱";
self.originValue = @"";
self.securityType = CRBoxSecuritySymbolType;
```

`CRBoxFlowLayout` class
``` objc
/** ifNeedEqualGap
* default: YES
*/
@property (assign, nonatomic) BOOL ifNeedEqualGap;

@property (assign, nonatomic) NSInteger itemNum;
```

`CRBoxInputView` class
``` objc
/**
ifNeedCursor
*default: YES
*/
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
codeLength
default: 4
*/
@property (nonatomic, assign) NSInteger codeLength;

/**
ifNeedSecurity
default: NO
*/
@property (assign, nonatomic) BOOL ifNeedSecurity;

/**
show security delay time
default: 0.3
*/
@property (assign, nonatomic) CGFloat securityDelay;

/**
keyBoardType
default: UIKeyboardTypeNumberPad
*/
@property (assign, nonatomic) UIKeyboardType keyBoardType;

/**
textContentType
desc: You set this 'nil' or 'UITextContentTypeOneTimeCode' to auto get verify code.
default: nil
*/
@property (null_unspecified,nonatomic,copy) UITextContentType textContentType NS_AVAILABLE_IOS(10_0);

@property (copy, nonatomic) TextDidChangeblock textDidChangeblock;
@property (strong, nonatomic) CRBoxFlowLayout *boxFlowLayout;
@property (strong, nonatomic) CRBoxInputCellProperty *customCellProperty;
@property (strong, nonatomic, readonly) NSString  *textValue;

- (void)loadAndPrepareView;
- (void)clearAll;
- (UICollectionView *)mainCollectionView;

// Qiuck set
- (void)quickSetSecuritySymbol:(NSString *)securitySymbol;

// You can inherit and call super
- (void)initDefaultValue;

// You can inherit and rewrite
- (UICollectionViewCell *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

```
`CRBoxInputCell` class
``` objc
// You can inherit and rewrite
- (UIView *)createCustomSecurityView;
```

## Author

BearRan, 648070256@qq.com

## Feedback
If you have any other problems about this widget, you can tell me by send E-mail or open a issuse.

## License

CRBoxInputView is available under the MIT license. See the LICENSE file for more info.
