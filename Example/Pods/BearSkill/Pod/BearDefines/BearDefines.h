//
//  BearDefines.h
//  Pods
//
//  Created by apple on 2017/3/15.
//
//

#ifndef BearDefines_h
#define BearDefines_h

/**
 *  判断系统版本
 *
 *
 */
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define iOSVersion  [[[UIDevice currentDevice] systemVersion] floatValue]
#define over_iOS6   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define over_iOS7   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define over_iOS8   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define over_iOS9   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define over_iOS10  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define over_iOS11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define over_iOS12  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0)


#define KeyWindow [[UIApplication sharedApplication] keyWindow]

/**
 *  RGB
 */

#define RGB(r, g, b)                [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define RGBAlpha(r, g, b, alpha)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:alpha]
#define UIColorFromHEX(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  UserDefaults
 *
 *  UDGET       获取UserDefaults数据
 *  UDGET_HARD  获取UserDefaults原始数据
 *  USSET       设置UserDefaults数据
 *  UDDELETE    删除UserDefaults数据
 */
#define UDGET(key)          [[NSUserDefaults standardUserDefaults] objectForKey:key]? [[NSUserDefaults standardUserDefaults] objectForKey:key] : @""
#define UDGET_HARD(key)     [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define UDSET(value, key)   [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
#define UDDELETE(key)       [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
#define UDSYNCHRONIZE       [[NSUserDefaults standardUserDefaults] synchronize]

//  AppDelegate
#define MY_APP_Delegate  (AppDelegate *)[[UIApplication sharedApplication] delegate]

//  屏幕宽高
#define WIDTH ([UIScreen  mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen  mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/**
 *  屏幕尺寸
 */

//  X (物理点)
#define WIDTHX 375.0
#define HEIGHTX 812.0

//  X_N (像素点)
#define NWIDTHX 1125.0
#define NHEIGHTX 2436.0

//  6p (物理点)
#define WIDTH6P 414.0
#define HEIGHT6P 736.0

//  6p_N (像素点)
#define NWIDTH6P 1242.0
#define NHEIGHT6P 2208.0


//  6
#define WIDTH6 375.0
#define HEIGHT6 667.0

//  6_N
#define NWIDTH6 750.0
#define NHEIGHT6 1334.0


//  5 | 5c | 5s
#define WIDTH5 320.0
#define HEIGHT5 568.0

//  5 | 5c | 5s _N
#define NWIDTH5 640.0
#define NHEIGHT5 1136.0


//  4|4s
#define WIDTH4 320.0
#define HEIGHT4 480.0

//  4|4s _N
#define NWIDTH4 640.0
#define NHEIGHT4 960.0


//  适配对应 高度 < 5高度时，高度 = 5高度
#define LayOutHeight  ((HEIGHT < HEIGHT5) ? HEIGHT5 : HEIGHT)

//  物理点 为单位
#define XX_4(value)     (1.0 * (value) * WIDTH / WIDTH4)
#define XX_5(value)     (1.0 * (value) * WIDTH / WIDTH5)
#define XX_6(value)     (1.0 * (value) * WIDTH / WIDTH6)
#define XX_6P(value)    (1.0 * (value) * WIDTH / WIDTH6P)
#define XX_X(value)    (1.0 * (value) * WIDTH / WIDTHX)

#define YY_4(value)     (1.0 * (value) * LayOutHeight / HEIGHT4)
#define YY_5(value)     (1.0 * (value) * LayOutHeight / HEIGHT5)
#define YY_6(value)     (1.0 * (value) * LayOutHeight / HEIGHT6)
#define YY_6P(value)    (1.0 * (value) * LayOutHeight / HEIGHT6P)
#define YY_X(value)    (1.0 * (value) * LayOutHeight / HEIGHTX)


//  ceil天花板 物理点 为单位
#define XXC_4(value)     ceil(XX_4(value))
#define XXC_5(value)     ceil(XX_5(value))
#define XXC_6(value)     ceil(XX_6(value))
#define XXC_6P(value)    ceil(XX_6P(value))
#define XXC_X(value)    ceil(XX_X(value))

#define YYC_4(value)     ceil(YY_4(value))
#define YYC_5(value)     ceil(YY_5(value))
#define YYC_6(value)     ceil(YY_6(value))
#define YYC_6P(value)    ceil(YY_6P(value))
#define YYC_X(value)    ceil(YY_X(value))


//  像素点 为单位
#define XX_4N(value)     (1.0 * (value) * WIDTH / NWIDTH4)
#define XX_5N(value)     (1.0 * (value) * WIDTH / NWIDTH5)
#define XX_6N(value)     (1.0 * (value) * WIDTH / NWIDTH6)
#define XX_6PN(value)    (1.0 * (value) * WIDTH / NWIDTH6P)
#define XX_XN(value)    (1.0 * (value) * WIDTH / NWIDTHX)

#define YY_4N(value)     (1.0 * (value) * LayOutHeight / NHEIGHT4)
#define YY_5N(value)     (1.0 * (value) * LayOutHeight / NHEIGHT5)
#define YY_6N(value)     (1.0 * (value) * LayOutHeight / NHEIGHT6)
#define YY_6PN(value)    (1.0 * (value) * LayOutHeight / NHEIGHT6P)
#define YY_XN(value)    (1.0 * (value) * LayOutHeight / NHEIGHTX)


//  ceil天花板 像素点 为单位
#define XXC_4N(value)     ceil(XX_4N(value))
#define XXC_5N(value)     ceil(XX_5N(value))
#define XXC_6N(value)     ceil(XX_6N(value))
#define XXC_6PN(value)    ceil(XX_6PN(value))
#define XXC_XN(value)    ceil(XX_X(value))

#define YYC_4N(value)     ceil(YY_4N(value))
#define YYC_5N(value)     ceil(YY_5N(value))
#define YYC_6N(value)     ceil(YY_6N(value))
#define YYC_6PN(value)    ceil(YY_6PN(value))
#define YYC_XN(value)    ceil(YY_X(value))


//  Scale Based on Width
#define WidthBasedScale(value)              floor(XX_6(value))

//  tabbar高度
#define TABBAR_HEIGHT   self.tabBarController.tabBar.frame.size.height

//  状态栏高度
#define STATUS_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height

//  Navigationbar高度
#define NAVIGATIONBAR_HEIGHT self.navigationController.navigationBar.frame.size.height

//  Navigationbar高度
#define NAV_44 44

//  Nav+Status
#define NAV_STA (NAVIGATIONBAR_HEIGHT + STATUS_HEIGHT)

//  Nav+Status
#define NAV44_STA (NAV_44 + STATUS_HEIGHT)

//  int 转换 NSNumber
#define IntToNumber(int) [NSNumber numberWithInt:int]

//  Font
#define SystemFont(value)       [UIFont systemFontOfSize:value]
#define FontSize(value)         [UIFont systemFontOfSize:(CGFloat)floor(value)]
#define FontSize_4(value)       FontSize(XX_4(value))
#define FontSize_5(value)       FontSize(XX_5(value))
#define FontSize_6(value)       FontSize(XX_6(value))
#define FontSize_6P(value)      FontSize(XX_6P(value))
#define FontSize_X(value)      FontSize(XX_X(value))

#define FontSize_4N(value)       FontSize(XX_4(value / 3.0))
#define FontSize_5N(value)       FontSize(XX_5(value / 3.0))
#define FontSize_6N(value)       FontSize(XX_6(value / 3.0))
#define FontSize_6PN(value)      FontSize(XX_6P(value / 3.0))
#define FontSize_X(value)      FontSize(XX_X(value / 3.0))

#define FontSize_4N_2(value)       FontSize(XX_4(value / 2.0))
#define FontSize_5N_2(value)       FontSize(XX_5(value / 2.0))
#define FontSize_6N_2(value)       FontSize(XX_6(value / 2.0))
#define FontSize_6PN_2(value)      FontSize(XX_6P(value / 2.0))
#define FontSize_X_2(value)      FontSize(XX_X(value / 2.0))

#define BoldSysFont(value)                  [UIFont boldSystemFontOfSize:value]
#define WidthBasedScaleSysFont(value)       SystemFont(WidthBasedScale(value))
#define WidthBasedScaleBoldFont(value)      BoldSysFont(WidthBasedScale(value))

/**
 *  Bear自定义log
 */
#define ShowBearLog 1
#if ShowBearLog
//#define BearLog(FORMAT, ...) fprintf(stderr,"=====  Bear Log  =====\t\t%s:%d\n%s\n\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#define BearLog(FORMAT, ...) fprintf(stderr,"== Bear ==\t%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define BearLog(FORMAT, ...)
#endif

#endif /* BearDefines_h */
