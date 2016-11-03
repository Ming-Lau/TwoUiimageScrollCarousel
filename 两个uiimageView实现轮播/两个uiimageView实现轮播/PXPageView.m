//
//  PXPageView.m
//  两个uiimageView实现轮播
//
//  Created by Andrew on 16/4/17.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#define kImgViewWH 10

#import "PXPageView.h"
#import "PXMaskView.h"


@interface PXPageView ()

@property (strong, nonatomic) NSMutableArray *maskArray;


@property (strong, nonatomic) PXMaskView *maskView;

@end

@implementation PXPageView

- (NSMutableArray *)maskArray
{
    if (!_maskArray) {
        _maskArray = [NSMutableArray array];
    }
    return _maskArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setImgArray:(NSArray *)imgArray
{
    _imgArray = imgArray;
    for (int i = 0; i < self.imgArray.count; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kImgViewWH, 0, kImgViewWH, kImgViewWH)];
        imgView.image = self.imgArray[i];
        //圆形
        imgView.layer.cornerRadius = imgView.frame.size.height / 2;
        imgView.layer.masksToBounds = YES;
        UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kImgViewWH, kImgViewWH)];
        mask.backgroundColor = [UIColor blackColor];
        mask.alpha = 0.5f;
        
        //圆形
        mask.layer.cornerRadius = mask.frame.size.height / 2;
        mask.layer.masksToBounds = YES;
        
        [imgView addSubview:mask];
        [self.maskArray addObject:mask];
        [self addSubview:imgView];
    }
}
- (void)setCurrIndex:(NSInteger)currIndex
{
    _currIndex = currIndex;
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    for (int i = 0; i < self.maskArray.count; i ++) {
        UIView *mask = self.maskArray[i];
        mask.hidden = NO;
        if (i == self.currIndex) {
            self.maskView = [[PXMaskView alloc] initWithFrame:CGRectMake(0, 0, kImgViewWH, kImgViewWH)];
            self.maskView.backgroundColor = [UIColor clearColor];
            [mask.superview addSubview:self.maskView];
            mask.hidden = YES;
        }
    }
}

@end
