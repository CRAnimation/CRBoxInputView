//
//  CRBoxFlowLayout.h
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRBoxFlowLayout : UICollectionViewFlowLayout

/** ifNeedEqualGap
 * default: YES
 */
@property (assign, nonatomic) BOOL ifNeedEqualGap;

@property (assign, nonatomic) NSInteger itemNum;

- (void)autoCalucateLineSpacing;

@end

NS_ASSUME_NONNULL_END
