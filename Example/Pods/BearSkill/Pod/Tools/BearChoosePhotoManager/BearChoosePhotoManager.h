//
//  BearChoosePhotoManager.h
//  AFNetworking
//
//  Created by Chobits on 2017/11/15.
//

#import <Foundation/Foundation.h>

typedef void (^SelectedImageBlock) (UIImage *image);

@interface BearChoosePhotoManager : NSObject

@property (copy, nonatomic) SelectedImageBlock selectedImageBlock;

- (void)showActionViewInVC:(UIViewController *)inVC;

- (void)presentCameraInVC:(UIViewController *)inVC;
- (void)presentPhotoLibraryInVC:(UIViewController *)inVC;

@end
