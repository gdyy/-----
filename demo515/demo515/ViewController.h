//
//  ViewController.h
//  demo515
//
//  Created by 于岳 on 14-5-15.
//  Copyright (c) 2014年 HIMa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *remove;

- (IBAction)add:(UIBarButtonItem *)sender;
- (IBAction)remove:(UIBarButtonItem *)sender;

@end
