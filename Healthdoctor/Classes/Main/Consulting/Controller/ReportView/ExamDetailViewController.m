//
//  ExamDetailViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/8.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ExamDetailViewController.h"
#import "ReportView.h"
#import "Define.h"
#import "DepartmentModel.h"
#import "CheckItemModel.h"
#import "ResultModel.h"
#import "ExamExceptionsViewController.h"

@interface ExamDetailViewController ()

@end

@implementation ExamDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kSetRGBColor(250, 250, 250);
    
    ReportView *reportView = [[ReportView alloc] initWithFrame:CGRectMake(0,0, kScreenSizeWidth, kScreenSizeHeight - 64 - 40)];
    reportView.dataArr = self.dataArr;
    [self.view addSubview:reportView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
