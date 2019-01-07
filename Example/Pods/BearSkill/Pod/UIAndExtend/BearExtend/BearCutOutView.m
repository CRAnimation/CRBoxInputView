//
//  BearCutOutView.m
//  TestCutOut
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 qiantu. All rights reserved.
//

#import "BearCutOutView.h"

@interface BearCutOutView ()

@property (nonatomic, retain) UIColor       *unCutColor;
@property (nonatomic, retain) NSValue       *cutOutFrame;
@property (nonatomic, retain) UIBezierPath  *cutOutBezierPath;

@end

@implementation BearCutOutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.unCutColor) {
        
        [self.unCutColor setFill];
        UIRectFill(rect);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
        
        UIBezierPath *path;
        
        if (self.cutOutFrame) {
            path = [UIBezierPath bezierPathWithRect:[self.cutOutFrame CGRectValue]];
        }
        else if (self.cutOutBezierPath){
            path = self.cutOutBezierPath;
        }
        
        [path fill];
        
        CGContextSetBlendMode(context, kCGBlendModeNormal);
    }
}

- (void)setUnCutColor:(UIColor *)unCutColor cutOutFrame:(CGRect)cutOutFrame
{
    self.unCutColor = unCutColor;
    self.cutOutFrame = [NSValue valueWithCGRect:cutOutFrame];
    
    [self setNeedsDisplay];
}

- (void)setUnCutColor:(UIColor *)unCutColor cutOutPath:(UIBezierPath *)cutOutPath
{
    self.unCutColor = unCutColor;
    self.cutOutBezierPath = cutOutPath;
    
    [self setNeedsDisplay];
}

@end
