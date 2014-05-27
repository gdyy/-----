//
//  ViewController.m
//  QQ好友列表
//
//  Created by 于岳 on 14-5-26.
//  Copyright (c) 2014年 HIMa. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
@interface ViewController ()
{
    NSMutableArray *_array;
    NSMutableDictionary *_dict;
    NSMutableDictionary *_status; //标题状态 0：关，1：开
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   NSString *path =[[NSBundle mainBundle] pathForResource:@"friends.plist"ofType:nil];
    _status = [NSMutableDictionary dictionary];
    _array = [NSMutableArray arrayWithContentsOfFile:path];
    UITableView *tableView = (UITableView *)self.view;
    [tableView setBackgroundColor:[UIColor orangeColor]];
}
#pragma -mark 返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _array.count;
}
#pragma -mark 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int result = [_status[@(section)] intValue];
    if (result==0) {
        return  0;
    }else{
        _dict = _array[section];
        NSMutableArray *friends = _dict[@"friends"];
        return friends.count;
    }
    
}
#pragma -mark 返回每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor orangeColor];
    }
    NSMutableDictionary *dict = _array[indexPath.section];
    NSMutableArray *array = dict[@"friends"];
    NSString *friend =array[indexPath.row];
    cell.textLabel.text =friend;
    return cell;
}


//#pragma -mark 返回每组的头标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSMutableDictionary *dict = _array[section];
//    return dict[@"group"];
//}

#pragma -mark 返回标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
#pragma -mark 返回每组标题视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderView *headerView = [HeaderView buttonWithType:UIButtonTypeCustom];
    NSMutableDictionary *dict = _array[section];
    [headerView setTitle:dict[@"group"] forState:UIControlStateNormal];
    [headerView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    headerView.tag =section;
    [headerView addTarget:self action:@selector(clickSectionTitle:) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}
#pragma -mark 点击标题
-(void)clickSectionTitle:(HeaderView *)headerBtn{
    int section = headerBtn.tag;
    int result = [_status[@(section)] intValue];
    if (result==0) {
        [_status setObject:@1 forKey:@(section)];
    }else{
        [_status setObject:@0 forKey:@(section)];
    }
    /*
     UITableViewRowAnimationFade,
     UITableViewRowAnimationRight,           // slide in from right (or out to right)
     UITableViewRowAnimationLeft,
     UITableViewRowAnimationTop,
     UITableViewRowAnimationBottom,
     UITableViewRowAnimationNone,            // available in iOS 3.0
     UITableViewRowAnimationMiddle,
     */
    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:section];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}
@end
