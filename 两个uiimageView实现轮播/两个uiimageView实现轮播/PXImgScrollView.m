//
//  PXImgScrollView.m
//  两个uiimageView实现轮播
//
//  Created by Andrew on 16/4/17.
//  Copyright © 2016年 Andrew. All rights reserved.
//




#import "PXImgScrollView.h"
#import "PXPageView.h"

typedef enum{
    DirecNone,
    DirecLeft,
    direcRight
} Direction;

@interface PXImgScrollView () <UIScrollViewDelegate>
/**
 *  ScrollView
 */
@property (strong, nonatomic) UIScrollView *imgScrollView;
/**
 *  梅举变量
 */
@property (assign, nonatomic) Direction direction;
/**
 *  表示当前图片的索引
 */
@property (assign, nonatomic) NSInteger currIndex;
/**
 *  表示下一个显示图片的索引
 */
@property (assign, nonatomic) NSInteger nextIndex;
/**
 *  一直保持在中间那个imageView
 */
@property (strong, nonatomic) UIImageView *currImageView;
/**
 *  将要显示的imageView
 */
@property (strong, nonatomic) UIImageView *otherImageView;
/**
 *  时间戳
 */
@property (strong, nonatomic) NSTimer *timer;
/**
 *  分页UIPageControl
 */
@property (strong, nonatomic) PXPageView *pageView;

@end


@implementation PXImgScrollView 

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        
        //创建一个scrollview
        self.imgScrollView = [[UIScrollView alloc] initWithFrame:frame];
        [self addSubview:self.imgScrollView];
        
        self.imgScrollView.contentSize = CGSizeMake(3 * width, height);
        self.imgScrollView.contentOffset = CGPointMake(width, 0);
        self.imgScrollView.pagingEnabled = YES;
        
        //设置scrollview代理
        self.imgScrollView.delegate = self;
        
        //添加观察者
        [self addObserver:self forKeyPath:@"direction" options:NSKeyValueObservingOptionNew context:nil];
        //一直保持中间的那张图片
        self.currImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
        self.currImageView.backgroundColor = [UIColor redColor];
        
        
        [self.imgScrollView addSubview:self.currImageView];
        
        
        //游离的那张图片
        self.otherImageView = [[UIImageView alloc] init];
        self.otherImageView.backgroundColor = [UIColor grayColor];
        
        
        [self.imgScrollView addSubview:self.otherImageView];
        
        
        //设置分页control
        self.pageView = [[PXPageView alloc] init];

        
        
        
        [self addSubview:self.pageView];
        
        
        
    }
    return self;
}

- (void)setImgeArray:(NSArray *)imgeArray
{
    _imgeArray = imgeArray;
    self.currImageView.image = self.imgeArray[self.currIndex];

    self.pageView.imgArray = self.imgeArray;
    
    
    self.pageView.bounds = CGRectMake(0, 0, 10 * self.imgeArray.count, 10);
    self.pageView.center = CGPointMake(self.frame.size.width * 0.5f, self.frame.size.height + 50 );
    self.pageView.currIndex = self.currIndex;
}

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.direction = scrollView.contentOffset.x > self.frame.size.width ? DirecLeft : direcRight;
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [self pauseScroll];
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark setContentOffset:animated: 方法调用之后，不会调用scrollViewDidEndDecslerating方法，会调用下面这个方法，所以自动滚动后，要使其做复位操作
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self pauseScroll];
}


#pragma mark 使currImageView复位
- (void)pauseScroll
{
    //清空滚动方向
    self.direction = DirecNone;
    //判断最终是滚到了右边还是左边
    int index = self.imgScrollView.contentOffset.x / self.frame.size.width;
    if (index == 1) {
        return;
    }   //等于1表示最后没有滚动，反悔不做任何操作
    self.currIndex = self.nextIndex;    //当前索引改变
    self.currImageView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height); //使currImageView复位
    self.currImageView.image = self.otherImageView.image;
    self.imgScrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
    //要把索引值负给pageControl
    self.pageView.currIndex = self.currIndex;
}


//观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//    NSLog(@"%@", change);
//    NSLog(@"NSKeyValueChangeNewKey------%@", change[NSKeyValueChangeNewKey]);
//    NSLog(@"NSKeyValueChangeOldKey------%@", change[NSKeyValueChangeOldKey]);
    if (change[NSKeyValueChangeNewKey] == change[NSKeyValueChangeOldKey]) {
//        NSLog(@"NSKeyValueChangeNewKey == NSKeyValueChangeOldKey");
        return;
    }
    
    if ([change[NSKeyValueChangeNewKey] intValue] == direcRight) {
        self.otherImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.nextIndex = self.currIndex - 1;
        if (self.nextIndex < 0) {
            self.nextIndex = self.imgeArray.count - 1;
        }
    } else if ([change[NSKeyValueChangeNewKey] intValue] == DirecLeft) {
        self.otherImageView.frame = CGRectMake(2 * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        self.nextIndex = (self.currIndex + 1) % self.imgeArray.count;
    }
    
    self.otherImageView.image = self.imgeArray[self.nextIndex];
    
    
}

//当传入时间时，初始化nstimer
- (void)setTime:(NSTimeInterval)time
{
    _time = time;
    self.timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [self startTimer];
}

#pragma mark 定时器
- (void)startTimer
{
    if (self.imgeArray.count <= 1) {
        return;
    }
    if (self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

//自动滚动
- (void)nextPage
{
    [self.imgScrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:YES];
}



@end
