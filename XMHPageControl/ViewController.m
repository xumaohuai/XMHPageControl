//
//  ViewController.m
//  XMHPageControl
//
//  Created by 徐茂怀 on 15/11/17.
//  Copyright © 2015年 徐茂怀. All rights reserved.
//

#import "ViewController.h"
#import "XMHPageControl.h"
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong)XMHPageControl *pageControl;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)NSMutableArray *imageArray;
@end

@implementation ViewController

-(void)loadView
{
    [super loadView];
    _imageArray = [NSMutableArray array];
    for (NSInteger i = 1; i < 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"h%ld.jpg",i]];
        [_imageArray addObject:image];
    }
    //初始化滚动视图
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];

    
    //1)设置滚动的范围(contentSize只负责大小)
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 7, self.view.frame.size.height);
    //2)设置初始的偏移量
    _scrollView.contentOffset = CGPointMake(0, 0);//坐标是相对于滚动视图的
    //3)设置整页滚动
    _scrollView.pagingEnabled = YES;
    //4)隐藏(显示)滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;//showsHorizontalScrollIndicator横向滚动条,showsVerticalScrollIndicator为纵向滚动条,默认值为yes,显示.
    //5)关闭回弹
    _scrollView.bounces = NO;//默认值为yes,允许回弹
    //6)是否允许滚动
    //_scrollView.scrollEnabled = NO;//停留在某一视图不能滚动
    
    //7)设置代理
    _scrollView.delegate = self;
    
    //添加图片
    for (NSInteger i = 1; i <= 7; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((i - 1) * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //为每个imageView添加图片
        imageView.image = _imageArray[i - 1];
        [_scrollView addSubview:imageView];
    }
    
    [self.view addSubview:_scrollView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    _pageControl = [[XMHPageControl alloc]initWithFrame:CGRectMake(50, 600, 300, 20) pageStyle:XMHPageControlStyleDefaoult withImageArray:_imageArray];
    _pageControl.selectedColor = [UIColor blackColor];
    _pageControl.pageBackgroundColor = [UIColor brownColor];
    _pageControl.pageNumber = 7;
    _pageControl.currentPageNumber = 0;

    [self.view addSubview:_pageControl];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 _pageControl.currentPageNumber =   _scrollView.contentOffset.x / self.view.frame.size.width;
}

-(void)changePage
{
    if (_pageControl.currentPageNumber == _pageControl.pageNumber - 1) {
        _pageControl.currentPageNumber = 0;
    }
    else
    {
    _pageControl.currentPageNumber++;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
