//
//  ViewController.m
//  分页
//
//  Created by 于岳 on 14-5-17.
//  Copyright (c) 2014年 HIMa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建scrollView
	_scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:_scrollView];
    
    //设置scrollview的属性
    _scrollView.frame =self.view.bounds;
    _scrollView.backgroundColor =[UIColor grayColor];
    _scrollView.contentSize =CGSizeMake(self.view.bounds.size.width*5, 0);
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces=NO;
    //创建imageview
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    for (int i=1; i<6; i++) {
        NSString *imageName = [NSString stringWithFormat:@"pages.bundle/%d.jpg",i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image =image;
        imageView.frame =CGRectMake(width*(i-1), 0, width, height);
        [_scrollView addSubview:imageView];
    }
    //创建pageControl
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages=5;
    _pageControl.bounds = CGRectMake(0, 0, 100, 20);
    _pageControl.center =CGPointMake(width*0.5, height-50);
    _pageControl.backgroundColor=[UIColor clearColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [_pageControl addTarget:self action:@selector(click) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    _scrollView.delegate =self;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/self.view.bounds.size.width;
}
-(void)click{
    [UIView animateWithDuration:0.1 animations:^{
        _scrollView.contentOffset =CGPointMake(_pageControl.currentPage*self.view.bounds.size.width, 0);
    }];
}
@end
