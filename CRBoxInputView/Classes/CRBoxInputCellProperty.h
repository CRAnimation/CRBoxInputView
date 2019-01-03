//
//  CRBoxInputCellProperty.h
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRBoxInputCellProperty : NSObject

@property (nonatomic, strong) UIColor *cellBorderColorNormal;
@property (nonatomic, strong) UIColor *cellBorderColorSelected;
@property (nonatomic, strong) UIColor *cellBgColor;
@property (nonatomic, strong) UIColor *cellCursorColor; //光标颜色
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;

// label
@property (strong, nonatomic) UIFont *cellFont;
@property (nonatomic, strong) UIColor *cellTextColor;

@end

NS_ASSUME_NONNULL_END
