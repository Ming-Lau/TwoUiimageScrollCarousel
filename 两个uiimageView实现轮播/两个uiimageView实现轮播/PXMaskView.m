//
//  PXMaskView.m
//  两个uiimageView实现轮播
//
//  Created by Andrew on 16/4/17.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "PXMaskView.h"

@implementation PXMaskView


//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor grayColor];
//    }
//    return self;
//}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //画弧
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    CGContextAddArc(context, rect.size.width * 0.5, rect.size.width * 0.5, rect.size.width * 0.5, M_PI_4, M_PI_4 + M_PI * 2, 0);
    CGContextStrokePath(context);
    
    
}


@end
