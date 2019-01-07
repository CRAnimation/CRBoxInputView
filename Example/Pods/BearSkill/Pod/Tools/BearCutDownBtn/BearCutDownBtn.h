//
//  BearCutDownBtn.h
//

#import <UIKit/UIKit.h>
@class BearCutDownBtn;

@protocol BearCutDownBtnDelegate <NSObject>

- (void)cutDownBtnTitleHasChanged:(BearCutDownBtn *)cutdown;

@end

@interface BearCutDownBtn : UIButton

@property (weak, nonatomic) id <BearCutDownBtnDelegate> delegate;
@property (strong, nonatomic) NSString *btnStringNormal;
@property (strong, nonatomic) NSString *btnStringUnEnable;
@property (strong, nonatomic) NSString *btnStringRetry;
@property (assign, nonatomic) NSTimeInterval totalSecond;
@property (assign, nonatomic) BOOL autoSizeToFit;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (void)startCutDown;

@end
