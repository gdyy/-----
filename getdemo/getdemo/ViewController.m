//
//  ViewController.m
//  getdemo
//
//  Created by 于岳 on 14-7-1.
//  Copyright (c) 2014年 inspire. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *_responseData;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if (_responseData==nil) {
        _responseData = [NSMutableData data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_responseData appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *dataString = [[NSString alloc]initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSLog(@"返回的数据：：：：%@",dataString);
    _responseData=nil;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"链接失败信息%@",error);
    _responseData=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getBtn:(UIButton *)sender {
    NSString *urls = [[NSString stringWithFormat:@"http://192.168.0.107:8080/utils/servlet/RequestTest?username=%@&password=%@",_username.text,_password.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urls];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *con = [NSURLConnection connectionWithRequest:request delegate:self];
    [con start];
}

- (NSMutableURLRequest *)postLogin {
    NSString *stringUrl = [NSString stringWithFormat:@"http://192.168.0.107:8080/utils/servlet/RequestTest"];
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *post = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3.0];
    post.HTTPMethod=@"post";
    NSString *postData = [NSString stringWithFormat:@"username=%@&password=%@",_username.text,_password.text];
    NSData *data = [postData dataUsingEncoding:NSUTF8StringEncoding];
    post.HTTPBody=data;
    return post;
}

- (IBAction)postBtn:(UIButton *)sender {
    NSMutableURLRequest *post;
    post = [self postLogin];
    NSURLConnection *con = [NSURLConnection connectionWithRequest:post delegate:self];
    [con start];
}

- (IBAction)syn:(UIButton *)sender {
    NSMutableURLRequest *request = [self postLogin];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error!=nil) {
        
        NSLog(@"返回数据出错%@",[error localizedDescription]);
        return;
    }
    if (data!=nil) {
        NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"返回的数据：%@",dataString);
    }else{
        NSLog(@"没有返回数据");
    }
}

- (IBAction)asyn:(id)sender {
    NSMutableURLRequest *request = [self postLogin];
    
   [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
       if (data!=nil&&error==nil) {
           NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"返回的数据：%@",dataString);
       }else if (error==nil){
           NSLog(@"没有返回数据");
       }else if (error!=nil){
           NSLog(@"返回数据出错%@",[error localizedDescription]);
       }
    }];
}
@end
