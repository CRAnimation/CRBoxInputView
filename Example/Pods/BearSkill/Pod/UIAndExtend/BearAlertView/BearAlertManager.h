//
//  BearAlertManager.h
//

#import <Foundation/Foundation.h>

@interface BearAlertManager : NSObject<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

typedef void (^ContentTapBlock) (void);
typedef void (^BgTapBlock) (void);

@property (nonatomic, strong) UIView  *contentView;
@property (assign, nonatomic) CGFloat scaleAniamtionDuration;
@property (assign, nonatomic) BOOL  needTapBgToFadeOut;

@property (copy, nonatomic) BgTapBlock bgTapBlock;
@property (copy, nonatomic) ContentTapBlock contentTapBlock;

- (void)createAlertBgViewWithFrame:(CGRect)frame;
- (void)showInViewAndFadeIn:(UIView *)inView;

- (void)fadeOut;
- (void)fadeIn;

#pragma mark - Usage
- (void)Usage;

@end
