//
//  CRListVCCell.h
//  CRBoxInputView_Example
//
//  Created by Chobits on 2019/1/7.
//  Copyright © 2019 BearRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBoxInputModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CRListVCCell : UITableViewCell

- (void)loadDataWithModel:(CRBoxInputModel *)model;

@end

NS_ASSUME_NONNULL_END
