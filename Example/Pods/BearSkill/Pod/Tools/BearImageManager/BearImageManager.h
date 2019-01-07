//
//  BearImageManager.h
//  ADViewPod
//
//  Created by Chobits on 2018/1/12.
//

#import <Foundation/Foundation.h>

@interface BearImageManager : NSObject

- (void)getImageWithUrl:(NSURL *)url getImage:(void (^)(UIImage *image))getImage;

- (UIImage *)generateImageWithFrame:(CGRect)frame originImage:(UIImage *)originImage;
- (UIImage *)normalizedImageWithOriginImage:(UIImage *)originImage;

@end
