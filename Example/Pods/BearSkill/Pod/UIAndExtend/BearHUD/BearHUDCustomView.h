//
//  BearHUDCustomView.h
//  Pods
//
//  Created by apple on 2017/5/10.
//
//

#import <UIKit/UIKit.h>

@interface BearHUDCustomView : UIImageView

@property (strong, nonatomic) IBOutlet UIImageView *ringImageV;
@property (strong, nonatomic) IBOutlet UIImageView *moneyImageV;

- (void)startRotationAnimation;

@end
