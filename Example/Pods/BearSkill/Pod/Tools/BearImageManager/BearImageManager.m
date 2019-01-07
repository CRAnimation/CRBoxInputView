//
//  BearImageManager.m
//  ADViewPod
//
//  Created by Chobits on 2018/1/12.
//

#import "BearImageManager.h"
#import "UIImageView+WebCache.h"

@implementation BearImageManager

- (void)getImageWithUrl:(NSURL *)url getImage:(void (^)(UIImage *image))getImage
{
    NSData *imageData = [self imageDataFromDiskCacheWithKey:url.absoluteString];
    
    if (imageData) {
        if (getImage) {
            getImage([UIImage imageWithData:imageData]);
        }
    }else{
        NSURL *tempURL = url;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url
                                                              options:0
                                                             progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                
                                                                [[[SDWebImageManager sharedManager] imageCache] storeImage:image
                                                                                                                 imageData:data
                                                                                                                    forKey:url.absoluteString
                                                                                                                    toDisk:YES
                                                                                                                completion:nil];
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    if ([url.absoluteString isEqualToString:tempURL.absoluteString]) {
                                                                        if (getImage) {
                                                                            getImage([UIImage imageWithData:data]);
                                                                        }
                                                                    }
                                                                });
                                                            }];
    }
}

- (NSData *)imageDataFromDiskCacheWithKey:(NSString *)key {
    
    NSString *path = [[[SDWebImageManager sharedManager] imageCache] defaultCachePathForKey:key];
    return [NSData dataWithContentsOfFile:path];
}

- (UIImage *)generateImageWithFrame:(CGRect)frame originImage:(UIImage *)originImage
{
    CGFloat rationScale = 1.0 * [UIScreen mainScreen].scale;
    
    CGFloat origX = frame.origin.x * rationScale;
    CGFloat origY = frame.origin.y * rationScale;
    CGFloat oriWidth = frame.size.width * rationScale;
    CGFloat oriHeight = frame.size.height * rationScale;
    
    CGRect myRect = CGRectMake(origX, origY, oriWidth, oriHeight);
    
    CGImageRef  imageRef = CGImageCreateWithImageInRect(originImage.CGImage, myRect);
    UIGraphicsBeginImageContextWithOptions(myRect.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myRect, imageRef);
    UIImage * clipImage = [UIImage imageWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    
    return clipImage;
}

- (UIImage *)normalizedImageWithOriginImage:(UIImage *)originImage
{
    UIImageOrientation imageOrientation = originImage.imageOrientation;
    if (imageOrientation == UIImageOrientationUp) return originImage;
    
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, originImage.scale);
    [originImage drawInRect:(CGRect){0, 0, originImage.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

@end
