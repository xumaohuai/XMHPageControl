//
//  XMHPageControl.m
//  XMHPageControl
//
//  Created by 徐茂怀 on 15/11/17.
//  Copyright © 2015年 徐茂怀. All rights reserved.
//

#import "XMHPageControl.h"

@implementation XMHPageControl

-(instancetype)initWithFrame:(CGRect)frame pageStyle:(XMHPageControlStyle)pageStyle withImageArray:(NSMutableArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _pageBackgroundColor = [UIColor grayColor];
        _selectedColor = [UIColor blackColor];
        _pageSpace = 10;//默认的点的空隙
        _pageStyle = pageStyle;
        _currentPageNumber = 0;
        _imageArray = [NSMutableArray arrayWithArray:imageArray];
        
    }
    return self;
}

#pragma mark 重写pageNumber的setter方法
-(void)setPageNumber:(NSInteger)pageNumber
{
    if (_pageNumber != pageNumber) {
        _pageNumber = pageNumber;
        //创建page小点
        //1.获取当前对象的宽
        CGFloat myWidth = self.frame.size.width;
        CGFloat pointWidth = ( myWidth -  (_pageNumber - 1) * _pageSpace) / _pageNumber;
        //2.循环创建图片,添加到self上
        for (NSInteger i = 0; i < _pageNumber; i++) {
            //每个小点
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_pageSpace + pointWidth) * i, 0, pointWidth, pointWidth)];
            
            switch (_pageStyle) {
                case XMHPageControlStyleDefaoult:
                    imageView.layer.cornerRadius = pointWidth / 2.0;
                    imageView.layer.masksToBounds = YES;
                    imageView.image = _imageArray[i];
                    break;
                    case XMHPageControlStyleSquare:
                    break;
                    case XMHPageControlStyleImages:
                    break;
                default:
                    break;
            }
            //为每张图添加tag值
            [  imageView setTag:1000 + i ];
            imageView.backgroundColor = _pageBackgroundColor;
            [self addSubview:imageView];
        }
        //设置被选中的颜色和被选中的点
        UIImageView *imageView = [self.subviews objectAtIndex:_currentPageNumber];
        imageView.backgroundColor = _selectedColor;
    }
}
#pragma mark 设置背景颜色方法
-(void)setPageBackgroundColor:(UIColor *)pageBackgroundColor
{
    _pageBackgroundColor = pageBackgroundColor;
    //子视图不空的情况下遍历修改每张图的颜色
    if (self.subviews.count != 0) {
        for (UIImageView *imageView in self.subviews) {
            imageView.backgroundColor = _pageBackgroundColor;
        }
        //被选中的颜色,防止被覆盖
        UIImageView *imageView = [self.subviews objectAtIndex:_currentPageNumber];
        imageView.backgroundColor = _selectedColor;
    }
}

#pragma mark 被选中的颜色
-(void)setSelectedColor:(UIColor *)selectedColor
{
    if (_selectedColor != selectedColor) {
        _selectedColor = selectedColor;
        //有图的情况下
        if (self.subviews.count) {
            //修改被选中的那张图片的颜色
            UIImageView *imageView = [self.subviews objectAtIndex:_currentPageNumber];
            imageView.backgroundColor = _selectedColor;
        }
    }
}
#pragma mark 设置当前被选中的下标(currentPageNumber)
-(void)setCurrentPageNumber:(NSInteger)currentPageNumber
{
    if (_currentPageNumber != currentPageNumber) {
        
        _currentPageNumber = currentPageNumber;
        //判断当前图片是否已经存在(即pageNumber是否为0)
        if (self.subviews.count) {
            //改变没有被选中的颜色
            for (UIImageView *imageView in self.subviews) {
                imageView.backgroundColor = _pageBackgroundColor;
            }
            UIImageView *imageView = [self.subviews objectAtIndex:_currentPageNumber];
            imageView.backgroundColor = _selectedColor;
            [UIView animateWithDuration:.3 animations:^{
                imageView.transform = CGAffineTransformMakeScale(1.6, 1.6);
            } completion:^(BOOL finished) {
                imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);

            }];
        }
    }
}


@end
