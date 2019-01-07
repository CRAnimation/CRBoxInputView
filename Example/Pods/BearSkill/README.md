# BearSkill Origin

# README

# BearSkill

[![CI Status](http://img.shields.io/travis/Bear/BearSkill.svg?style=flat)](https://travis-ci.org/Bear/BearSkill)
[![Version](https://img.shields.io/cocoapods/v/BearSkill.svg?style=flat)](http://cocoapods.org/pods/BearSkill)
[![License](https://img.shields.io/cocoapods/l/BearSkill.svg?style=flat)](http://cocoapods.org/pods/BearSkill)
[![Platform](https://img.shields.io/cocoapods/p/BearSkill.svg?style=flat)](http://cocoapods.org/pods/BearSkill)

## Installation

BearSkill is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BearSkill"
```

## Author

Bear, 648070256@qq.com

## License

BearSkill is available under the MIT license. See the LICENSE file for more info.

Introduction
------------

### 简介：
平时的工作总结，从UIView到布局，从富文本处理到图形切割，各种都有。
争取分好类。每个部分都有一个简短的介绍，有意见，建议欢迎沟通QQ：648070256。

## Constants / 常用常量和方法
* BearConstants
  * iOS开发中常用的各种方法，常量。屏幕宽高，UserDefault宏等


## Layout / 非约束性布局
* UIView+BearSet
  * 非约束性布局和一些常用的布局思路
  * 详情见链接:http://blog.csdn.net/xiongbaoxr/article/details/50668260

* UITableView+BearStoreCellHeight
  * UITableView自动记录Cell高度，获取cell高度，告别手动管理



## UI&Extend / UI和扩展
* BearAlertView
  * 自定义弹框，支持自定义contentView，自定义BtnsView，支持简单的动画样式

* BearCutOutView
  * 对UIView挖空特定的形状

* UITextField+BearLimitLength
  * 限制UITextField输入字符数量
  * 详情见链接:http://blog.csdn.net/xiongbaoxr/article/details/51525061



## AttributeString / 富文本处理
* NSMutableAttributedString+BearSet
  * 便携式富文本处理，支持正则表达式。也可直接设置行间距。
  
  

---
# 历史版本：
* 0.1.0
  1. 新增BearCutOutView挖空UIView的方法
  2. 将原先UITextField+BearSet方法整理更名为UITextField+BearLimitLength，并保留原来名称兼容此前版本
  3. 整理项目结构并进行分类
* 0.1.1
  1. 增加BearAlertView自定义弹框方法