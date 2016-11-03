//
//  PXImgScrollView.h
//  两个uiimageView实现轮播
//
//  Created by Andrew on 16/4/17.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXImgScrollView : UIView

/**
 *  图片数组
 */
@property (strong, nonatomic) NSArray *imgeArray;
/**
 *  停留时间
 */
@property (assign, nonatomic) NSTimeInterval time;
/**
 *  分页控件位置
 */
@property (assign, nonatomic) CGRect pageControlPosition;


@end
