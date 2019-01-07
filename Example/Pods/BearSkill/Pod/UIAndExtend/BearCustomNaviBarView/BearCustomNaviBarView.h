//
//  BearCustomNaviBarView.h
//  JKZJ
//
//  Created by apple on 16/11/4.
//  Copyright © 2016年 Yuntu Technologies (Hangzhou) Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BearSkill/BearBaseViewController.h>

@interface BearCustomNaviBarView : UIView

@property (strong, nonatomic) UILabel   *titleLabel;
@property (strong, nonatomic) UIButton  *popBtn;
@property (weak, nonatomic) BearBaseViewController *inVC;
@property (strong, nonatomic) UIColor  *popBtnColor;
@property (strong, nonatomic) UIColor  *titleColor;

+ (BearCustomNaviBarView *)commonNaviBarView;

- (void)relayUI;
- (void)setTitleString:(NSString *)titleString;

#pragma mark - Usage
- (void)Usage;

@end
