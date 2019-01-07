//
//  UITextField+BearLimitLength.h
//  Pods
//
//  Created by apple on 16/6/8.
//
//

#import <UIKit/UIKit.h>

typedef void (^LimitDone_Block)();

@interface UITextField (BearLimitLength)

@property (copy, nonatomic) NSNumber    *limitLength;
@property (copy, nonatomic) LimitDone_Block limitDone_block;

@end
