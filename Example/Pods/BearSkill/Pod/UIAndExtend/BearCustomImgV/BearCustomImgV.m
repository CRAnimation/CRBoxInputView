//
//  BearCustomImgV.m
//  BiZhi
//
//  Created by Chobits on 2017/11/9.
//  Copyright © 2017年 Chobits. All rights reserved.
//

#import "BearCustomImgV.h"
#import "UIImageView+WebCache.h"

@interface BearCustomImgV ()
{
    NSURL *_imgUrl;
}
@end

@implementation BearCustomImgV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initPara];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initPara];
    }
    
    return self;
}

- (void)initPara
{
    _trainsitionDuring = 0.5;
    _needTrainsition = NO;
}

#pragma mark - Load Image
- (void)setImageWithURL:(NSURL *)imgUrl
{
    [self setImageWithURL:imgUrl placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage
{
    _imgUrl = imgUrl;
    
    NSData *imageData = [self imageDataFromDiskCacheWithKey:imgUrl.absoluteString];
    
    __weak typeof(self) weakSelf = self;
    
    if (imageData) {
        [self loadImageWithData:imageData needTrainsition:_needTrainsition];
    }else{
        if (placeholderImage) {
            self.image = placeholderImage;
        }
        
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imgUrl
                                                              options:0
                                                             progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                
                                                                [[[SDWebImageManager sharedManager] imageCache] storeImage:image
                                                                                                                 imageData:data
                                                                                                                    forKey:imgUrl.absoluteString
                                                                                                                    toDisk:YES
                                                                                                                completion:nil];
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    if ([imgUrl.absoluteString isEqualToString:self->_imgUrl.absoluteString]) {
                                                                        [weakSelf loadImageWithData:data needTrainsition:YES];
                                                                    }
                                                                });
                                                            }];
    }
}

- (void)loadImageWithData:(NSData *)imageData needTrainsition:(BOOL)needTrainsition
{
    [self loadImageWithImage:[UIImage imageWithData:imageData] needTrainsition:needTrainsition];
}

- (void)loadImageWithImage:(UIImage *)image needTrainsition:(BOOL)needTrainsition
{
    if (needTrainsition) {
        CATransition *trainsition = [CATransition animation];
        trainsition.duration = _trainsitionDuring;
        trainsition.type = kCATransitionFade;
        [self.layer addAnimation:trainsition forKey:nil];
        
        self.image = image;
    }else{
        self.image = image;
    }
}

- (NSData *)imageDataFromDiskCacheWithKey:(NSString *)key {
    
    NSString *path = [[[SDWebImageManager sharedManager] imageCache] defaultCachePathForKey:key];
    return [NSData dataWithContentsOfFile:path];
}

@end
