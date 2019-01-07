//
//  BearConstants.h
//  Bear
//
//  Created by Bear on 30/12/24.
//  Copyright © 2015年 Bear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+BearSet.h"
#import <MBProgressHUD/MBProgressHUD.h>

//  HUD
static MBProgressHUD *_stateHud;

//  NotificationCenter字段
static NSString *NotificationTest = @"NotificationTest";

//  UserDefaults字段
static NSString *usTest = @"usTest";

@interface BearConstants : NSObject

//  获取当前时间，日期
+ (NSString *)getCurrentTimeStr;

//  dict取值并判断是否为空
+ (id)setDataWithDict:(NSDictionary *)dict keyStr:(NSString *)keyStr;

//  dict取值并判断是否为空,string类型专用
+ (NSString *)setStringWithDict:(NSDictionary *)dict keyStr:(NSString *)keyStr;

//  防止字符串为<null>
+ (NSString *)avoidStringCrash:(id)string;

//  判断字符串是否为空
+ (BOOL)judgeStringExist:(id)string;

//  判断数组里的字符串是否都存在
+ (BOOL)judgeStringExistFromArray:(NSArray *)array;

//  判断dict中是否包含某字段
+ (BOOL)judgeDictHaveStr:(NSString *)keyStr dict:(NSDictionary *)dict;

//  从URL获取图片
+ (UIImage *)getImageFromURL:(NSString *)imageURL;

//  修改iamge尺寸
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize;
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize opaque:(BOOL)opaque;

// 对View截屏
+ (UIImage *)convertViewToImage:(UIView *)view;

//  图片合成
+ (UIImage *)imageSynthesisWithImage1:(UIImage *)image1 image2:(UIImage *)image2 size:(CGSize)size;

//  验证姓名
+ (BOOL)validateNameString:(NSString *)nameStr;

//  验证手机号码
+ (BOOL)validatePhoneString:(NSString *)phoneStr;

/**
 *  Block Demo
 */
+ (void)requestClearMessage:(NSNumber *)notificationId success:(void (^) (void))success failure:(void (^) (void))failure;

//  延时block
+ (void)delayAfter:(CGFloat)delayTime dealBlock:(void (^)(void))dealBlock;

//  获取随机颜色
+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

//  获取当前页ViewController
+ (id)getCurrentViewController;

/***** Nav Push *****/

//  获取naviVC中指定类型的VC
+ (id)fetchVCWithClassName:(NSString *)className inNaviVC:(UINavigationController *)naviVC;

//  pop到指定的VC，如果controllers不存在该VC，pop到RootVC
+ (void)popToDestinationVC:(UIViewController *)destionationVC inVC:(UIViewController *)nowVC;

//  pop到指定的VC，如果controllers不存在该VC，pop到RootVC
+ (void)popToDestinationVCClassName:(NSString *)destionationVCClassName inVC:(UIViewController *)nowVC;

//  pop到指定的VC，如果controllers不存在该VC，pop到RootVC
+ (BOOL)findAndpopToDestinationVCClassName:(NSString *)destionationVCClassName inVC:(UIViewController *)nowVC;

//  pop到指定数量的的VC，如果num超过controllers数量，pop到RootVC
+ (void)popOverNum:(int)num inVC:(UIViewController *)nowVC;

//  获取指定VC的相通Navi下的前一个VC
+ (id)getAheadVCInVC:(UIViewController *)inVC;

//  判断是否存在字符串
+ (BOOL)theString:(NSString *)string containsString:(NSString*)other;

/**
 *  将指定VC从Navi数组中移出
 *
 *  @param removeVC 被移除的VC，或VCname
 *  @param navVC    navVC
 */
+ (void)removeVC:(id)removeVC inNavVC:(UINavigationController *)navVC;

/**
 *  将指定VC插入到Navi数组中
 *
 *  @param insertVC 被插入的VC
 *  @param navVC    navVC
 */
+ (void)insertVC:(UIViewController *)insertVC inNavVC:(UINavigationController *)navVC atIndex:(NSInteger)index;

/** 字符串解析成字典
 *
 *  参考解析数据
 *  para_1=1&para_2=2
 */
+ (NSDictionary *)convertParaStrToDict_paraStr:(NSString *)paraStr;

//  frame转换成bounds
+ (CGRect)convertFrameToBounds_frame:(CGRect)frame;

/**
 *  循环测试
 *
 *  @param during     循环间隔
 *  @param eventBlock block事件
 */
+ (void)loopTestDuring:(CGFloat)during eventBlock:(void (^)(void))eventBlock;

//  imageView设置tintColor
+ (void)imageView:(UIImageView *)imageView setImage:(UIImage *)image tintColor:(UIColor *)tintColor;

/**
 *  创建渐变layer
 *
 *  @param fromColor    渐变起始颜色
 *  @param toColor      渐变终止颜色
 *  @param axis         渐变方向
 *                      kLAYOUT_AXIS_Y:从上向下渐变
 *                      kLAYOUT_AXIS_X:从左向右渐变
 */
//  创建渐变layer
+ (CAGradientLayer *)generateGradientLayerWithRect:(CGRect)rect
                                         fromColor:(UIColor *)fromColor
                                           toColor:(UIColor *)toColor
                                              axis:(kLAYOUT_AXIS)axis;

//  计算时间差
+ (NSDateComponents *)caculateDateDValueFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

//  校验数组和对应索引是否越界
+ (BOOL)validateArray:(NSArray *)array index:(NSInteger)index;

//  在主线程处理
+ (void)processInMainThreadWithBlock:(void (^)(void))block;

+ (BOOL)isDebug;
+ (BOOL)isRelease;

+ (void)debug:(void (^)(void))debug release:(void (^)(void))release;

+ (void)resignCurrentFirstResponder;

//  判断是否为pad
+ (BOOL)getIsIpad;

//  判断是否为X系列（带刘海）
+ (BOOL)getIsXSeries;

//  获取启动图
+ (UIImage *)getLaunchImage;
/** 支持iPhone和iPad， 获取app的icon图标名称 */
+ (UIImage *)getAppIconImage;

//通过urlStr解析出参数
+ (NSDictionary *)getUrlParams:(NSString *)urlStr;

/**
 * 图片压缩到指定大小
 * @param targetSize 目标图片的大小
 * @param sourceImage 源图片
 * @return 目标图片
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage;

// 生成基本的DeviceInfo
+ (void)generateDeviceInfoBaseInDict:(NSMutableDictionary *)finalParaDict;

@end





