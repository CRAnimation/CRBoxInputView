//
//  CRBoxInputModel.h
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CRBoxInputModelType) {
    CRBoxInputModelNormalType,
    CRBoxInputModelCustomBoxType,
    CRBoxInputModelLineType,
    CRBoxInputModelSecretSymbolType,
    CRBoxInputModelSecretImageType,
    CRBoxInputModelSecretViewType,
};

@interface CRBoxInputModel : NSObject

@property (strong, nonatomic) NSString  *name;
@property (strong, nonatomic) NSString  *imageName;
@property (assign, nonatomic) CRBoxInputModelType type;

@end

NS_ASSUME_NONNULL_END
