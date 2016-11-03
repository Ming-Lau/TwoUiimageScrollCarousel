//
//  PXPageView.h
//  两个uiimageView实现轮播
//
//  Created by Andrew on 16/4/17.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXPageView : UIScrollView

@property (strong, nonatomic) NSArray *imgArray;


@property (assign, nonatomic) NSInteger currIndex;

@end
