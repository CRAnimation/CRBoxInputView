//
//  BearCustomButton.m
//  Pods
//
//  Created by apple on 16/9/23.
//
//

#import "BearCustomButton.h"

@implementation BearCustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self crateUI];
        
        _layout_AXIS    = kLAYOUT_AXIS_X;
        _customBtnType  = kCustomBtnType_Image_Label;
        _layoutStyle    = kLayoutStyle_AccrodindToOffPara;
        _off_start      = 0;
        _off_end        = 0;
        _off_gap        = 0;
    }
    
    return self;
}

- (void)crateUI
{
    _btnLabel = [UILabel new];
    _btnLabel.textColor = [UIColor whiteColor];
    _btnLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_btnLabel];
    
    _btnImageV = [UIImageView new];
    [self addSubview:_btnImageV];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self relayUI];
}

- (void)relayUI
{
    [_btnLabel sizeToFit];
    
    //  clean
    [_btnLabel removeFromSuperview];
    [_btnImageV removeFromSuperview];
    
    NSMutableArray *subViewArray = [NSMutableArray new];
    
    switch (_customBtnType) {
        case kCustomBtnType_Label_Image:
        {
            [self addSubview:_btnLabel];
            [self addSubview:_btnImageV];
            
            [subViewArray addObject:_btnLabel];
            [subViewArray addObject:_btnImageV];
        }
            break;
            
        case kCustomBtnType_Image_Label:
        {
            [self addSubview:_btnLabel];
            [self addSubview:_btnImageV];
            
            [subViewArray addObject:_btnImageV];
            [subViewArray addObject:_btnLabel];
            
        }
            break;
            
        case kCustomBtnType_Label:
        {
            [self addSubview:_btnLabel];
            
            [subViewArray addObject:_btnLabel];
        }
            break;
            
        case kCustomBtnType_Image:
        {
            [self addSubview:_btnImageV];
            
            [subViewArray addObject:_btnImageV];
        }
            break;
            
        default:
            break;
    }
    
    switch (_layoutStyle) {
            
        case kLayoutStyle_Idle:
        {
            nil;
        }
            break;
            
        case kLayoutStyle_AccrodindToOffPara:
        {
            [UIView BearAutoLayViewArray:subViewArray layoutAxis:_layout_AXIS center:YES offStart:_off_start offEnd:_off_end gapDistance:_off_gap];
        }
            break;
            
        case kLayoutStyle_CenterLay:
        {
            [UIView BearAutoLayViewArray:subViewArray layoutAxis:_layout_AXIS center:YES gapDistance:_off_gap];
        }
            break;
            
        default:
            break;
    }
    
}



//  参考示例
- (void)demoUse
{
    BearCustomButton *_refreshBtn = [[BearCustomButton alloc] initWithFrame:CGRectMake(0, 0, 75, 20)];
    _refreshBtn.layout_AXIS = kLAYOUT_AXIS_X;
    _refreshBtn.customBtnType = kCustomBtnType_Image_Label;
    _refreshBtn.layoutStyle = kLayoutStyle_AccrodindToOffPara;
    _refreshBtn.off_gap = 5;
    _refreshBtn.btnLabel.text = @"点击刷新";
    _refreshBtn.btnLabel.textColor = [UIColor blueColor];
    _refreshBtn.btnLabel.font = [UIFont systemFontOfSize:40];
    _refreshBtn.btnImageV.image = [UIImage imageNamed:@"test_arrow"];
    [_refreshBtn.btnImageV sizeToFit];
    [self addSubview:_refreshBtn];
}

@end
