//
//  ViewController.m
//  demo515
//
//  Created by 于岳 on 14-5-15.
//  Copyright (c) 2014年 HIMa. All rights reserved.
//

#import "ViewController.h"
#define kHeight 44
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //remove按钮初始化不可以点击
    self.remove.enabled=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add:(UIBarButtonItem *)sender {
    //添加新行
    UIView *newRow = [[UIView alloc]init];
    CGFloat width = self.view.bounds.size.width;
   UIView *lastView = [self.view.subviews lastObject];
    CGFloat newRowY = lastView.frame.origin.y+lastView.frame.size.height+1;
    newRow.frame = CGRectMake(width, newRowY, width, kHeight);
    CGRect frame = newRow.frame;
    //为添加按钮添加动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    frame.origin.x=0;
    newRow.frame =frame;
    [UIView commitAnimations];
    newRow.backgroundColor = [UIColor blueColor];
    [self.view addSubview:newRow];
    
    //添加新行后，remove按钮可以被点击
    self.remove.enabled=YES;
    
    //在每行上添加新按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, 44, kHeight);
    int index = arc4random_uniform(29)+1;
    NSString *str = [NSString stringWithFormat:@"%03d.jpg",index];
    UIImage *image = [UIImage imageNamed:str];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [newRow addSubview:btn];
    
}

- (IBAction)remove:(UIBarButtonItem *)sender {
    //拿到所有的子视图
    NSArray *array = [self.view subviews];
    
    //删除最后一个子视图
    UIView *lastView =[array lastObject];
    //为删除按钮添加动画
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = lastView.frame;
        frame.origin.x=self.view.frame.size.width;
        lastView.frame =frame;
    } completion:^(BOOL finished) {
        [lastView removeFromSuperview];
    }];
    //当视图个数大于3的时候，删除按钮才可以被点击
    self.remove.enabled =array.count>3;
}
@end
