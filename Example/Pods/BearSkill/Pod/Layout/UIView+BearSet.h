//
//  UIView+BearSet.h
//
//  Created by bear on 15/11/25.
//  Copyright (c) 2015年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kAXIS) {
    kAXIS_Y,
    kAXIS_X,
    kAXIS_X_Y,
};

typedef NS_ENUM(NSUInteger, kLAYOUT_AXIS) {
    kLAYOUT_AXIS_Y,
    kLAYOUT_AXIS_X,
};

typedef NS_ENUM(NSUInteger, kDIRECTION) {
    kDIR_LEFT,
    kDIR_RIGHT,
    kDIR_UP,
    kDIR_DOWN,
};

typedef NS_ENUM(NSUInteger, SetNeedWHSort) {
    kSetNeed_Width,
    kSetNeed_Height,
};

//  设置对齐类型
typedef NS_ENUM(NSUInteger, SetAlignmentType) {
    kSetAlignmentType_Idle,     //  不处理对齐方式
    kSetAlignmentType_Center,   //  剧中对齐
    kSetAlignmentType_Start,    //  上／左对齐
    kSetAlignmentType_End,      //  下／右对齐
    kSetAlignmentType_CustomCenter,   //  自定义剧中的位置
};

//  offParameter结构体
struct OffPara
{
    CGFloat offStart;
    CGFloat offEnd;
    BOOL    autoCalu;
};
typedef struct OffPara OffPara;

//  offParameter内联
CG_INLINE OffPara
OffParaMake(CGFloat offStart, CGFloat offEnd, BOOL autoCalu)
{
    OffPara offPara;
    offPara.offStart    = offStart;
    offPara.offEnd      = offEnd;
    offPara.autoCalu    = autoCalu;
    return offPara;
}


//  gapParameter结构体
struct GapPara
{
    CGFloat gapDistance;
    BOOL    autoCalu;
};
typedef struct GapPara GapPara;

//  gapParameter内联
CG_INLINE GapPara
GapParaMake(CGFloat gapDistance, BOOL autoCalu)
{
    GapPara gapPara;
    gapPara.gapDistance = gapDistance;
    gapPara.autoCalu    = autoCalu;
    return gapPara;
}


@interface UIView (BearSet)

/**
 *  普通的方法
 */

- (void)removeAllSubViews;

// 描边
- (void)setLine:(UIColor *)color cornerRadius:(NSUInteger)cornerRadius borderWidth:(CGFloat)borderWidth;

// 毛玻璃效果处理
- (void)blurEffectWithStyle:(UIBlurEffectStyle)style Alpha:(CGFloat)alpha;

// 设置边框
- (void)setMyBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

// 自定义分割线View OffY
- (void)setMySeparatorLineOffY:(int)offStart offEnd:(int)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor offY:(CGFloat)offY;

// 自定义底部分割线View
- (void)setMySeparatorLine:(CGFloat)offStart offEnd:(CGFloat)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

/**
 *  画线--View
 *  通过view，画横向／纵向的线
 *
 *  @param startPoint 起点
 *  @param endPoint   终点
 *  @param lineWidth  线宽
 *  @param lineColor  线颜色
 *
 *  @return view上绘制的线view
 */
- (UIView *)drawLine:(CGPoint)startPoint
            endPoint:(CGPoint)endPoint
           lineWidth:(CGFloat)lineWidth
           lineColor:(UIColor *)lineColor;

// 通过layer，画任意方向的线
- (void)drawLineWithLayer:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

/**
 *  在View中绘制虚线
 *
 *  @param axis        横向／纵向绘制虚线
 *  @param dashColor   虚线颜色
 *  @param dashPattern 虚线间距数组，默认@[@3, @3]
 */
- (void)drawDashLineWithAxis:(kLAYOUT_AXIS)axis
                   dashColor:(UIColor *)dashColor
                 dashPattern:(NSArray<NSNumber *> *)dashPattern;

/**
 *  虚线Layer
 *
 *  @param axis        横向／纵向绘制虚线
 *  @param dashColor   虚线颜色
 *  @param dashPattern 虚线间距数组，默认@[@3, @3]
 */
+ (CAShapeLayer *)dashLayerWithAxis:(kLAYOUT_AXIS)axis
                          dashColor:(UIColor *)dashColor
                        dashPattern:(NSArray<NSNumber *> *)dashPattern
                              frame:(CGRect)frame;

/**
 在layer上添加分离图片
 
 @param image 图片
 @param rect 图片裁剪比例 CGRectMake(0, 0, 0.5, 0.5)
 @param contentsGravity 图片填充模式
 */
- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect contentsGravity:(NSString *)contentsGravity;



/**
 *  布局扩展方法
 */


//  Getter

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)maxX;
- (CGFloat)maxY;
- (CGFloat)width;
- (CGFloat)height;
- (CGPoint)origin;
- (CGSize)size;

- (CGFloat)centerX;
- (CGFloat)centerY;


//Setter

- (void)setX:(CGFloat)x;
- (void)setMaxX:(CGFloat)maxX;
- (void)setMaxX_DontMoveMinX:(CGFloat)maxX;

- (void)setY:(CGFloat)y;
- (void)setMaxY:(CGFloat)maxY;
- (void)setMaxY_DontMoveMinY:(CGFloat)maxY;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setOrigin:(CGPoint)point;
- (void)setOrigin:(CGPoint)point sizeToFit:(BOOL)sizeToFit;
- (void)setSize:(CGSize)size;

- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;

- (void)setWidth_DonotMoveCenter:(CGFloat)width;
- (void)setHeight_DonotMoveCenter:(CGFloat)height;
- (void)setSize_DonotMoveCenter:(CGSize)size;
- (void)sizeToFit_DonotMoveCenter;
- (void)sizeToFit_DonotMoveSide:(kDIRECTION)dir centerRemain:(BOOL)centerRemain;


/**
 *  保持宽高比，自动设置Size
 *
 *  @param referWidth  参考宽度
 *  @param referHeight 参考高度
 *  @param setWidth    实际宽度，自动计算高度
 */
- (void)BearSetSizeRemainWHRatio_referWidth:(NSNumber *)referWidth referHeight:(NSNumber *)referHeight setSort:(SetNeedWHSort)setSort setValue:(NSNumber *)setValue;

/**
 *  保持宽高比，自动设置Size
 *
 *  @param referWidth  参考宽度
 *  @param referHeight 参考高度
 *  @param setWidth    实际宽度，自动计算高度
 *
 *  @return
 *      setSort == kSetNeed_Width时，返回高度
 *      setSort == kSetNeed_Height时，返回宽度
 */
+ (CGSize)caculateSizeRemainWHRatio_referWidth:(NSNumber *)referWidth referHeight:(NSNumber *)referHeight setSort:(SetNeedWHSort)setSort setValue:(NSNumber *)setValue;

/**
 *  保持宽高比，自动设置Bounds
 *
 *  @param referWidth  参考宽度
 *  @param referHeight 参考高度
 *  @param setWidth    实际宽度，自动计算高度
 *
 *  @return
 *      setSort == kSetNeed_Width时，返回高度
 *      setSort == kSetNeed_Height时，返回宽度
 */
+ (CGRect)caculateBoundsRemainWHRatio_referWidth:(NSNumber *)referWidth referHeight:(NSNumber *)referHeight setSort:(SetNeedWHSort)setSort setValue:(NSNumber *)setValue;

/**
 *  和父类view剧中
 *
 *  当前view和父类view的 X轴／Y轴／中心点 对其
 */
- (void)BearSetCenterToParentViewWithAxis:(kAXIS)axis;


/**
 *  和指定的view剧中
 *
 *  当前view和指定view的 X轴／Y轴／中心点 对其
 */
- (void)BearSetCenterToView:(UIView *)destinationView withAxis:(kAXIS)axis;


/**
 *  view与view的相对位置
 */
- (void)BearSetRelativeLayoutWithDirection:(kDIRECTION)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation distance:(CGFloat)distance center:(BOOL)center; 


/**
 *  view的相对布局，带sizeToFit
 */
- (void)BearSetRelativeLayoutWithDirection:(kDIRECTION)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation distance:(CGFloat)distance center:(BOOL)center sizeToFit:(BOOL)sizeToFit;


#pragma mark - AutoLay V1

/**
 *  根据子view自动布局 -- 自动计算:起始点，结束点，间距（三值相等）
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center;


/**
 *  根据子view自动布局 -- 需要设置:起始点，结束点; -- 自动计算:间距
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center offStart:(CGFloat)offStart offEnd:(CGFloat)offEnd;


/**
 *  根据子view自动布局 -- 需要设置:间距; -- 自动计算:起始点，结束点
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center gapDistance:(CGFloat)gapDistance;


/**
 *  根据子view自动布局 -- 需要设置:起始点，结束点，间距
 *  说明： 在父类view尺寸不等于需求尺寸时，会自动变化
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center offStart:(CGFloat)offStart offEnd:(CGFloat)offEnd gapDistance:(CGFloat)gapDistance;


/**
 *  根据子view自动布局 -- 需要设置:gapArray间距比例数组，间距总和
 *  说明： 在父类view尺寸不等于需求尺寸时，会自动变化
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center gapAray:(NSArray *)gapArray gapDisAll:(CGFloat)gapDisAll;

/**
 *  根据子view自动布局 -- 需要设置:gapArray间距比例数组; -- 自动计算：间距总和
 *  说明： 在父类view尺寸不等于需求尺寸时，无法自动布局
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center gapAray:(NSArray *)gapArray;



#pragma mark - AutoLay V2

/**
 *  根据子view自动布局 -- 自动计算:起始点，结束点，间距（三值相等）
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 */
+ (void)BearV2AutoLayViewArray:(NSMutableArray *)viewArray
                    layoutAxis:(kLAYOUT_AXIS)layoutAxis
                 alignmentType:(SetAlignmentType)alignmentType
               alignmentOffDis:(CGFloat)alignmentOffDis;


/**
 *  根据子view自动布局 -- 需要设置:起始点，结束点; -- 自动计算:间距
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 */
+ (void)BearV2AutoLayViewArray:(NSMutableArray *)viewArray
                    layoutAxis:(kLAYOUT_AXIS)layoutAxis
                 alignmentType:(SetAlignmentType)alignmentType
               alignmentOffDis:(CGFloat)alignmentOffDis
                      offStart:(CGFloat)offStart
                        offEnd:(CGFloat)offEnd;


/**
 *  根据子view自动布局 -- 需要设置:间距; -- 自动计算:起始点，结束点
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 */
+ (void)BearV2AutoLayViewArray:(NSMutableArray *)viewArray
                    layoutAxis:(kLAYOUT_AXIS)layoutAxis
                 alignmentType:(SetAlignmentType)alignmentType
               alignmentOffDis:(CGFloat)alignmentOffDis
                   gapDistance:(CGFloat)gapDistance;


/**
 *  根据子view自动布局 -- 需要设置:起始点，结束点，间距
 *  说明： 在父类view尺寸不等于需求尺寸时，会自动变化
 */
+ (void)BearV2AutoLayViewArray:(NSMutableArray *)viewArray
                    layoutAxis:(kLAYOUT_AXIS)layoutAxis
                 alignmentType:(SetAlignmentType)alignmentType
               alignmentOffDis:(CGFloat)alignmentOffDis
                      offStart:(CGFloat)offStart
                        offEnd:(CGFloat)offEnd
                   gapDistance:(CGFloat)gapDistance;


/**
 *  根据子view自动布局 -- 需要设置:gapArray间距比例数组，间距总和
 *  说明： 在父类view尺寸不等于需求尺寸时，会自动变化
 */
+ (void)BearV2AutoLayViewArray:(NSMutableArray *)viewArray
                    layoutAxis:(kLAYOUT_AXIS)layoutAxis
                 alignmentType:(SetAlignmentType)alignmentType
               alignmentOffDis:(CGFloat)alignmentOffDis
                       gapAray:(NSArray *)gapArray
                     gapDisAll:(CGFloat)gapDisAll;


/**
 *  根据子view自动布局 -- 需要设置:gapArray间距比例数组; -- 自动计算：间距总和
 *  说明： 在父类view尺寸不等于需求尺寸时，无法自动布局
 */
+ (void)BearV2AutoLayViewArray:(NSMutableArray *)viewArray
                    layoutAxis:(kLAYOUT_AXIS)layoutAxis
                 alignmentType:(SetAlignmentType)alignmentType
               alignmentOffDis:(CGFloat)alignmentOffDis
                       gapAray:(NSArray *)gapArray;


@end
