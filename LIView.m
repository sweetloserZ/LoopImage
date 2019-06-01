//
//  LIView.m
//  test
//
//  Created by sweetloser on 2019/5/31.
//  Copyright © 2019 sweetloser. All rights reserved.
//

#import "LIView.h"

@interface LIView()<UIScrollViewDelegate>
{
    //轮播图片数组
@private
    NSMutableArray *LIImageArr;
    UIScrollView *LIScrollV;
    UIPageControl *LIPageControl;
}
@end


@implementation LIView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(LIView *)CreatLoopImageView:(CGRect)rect Images:(NSArray<UIImage *> *)images;
{
    LIView *li = [[LIView alloc] initWithFrame:rect];
    
    [li CreateImageArr:images];
    
    [li CreateScrollView:rect.size];
    
    [li CreatePageControl];
    
    return li;
}

//创建图片数组
-(void)CreateImageArr:(NSArray *)images;
{
    
    LIImageArr = [NSMutableArray arrayWithArray:images];
    
    [LIImageArr insertObject:[images lastObject] atIndex:0];
    
    [LIImageArr addObject:[images firstObject]];
    
}

//创建scrollview
-(void)CreateScrollView:(CGSize )picSize;
{
    LIScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, picSize.width, picSize.height)];
    
    //设置contentsize     （高度设置为 0 ，禁止纵向滑动。
    float w = picSize.width * LIImageArr.count;
//    float h = picSize.height;
    [LIScrollV setContentSize:CGSizeMake(w, 0)];
    
    //设置初始偏移
    [LIScrollV setContentOffset:CGPointMake(picSize.width, 0) ];
    
    //分页显示
    [LIScrollV setPagingEnabled:YES];
    
    for (int i=0;i<LIImageArr.count;i++) {
        UIImage *img = LIImageArr[i];
        UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
        
        float imgVX = i * LIScrollV.frame.size.width;
        float imgVY = 0;
        float imgVW = LIScrollV.frame.size.width;
        float imgVH = LIScrollV.frame.size.height;
        CGRect imgVRect = CGRectMake(imgVX, imgVY, imgVW, imgVH);
        
        [imgV setFrame:imgVRect];
        
        [LIScrollV addSubview:imgV];
    }
    
    //取消底部滑块
    [LIScrollV setShowsHorizontalScrollIndicator:NO];
    
    
    //设置代理
    [LIScrollV setDelegate:self];
    
    //将scrollview添加到视图上
    [self addSubview:LIScrollV];
}

//创建pageControl
-(void)CreatePageControl;
{
    //设置pc位置
    float LIPC_CenterX = LIScrollV.frame.size.width / 2;
    float LIPC_CenterY = LIScrollV.frame.size.height - 30;
    float LIPC_W = LIScrollV.frame.size.width * 0.8;
    float LIPC_H = 50;
    LIPageControl = [[UIPageControl alloc] init];
    [LIPageControl setCenter:CGPointMake(LIPC_CenterX, LIPC_CenterY)];
    [LIPageControl setBounds:CGRectMake(0, 0, LIPC_W, LIPC_H)];
    
    [LIPageControl setNumberOfPages:LIImageArr.count-2];
    
    //设置选中和非选中圆点的颜色
    [LIPageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    [LIPageControl setCurrentPageIndicatorTintColor:[UIColor lightGrayColor]];
    
    [self addSubview:LIPageControl];
    
    
}

-(instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
    }
    return self;
}


#pragma mark - scrollview代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    //获取当前页
    float SCV_W = scrollView.frame.size.width;
    
    NSInteger pcurrentPage = scrollView.contentOffset.x / SCV_W;
    
    if (pcurrentPage == LIImageArr.count-1/*当往右滑到最后一张时，无动画切换到第一张*/) {
        [scrollView setContentOffset:CGPointMake(SCV_W, 0)];
        LIPageControl.currentPage = 0;
    }else if (pcurrentPage == 0/*往左滑到最前面时，无动画切换到最后一张*/){
        [scrollView setContentOffset:CGPointMake(SCV_W * (LIImageArr.count-2), 0)];
        LIPageControl.currentPage = LIImageArr.count - 2;
    }else{
        LIPageControl.currentPage = pcurrentPage-1;
    }
}


@end
