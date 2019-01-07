//
//  UITableView+BearStoreCellHeight.h
//  Pods
//
//  Created by apple on 16/5/16.
//
//


//
//  本方法可以方便记录，获取UITableViewCell的高度，尺寸
//

#import <UIKit/UIKit.h>

@interface UITableView (BearStoreCellHeight)

@property (copy, nonatomic) NSMutableDictionary *cellFrameDict;

//  根据indexPath获取对应的高度
//  如果之前没有记录，默认返回10
- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

//  根据indexPath获取对应的frame
//  如果之前没有记录，默认返回(0, 0, 10, 10)
- (CGRect)getFrameForRowAtIndexPath:(NSIndexPath *)indexPath;

//  将cell的frame存储到对应的indexPath
- (void)recordingFrame:(CGRect)frame forRowAtIndexPath:(NSIndexPath *)indexPath;

//  将cell的Height存储到对应的indexPath
- (void)recordingHeight:(CGFloat)height forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
