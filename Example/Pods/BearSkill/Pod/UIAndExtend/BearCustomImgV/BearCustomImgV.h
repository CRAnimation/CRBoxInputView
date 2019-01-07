//
//  BearCustomImgV.h
//  BiZhi
//
//  Created by Chobits on 2017/11/9.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BearCustomImgV : UIImageView

//在切换图片时是否需要过渡效果（Default:NO）
@property (assign, nonatomic) BOOL needTrainsition;
//过渡效果时常（Default:0.5）
@property (assign, nonatomic) CGFloat trainsitionDuring;

- (void)setImageWithURL:(NSURL *)imgUrl;
- (void)setImageWithURL:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage;

- (void)loadImageWithData:(NSData *)imageData needTrainsition:(BOOL)needTrainsition;
- (void)loadImageWithImage:(UIImage *)image needTrainsition:(BOOL)needTrainsition;

//注意，如果需要加Blur毛玻璃效果，建议多套一层View，再处理。
/*
- (void)createTransitionView
{
    _carouselTransitionImgV = [[BearCustomImgV alloc] initWithFrame:self.bounds];
    _carouselTransitionImgV.needTrainsition = YES;
    
    UIView *tempView = [[UIView alloc] initWithFrame:self.bounds];
    [tempView addSubview:_carouselTransitionImgV];
    [tempView blurEffectWithStyle:UIBlurEffectStyleLight Alpha:0.98];
    
    [self addSubview:tempView];
}
*/

@end
