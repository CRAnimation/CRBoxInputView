//
//  BearCustomButton.h
//  自定义按钮
//  Pods
//
//  Created by apple on 16/9/23.
//
//

#import <UIKit/UIKit.h>
#import <BearSkill/UIView+BearSet.h>

typedef enum {
    kCustomBtnType_Image_Label, //  图片_文字
    kCustomBtnType_Label_Image, //  文字_图片
    kCustomBtnType_Label,       //  文字
    kCustomBtnType_Image,       //  图片
}CustomBtnType;

typedef enum {
    kLayoutStyle_Idle,                  //  空状态，不执行Bear布局方法
    kLayoutStyle_AccrodindToOffPara,    //  根据off_start,off_end,off_gap严格布局
    kLayoutStyle_CenterLay,             //  根据off_gap，在当前frame下自动剧中布局
}LayoutStyle;

@interface BearCustomButton : UIButton

@property (strong, nonatomic) UILabel       *btnLabel;
@property (strong, nonatomic) UIImageView   *btnImageV;
@property (assign, nonatomic) kLAYOUT_AXIS  layout_AXIS;
@property (assign, nonatomic) CustomBtnType customBtnType;
@property (assign, nonatomic) LayoutStyle   layoutStyle;
@property (assign, nonatomic) CGFloat       off_start;
@property (assign, nonatomic) CGFloat       off_end;
@property (assign, nonatomic) CGFloat       off_gap;

- (void)relayUI;

//  参考示例
- (void)demoUse;

@end
