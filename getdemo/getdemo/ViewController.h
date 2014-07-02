//
//  ViewController.h
//  getdemo
//
//  Created by 于岳 on 14-7-1.
//  Copyright (c) 2014年 inspire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)getBtn:(UIButton *)sender;
- (IBAction)postBtn:(UIButton *)sender;
- (IBAction)syn:(UIButton *)sender;
- (IBAction)asyn:(id)sender;

@end
