//
//  HelpViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/9.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpView.h"
#import "Define.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助";
    
    [self setUpScrollerView];
}

- (void)setUpScrollerView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64)];
    HelpView *helpView = [[[NSBundle mainBundle] loadNibNamed:@"HelpView" owner:self options:nil] lastObject];
    [scrollView addSubview:helpView];
    scrollView.contentSize = CGSizeMake(kScreenSizeWidth, kScreenSizeHeight - 64);
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
