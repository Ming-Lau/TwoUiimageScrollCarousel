//
//  ViewController.m
//  两个uiimageView实现轮播
//
//  Created by Andrew on 16/4/17.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "ViewController.h"
#import "PXImgScrollView.h"
#import "PXMaskView.h"
#define imageCount 8
@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *imgArray;


@end

@implementation ViewController

- (NSMutableArray *)imgArray
{
    if (!_imgArray) {
        _imgArray = [NSMutableArray array];
    }
    return _imgArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (int i = 0 ; i < imageCount; i++) {
        [self.imgArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]]];
    }
    
    PXImgScrollView *imgView = [[PXImgScrollView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 200)];
    
    imgView.imgeArray = self.imgArray;
    imgView.time = 1.5f;
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:imgView];
    
//    PXMaskView *view = [[PXMaskView alloc] initWithFrame:CGRectMake(100, 400, 50, 50)];
//    [self.view addSubview:view];
    
    
}

@end
