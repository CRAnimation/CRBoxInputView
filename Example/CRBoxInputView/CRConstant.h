//
//  CRConstant.h
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Masonry.h"
#import <BearSkill/BearSkill.h>

#define CRBOX_UIColorFromHEX(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define color_master CRBOX_UIColorFromHEX(0x313340)

NS_ASSUME_NONNULL_BEGIN

@interface CRConstant : NSObject

@end

NS_ASSUME_NONNULL_END
