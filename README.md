<a id="Header_Start"></a> ![CRBoxInputViewHeadImg.png](/ReadmeResources/HeadImg.png "CRBoxInputViewHeadImg.png")
[![CI Status](https://img.shields.io/travis/CRAnimation/CRBoxInputView.svg?style=flat)](https://travis-ci.org/CRAnimation/CRBoxInputView)
[![Version](https://img.shields.io/cocoapods/v/CRBoxInputView.svg?style=flat)](https://cocoapods.org/pods/CRBoxInputView)
[![License](https://img.shields.io/cocoapods/l/CRBoxInputView.svg?style=flat)](https://cocoapods.org/pods/CRBoxInputView)
[![Platform](https://img.shields.io/cocoapods/p/CRBoxInputView.svg?style=flat)](https://cocoapods.org/pods/CRBoxInputView)

### [中文文档](https://github.com/CRAnimation/CRBoxInputView#Header_Start) [/ English Document](https://github.com/CRAnimation/CRBoxInputView/blob/master/README_en.md#Header_Start)


## 组件特点
- 支持iOS12短信验证码自动填充
- 支持`Masonry`
- 支持密文显示
- 支持自定义密文图片/view
- 支持iOS8及以上操作系统

> 该组件适用于短信验证码，密码输入框，手机号码输入框这些场景。<br/>希望你可以喜欢！


## Pod安装

CRBoxInputView 可以通过 [CocoaPods](https://cocoapods.org). 来安装,  只需简单的在你的 Podfile 中添加如下代码:

```ruby
pod 'CRBoxInputView', '0.1.6'
```


## 示列

下载源代码后，可以从Example目录中执行 `pod install`，然后运行Demo。
![iPhone 8 Copy 2.png](/ReadmeResources/ScreenShoot1.png "iPhone 8 Copy 2.png")


## 快速指南
| 类型  | 示例图片 |
| :-------------: | :-------------: |
| [Base](#Anchor_Base) | ![Normal.png](/ReadmeResources/1Normal.png "Normal.png")  |
| [CustomBox](#Anchor_CustomBox)  | ![CustomBox.png](/ReadmeResources/2CustomBox.png "CustomBox.png")  |
| [Line](#Anchor_Line)  | ![Line.png](/ReadmeResources/3Line.png "Line.png")  |
| [SecretSymbol](#Anchor_SecretSymbol)  | ![SecretSymbol.png](/ReadmeResources/4SecretSymbol.png "SecretSymbol.png")  |
| [SecretImage](#Anchor_SecretImage)  | ![SecretImage.png](/ReadmeResources/5SecretImage.png "SecretImage.png")  |
| [SecretView](#Anchor_SecretView)  | ![SecretView.png](/ReadmeResources/6SecretView.png "SecretView.png") |

## 使用说明

### <a id="Anchor_Base"></a>Base

![Normal.png](/ReadmeResources/1Normal.png "Normal.png")

在需要使用的地方插入如下代码
``` objc
CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
boxInputView.codeLength = 4;
[boxInputView loadAndPrepareViewWithBeginEdit:YES]; // BeginEdit:是否自动启用编辑模式
[self.view addSubview:boxInputView];

// 获取值
// 方法1, 当输入文字变化时触发回调block
boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
    NSLog(@"text:%@", text);
};
// 方法2, 普通的只读属性
NSLog(@"textValue:%@", boxInputView.textValue);

// 清空
[boxInputView clearAllWithBeginEdit:YES]; // BeginEdit:清空后是否自动启用编辑模式

```


<br/>

### <a id="Anchor_CustomBox"></a>CustomBox
![CustomBox.png](/ReadmeResources/2CustomBox.png "CustomBox.png")
#### Step1:
[参考这里](#Create_custom_class)来创建自定义类
#### Step2:
修改继承自`CRBoxInputCell` 的自定义 **CRBoxInputCell_Custom** 类的 .m 文件
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
在需要使用的地方插入如下代码
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
[参考这里](#Create_custom_class)来创建自定义类
#### Step2:
修改继承自`CRBoxInputCell` 的自定义 **CRBoxInputCell_Custom** 类的 .m 文件
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
在需要使用的地方插入如下代码
``` objc
CRBoxInputView_Custom *boxInputView = [[CRBoxInputView_Custom alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
[boxInputView loadAndPrepareView];
[self.view addSubview:boxInputView];
```


<br/>

### <a id="Anchor_SecretSymbol"></a>SecretSymbol
![SecretSymbol.png](/ReadmeResources/4SecretSymbol.png "SecretSymbol.png")

在需要使用的地方插入如下代码
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
[参考这里](#Create_custom_class)来创建自定义类
#### Step2:
修改继承自`CRBoxInputCell` 的自定义 **CRBoxInputCell_Custom** 类的 .m 文件
``` objc
// 在这里重写你的security view
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
在需要使用的地方插入如下代码
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
[参考这里](#Create_custom_class)来创建自定义类
#### Step2:
修改继承自`CRBoxInputCell` 的自定义 **CRBoxInputCell_Custom** 类的 .m 文件
``` objc
// 在这里重写你的security view
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
在需要使用的地方插入如下代码
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
创建 **CRBoxInputView_Custom** 类，并且继承自 `CRBoxInputView`。
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

// CollectionView 注册 Class
[[self mainCollectionView] registerClass:[CRBoxInputCell_Custom class] forCellWithReuseIdentifier:CRBoxInputCell_CustomID];
}

// 重写这个方法
- (CRBoxInputCell_Custom *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
CRBoxInputCell_Custom *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRBoxInputCell_CustomID forIndexPath:indexPath];
return cell;
}

@end
```

#### Step2:
创建 **CRBoxInputCell_Custom** 类，并且继承自 `CRBoxInputCell`。
并且定义你自己的 cellId。
.h file
``` objc
#import <CRBoxInputView/CRBoxInputView.h>

// 定义你自己的 cellId
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
// 在此处编写你的代码
}

return self;
}

// 你可以在这里创建你的security view
- (UIView *)createCustomSecurityView
{
UIView *customSecurityView = [UIView new];
return customSecurityView;
}

@end
```

## 属性和方法
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
/** 是否需要等间距
* default: YES
*/
@property (assign, nonatomic) BOOL ifNeedEqualGap;

@property (assign, nonatomic) NSInteger itemNum;
```

`CRBoxInputView` class
``` objc
/**
是否需要光标
*default: YES
*/
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
验证码长度
default: 4
*/
@property (nonatomic, assign) NSInteger codeLength;

/**
是否开启密文模式
default: NO
*/
@property (assign, nonatomic) BOOL ifNeedSecurity;

/**
显示密文的延时时间
default: 0.3
*/
@property (assign, nonatomic) CGFloat securityDelay;

/**
键盘类型
default: UIKeyboardTypeNumberPad
*/
@property (assign, nonatomic) UIKeyboardType keyBoardType;

/**
textContentType
desc: 你可以设置为 'nil' 或者 'UITextContentTypeOneTimeCode' 来自动获取短信验证码
default: nil
*/
@property (null_unspecified,nonatomic,copy) UITextContentType textContentType NS_AVAILABLE_IOS(10_0);

@property (copy, nonatomic) TextDidChangeblock textDidChangeblock;
@property (strong, nonatomic) CRBoxFlowLayout *boxFlowLayout;
@property (strong, nonatomic) CRBoxInputCellProperty *customCellProperty;
@property (strong, nonatomic, readonly) NSString  *textValue;

/**
装载数据和准备界面
beginEdit: 自动开启编辑模式
default: YES
*/
- (void)loadAndPrepareView;
- (void)loadAndPrepareViewWithBeginEdit:(BOOL)beginEdit;

/**
清空输入
beginEdit: 自动开启编辑模式
default: YES
*/
- (void)clearAll;
- (void)clearAllWithBeginEdit:(BOOL)beginEdit;

- (UICollectionView *)mainCollectionView;

// 快速设置
- (void)quickSetSecuritySymbol:(NSString *)securitySymbol;

// 你可以在继承的子类中调用父类方法
- (void)initDefaultValue;

// 你可以在继承的子类中重写父类方法
- (UICollectionViewCell *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

```
`CRBoxInputCell` class
``` objc
// 你可以在继承的子类中重写父类方法
- (UIView *)createCustomSecurityView;
```

## 其他问题

- [pod search 搜索不到库（已解决）](https://github.com/CRAnimation/CRBoxInputView/issues/1 "pod search 搜索不到库")
- [pod 安装失败， [!] Unable to find a specification for CRBoxInputView（已解决）](https://github.com/CRAnimation/CRBoxInputView/issues/2 "pod 安装失败， [!] Unable to find a specification for CRBoxInputView")
- 请小伙伴从0.1.6版本开始使用,`pod install`可以正常安装。
- 在早期版本中存在一些安装的问题，我为由此带来的不便感到抱歉。

## 作者

BearRan, 648070256@qq.com

## 反馈
如果你在使用这个控件时遇到了问题，可以通过E-mail告诉我，或者为此开一个issuse。

## License

CRBoxInputView is available under the MIT license. See the LICENSE file for more info.
