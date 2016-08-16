//
//  ConfirmViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ConfirmViewController.h"

@interface ConfirmViewController ()

@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//关闭
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//确认登录
- (IBAction)confirmLogin:(id)sender {
    NSLog(@"__________确认登录");
}

//取消登录
- (IBAction)cancleLogin:(id)sender {
    NSLog(@"__________取消登录");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
