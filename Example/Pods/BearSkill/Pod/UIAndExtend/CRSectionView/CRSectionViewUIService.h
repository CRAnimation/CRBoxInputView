//
//  CRSectionViewUIService.h
//  BiZhi
//
//  Created by Chobits on 2017/9/18.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CRSectionViewUIService;

typedef void (^DidSelectIndexPath) (NSIndexPath *indexPath);

@protocol CRSectionViewUIServiceDelegate <NSObject>

@optional
- (void)CRSectionDidSelectIndexPath:(NSIndexPath *)indexPath __attribute__((deprecated("使用CRSectionUIService")));
- (void)CRSectionUIService:(CRSectionViewUIService *)sectionViewUIService sectionDidSelectIndexPath:(NSIndexPath *)indexPath;

@end

@interface CRSectionViewUIService : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (copy, nonatomic) DidSelectIndexPath didSelectIndexPath;
@property (weak, nonatomic) id <CRSectionViewUIServiceDelegate> delegate;
@property (strong, nonatomic) NSArray *titles;

@end
