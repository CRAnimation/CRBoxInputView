//
//  BearFirstScreenAdView.h
//  BiZhi
//
//  Created by Chobits on 2017/9/24.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BearFirstScreenAdViewDelegate <NSObject>
- (void)firstScreenAdViewDidBurnUp;
- (void)firstScreenViewDidClickCloseBtn;
- (void)firstScreenViewDidTapBg;

@end

@interface BearFirstScreenAdView : UIView

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithFrame:(CGRect)frame totalSecond:(int)totalSecond;
- (instancetype)initWithFrame:(CGRect)frame;

@property (weak, nonatomic) id <BearFirstScreenAdViewDelegate> delegate;
@property (strong, nonatomic) UIImageView *contentImageView;

- (void)startCutDown;

@end
