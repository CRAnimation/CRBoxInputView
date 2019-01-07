
//
//  UITextField+BearLimitLength.m
//  Pods
//
//  Created by apple on 16/6/8.
//
//

#import "UITextField+BearLimitLength.h"
#import <objc/runtime.h>
#import <objc/message.h>

static const void *limitLengthKey = &limitLengthKey;
static const void *limitBlockKey = &limitBlockKey;

@implementation UITextField (BearLimitLength)


//  limitLength set&get
- (NSNumber *)limitLength
{
    return objc_getAssociatedObject(self, limitLengthKey);
}

- (void)setLimitLength:(NSNumber *)limitLength
{
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addLimitLengthObserver:[limitLength intValue]];
}


//  limitBlock set&get
- (LimitDone_Block)limitDone_block
{
    return objc_getAssociatedObject(self, limitBlockKey);
}

- (void)setLimitDone_block:(LimitDone_Block)limitDone_block
{
    objc_setAssociatedObject(self, limitBlockKey, limitDone_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


//  增加限制位数的通知
- (void)addLimitLengthObserver:(int)length
{
    [self addTarget:self action:@selector(limitLengthEvent) forControlEvents:UIControlEventEditingChanged];
}

//  限制输入的位数
- (void)limitLengthEvent
{
    if ([self.text length] >= [self.limitLength intValue]) {
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
        
        if (self.limitDone_block) {
            self.limitDone_block();
        }
    }
}


//  dealloc替换
//  参考：https://github.com/zhigang1992/ZGParallelView/issues/8
+ (void)load
{
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], @selector(my_dealloc));
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)my_dealloc
{
    // do your logic here
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
    
    //this calls original dealloc method
    [self my_dealloc];
}

@end
