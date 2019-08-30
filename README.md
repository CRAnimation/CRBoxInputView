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


## 重大更新！！！
从1.0.0版本开始，无需通过继承的方式使用。通过设置`CRBoxInputCellProperty`中的对应Block，即可快速自定义需求。
``` objc
customSecurityViewBlock //自定义密文View
customLineViewBlock     //自定义下划线
configCellShadowBlock   //自定义阴影
```
>此更新兼容1.0.0之前的版本

## Pod安装

CRBoxInputView 可以通过 [CocoaPods](https://cocoapods.org). 来安装,  只需简单的在你的 Podfile 中添加如下代码:

```ruby
pod 'CRBoxInputView', '1.1.3'
```


## 示列

下载源代码后，可以从Example目录中执行 `pod install`，然后运行Demo。
![iPhone 8 Copy 2.png](/ReadmeResources/ScreenShoot2.png "iPhone 8 Copy 2.png")


## 快速指南
| 类型  | 示例图片 |
| :-------------: | :-------------: |
| [Base](#Anchor_Base) | ![Normal.png](/ReadmeResources/1Normal.png "Normal.png")  |
| [Placeholder](#Anchor_Placeholder) | ![Placeholder.png](/ReadmeResources/Add1_Placeholder0.png "Placeholder.png")  |
| [CustomBox](#Anchor_CustomBox)  | ![CustomBox.png](/ReadmeResources/2CustomBox.png "CustomBox.png")  |
| [Line](#Anchor_Line)  | ![Line.png](/ReadmeResources/3Line.png "Line.png")  |
| [SecretSymbol](#Anchor_SecretSymbol)  | ![SecretSymbol.png](/ReadmeResources/4SecretSymbol.png "SecretSymbol.png")  |
| [SecretImage](#Anchor_SecretImage)  | ![SecretImage.png](/ReadmeResources/5SecretImage.png "SecretImage.png")  |
| [SecretView](#Anchor_SecretView)  | ![SecretView.png](/ReadmeResources/6SecretView.png "SecretView.png") |

## 使用说明

### <a id="Anchor_Base"></a>Base
![Normal.png](/ReadmeResources/1Normal.png "Normal.png")
``` objc
CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
boxInputView.codeLength = 4;// 不设置时，默认4
boxInputView.keyBoardType = UIKeyboardTypeNumberPad;// 不设置时，默认UIKeyboardTypeNumberPad
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

### <a id="Anchor_Placeholder"></a>Placeholder
![Placeholder.png](/ReadmeResources/Add1_Placeholder0.png "Placeholder.png")
``` objc
CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
cellProperty.cellPlaceholderTextColor = [UIColor colorWithRed:114/255.0 green:116/255.0 blue:124/255.0 alpha:0.3]; //可选
cellProperty.cellPlaceholderFont = [UIFont systemFontOfSize:20]; //可选

CRBoxInputView *boxInputView = [CRBoxInputView new];
boxInputView.ifNeedCursor = NO; //可选
boxInputView.placeholderText = @"露可娜娜"; //必需
boxInputView.customCellProperty = cellProperty;
[boxInputView loadAndPrepareViewWithBeginEdit:YES];
```
> Ps:有一回，一个逗比队友，被对面娜可露露抓急了，口误喊成了“露可娜娜”。。。


<br/>

### <a id="Anchor_CustomBox"></a>CustomBox
![CustomBox.png](/ReadmeResources/2CustomBox.png "CustomBox.png")
``` objc
CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
cellProperty.cellBgColorNormal = color_FFECEC;
cellProperty.cellBgColorSelected = [UIColor whiteColor];
cellProperty.cellCursorColor = color_master;
cellProperty.cellCursorWidth = 2;
cellProperty.cellCursorHeight = 30;
cellProperty.cornerRadius = 4;
cellProperty.borderWidth = 0;
cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
cellProperty.cellTextColor = color_master;
cellProperty.configCellShadowBlock = ^(CALayer * _Nonnull layer) {
    layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 2);
    layer.shadowRadius = 4;
};

CRBoxInputView *boxInputView = [CRBoxInputView new];
boxInputView.boxFlowLayout.itemSize = CGSizeMake(50, 50);
boxInputView.customCellProperty = cellProperty;
[boxInputView loadAndPrepareViewWithBeginEdit:YES];
```


<br/>

### <a id="Anchor_Line"></a>Line
![Line.png](/ReadmeResources/3Line.png "Line.png")
``` objc
CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
cellProperty.showLine = YES; //必需
cellProperty.customLineViewBlock = ^CRLineView * _Nonnull{
    CRLineView *lineView = [CRLineView new];
    lineView.underlineColorNormal = color_master;
    lineView.underlineColorSelected = [color_master colorWithAlphaComponent:0.55];
    [lineView.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(4);
        make.left.right.bottom.offset(0);
    }];

    return lineView;
}; //可选

CRBoxInputView *boxInputView = [CRBoxInputView new];
boxInputView.customCellProperty = cellProperty;
[boxInputView loadAndPrepareViewWithBeginEdit:YES];
```


<br/>

### <a id="Anchor_SecretSymbol"></a>SecretSymbol
![SecretSymbol.png](/ReadmeResources/4SecretSymbol.png "SecretSymbol.png")

``` objc
CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
cellProperty.securitySymbol = @"*"; //可选

CRBoxInputView *boxInputView = [CRBoxInputView new];
boxInputView.ifNeedSecurity = YES; //必需（你可以在任何时候修改该属性，并且已经存在的文字会自动刷新。）
boxInputView.customCellProperty = cellProperty;
[boxInputView loadAndPrepareViewWithBeginEdit:YES];
```


<br/>

### <a id="Anchor_SecretImage"></a>SecretImage
![SecretImage.png](/ReadmeResources/5SecretImage.png "SecretImage.png")
``` objc
CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
cellProperty.securityType = CRBoxSecurityCustomViewType; //必需
cellProperty.customSecurityViewBlock = ^UIView * _Nonnull{
    CRSecrectImageView *secrectImageView = [CRSecrectImageView new];
    secrectImageView.image = [UIImage imageNamed:@"smallLock"];
    secrectImageView.imageWidth = 23;
    secrectImageView.imageHeight = 27;
    
    return secrectImageView;
}; //必需

CRBoxInputView *boxInputView = [CRBoxInputView new];
boxInputView.ifNeedSecurity = YES; //必需（你可以在任何时候修改该属性，并且已经存在的文字会自动刷新。）
boxInputView.customCellProperty = cellProperty;
[boxInputView loadAndPrepareViewWithBeginEdit:YES];
```


<br/>

### <a id="Anchor_SecretView"></a>SecretView
![SecretView.png](/ReadmeResources/6SecretView.png "SecretView.png")
``` objc
CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
cellProperty.securityType = CRBoxSecurityCustomViewType; //必需
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
}; //可选

CRBoxInputView *boxInputView = [CRBoxInputView new];
boxInputView.ifNeedSecurity = YES; //必需（你可以在任何时候修改该属性，并且已经存在的文字会自动刷新。）
boxInputView.customCellProperty = cellProperty;
[boxInputView loadAndPrepareViewWithBeginEdit:YES];
```


<br/>

## 属性和方法
`CRBoxInputCellProperty` class
``` objc
#pragma mark - UI
/**
cell边框宽度
默认：0.5
*/
@property (assign, nonatomic) CGFloat borderWidth;

/**
cell边框颜色
状态：未选中状态时
默认：[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1]
*/
@property (copy, nonatomic) UIColor *cellBorderColorNormal;

/**
cell边框颜色
状态：选中状态时
默认：[UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1]
*/
@property (copy, nonatomic) UIColor *cellBorderColorSelected;

/**
cell边框颜色
状态：无填充文字，未选中状态时
默认：与cellBorderColorFilled相同
*/
@property (copy, nonatomic) UIColor *__nullable cellBorderColorFilled;

/**
cell背景颜色
状态：无填充文字，未选中状态时
默认：[UIColor whiteColor]
*/
@property (copy, nonatomic) UIColor *cellBgColorNormal;

/**
cell背景颜色
状态：选中状态时
默认：[UIColor whiteColor]
*/
@property (copy, nonatomic) UIColor *cellBgColorSelected;

/**
cell背景颜色
状态：填充文字后，未选中状态时
默认：与cellBgColorFilled相同
*/
@property (copy, nonatomic) UIColor *__nullable cellBgColorFilled;


/**
光标颜色
默认： [UIColor colorWithRed:255/255.0 green:70/255.0 blue:62/255.0 alpha:1]
*/
@property (copy, nonatomic) UIColor *cellCursorColor;

/**
光标宽度
默认： 2
*/
@property (assign, nonatomic) CGFloat cellCursorWidth;

/**
光标高度
默认： 32
*/
@property (assign, nonatomic) CGFloat cellCursorHeight;

/**
圆角
默认： 4
*/
@property (assign, nonatomic) CGFloat cornerRadius;



#pragma mark - line
/**
显示下划线
默认： NO
*/
@property (assign, nonatomic) BOOL showLine;



#pragma mark - label
/**
字体/字号
默认：[UIFont systemFontOfSize:20];
*/
@property (copy, nonatomic) UIFont *cellFont;

/**
字体颜色
默认：[UIColor blackColor];
*/
@property (copy, nonatomic) UIColor *cellTextColor;



#pragma mark - Security
/**
是否密文显示
默认：NO
*/
@property (assign, nonatomic) BOOL ifShowSecurity;

/**
密文符号
默认：✱
说明：只有ifShowSecurity=YES时，有效
*/
@property (copy, nonatomic) NSString *securitySymbol;

/**
密文类型
默认：CRBoxSecuritySymbolType
类型说明：
CRBoxSecuritySymbolType 符号类型，根据securitySymbol，originValue的内容来显示
CRBoxSecurityCustomViewType 自定义View类型，可以自定义密文状态下的图片，View
*/
@property (assign, nonatomic) CRBoxSecurityType securityType;



#pragma mark - Placeholder
/**
占位符字体颜色
默认：[UIColor colorWithRed:114/255.0 green:126/255.0 blue:124/255.0 alpha:0.3];
*/
@property (copy, nonatomic) UIColor *cellPlaceholderTextColor;

/**
占位符字体/字号
默认：[UIFont systemFontOfSize:20];
*/
@property (copy, nonatomic) UIFont *cellPlaceholderFont;



#pragma mark - Block
/**
自定义密文View回调
*/
@property (copy, nonatomic) CustomSecurityViewBlock customSecurityViewBlock;
/**
自定义下划线回调
*/
@property (copy, nonatomic) CustomLineViewBlock customLineViewBlock;
/**
自定义阴影回调
*/
@property (copy, nonatomic) ConfigCellShadowBlock __nullable configCellShadowBlock;
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
ifNeedCursor
default: YES
*/
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
验证码长度
codeLength
default: 4
*/
@property (nonatomic, assign) NSInteger codeLength;

/**
是否开启密文模式
描述：你可以在任何时候修改该属性，并且已经存在的文字会自动刷新。
ifNeedSecurity
default: NO
*/
@property (assign, nonatomic) BOOL ifNeedSecurity;

/**
显示密文的延时时间
securityDelay
desc: show security delay time
default: 0.3
*/
@property (assign, nonatomic) CGFloat securityDelay;

/**
键盘类型
keyBoardType
default: UIKeyboardTypeNumberPad
*/
@property (assign, nonatomic) UIKeyboardType keyBoardType;

/**
textContentType
描述: 你可以设置为 'nil' 或者 'UITextContentTypeOneTimeCode' 来自动获取短信验证码
desc: You set this 'nil' or 'UITextContentTypeOneTimeCode' to auto fill verify code.
default: nil
*/
@property (null_unspecified,nonatomic,copy) UITextContentType textContentType NS_AVAILABLE_IOS(10_0);

/**
占位字符填充值
说明：在对应的输入框没有内容时，会显示该值。
默认：nil
*/
@property (strong, nonatomic) NSString  * _Nullable placeholderText;

@property (copy, nonatomic) TextDidChangeblock _Nullable textDidChangeblock;
@property (strong, nonatomic) CRBoxFlowLayout * _Nullable boxFlowLayout;
@property (strong, nonatomic) CRBoxInputCellProperty * _Nullable customCellProperty;
@property (strong, nonatomic, readonly) NSString  * _Nullable textValue;
@property (strong, nonatomic) UIView * _Nullable inputAccessoryView;

/**
装载数据和准备界面
desc: Load and prepareView
beginEdit: 自动开启编辑模式
default: YES
*/
- (void)loadAndPrepareView;
- (void)loadAndPrepareViewWithBeginEdit:(BOOL)beginEdit;

/**
清空输入
desc: Clear all
beginEdit: 自动开启编辑模式
default: YES
*/
- (void)clearAll;
- (void)clearAllWithBeginEdit:(BOOL)beginEdit;

- (UICollectionView *_Nullable)mainCollectionView;

// 快速设置
// Qiuck set
- (void)quickSetSecuritySymbol:(NSString *_Nullable)securitySymbol;

// 你可以在继承的子类中调用父类方法
// You can inherit and call super
- (void)initDefaultValue;

// 你可以在继承的子类中重写父类方法
// You can inherit and rewrite
- (UICollectionViewCell *_Nullable)customCollectionView:(UICollectionView *_Nullable)collectionView cellForItemAtIndexPath:(NSIndexPath *_Nullable)indexPath;
```
`CRBoxInputCell` class
``` objc
// 你可以在继承的子类中重写父类方法
// You can inherit and rewrite
- (UIView *)createCustomSecurityView;
```

`CRLineView` class
``` objc
@property (strong, nonatomic) UIView    *lineView;

/**
下划线颜色
状态：未选中状态时
默认：[UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]
*/
@property (copy, nonatomic) UIColor *underlineColorNormal;

/**
下划线颜色
状态：选中状态时
默认：[UIColor colorWithRed:49/255.0 green:51/255.0 blue:64/255.0 alpha:1]
*/
@property (copy, nonatomic) UIColor *underlineColorSelected;
```

## 其他问题

- [pod search 搜索不到库（已解决）](https://github.com/CRAnimation/CRBoxInputView/issues/1 "pod search 搜索不到库")
- [pod 安装失败， [!] Unable to find a specification for CRBoxInputView（已解决）](https://github.com/CRAnimation/CRBoxInputView/issues/2 "pod 安装失败， [!] Unable to find a specification for CRBoxInputView")

## 作者

BearRan, 648070256@qq.com

## 反馈
如果你在使用这个控件时遇到了问题，可以通过E-mail告诉我，或者为此开一个issuse。

## License

CRBoxInputView is available under the MIT license. See the LICENSE file for more info.
