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

    
    NSMutableArray *unusualDataArr = [NSMutableArray array];
    
    for (DepartmentModel *model in self.dataArr) {
        for (CheckItemModel *model2 in model.checkItmes) {
            for (ResultModel *model3 in model2.checkResults) {
                if ([model3.resultFlagID integerValue] != 1) {
                    [unusualDataArr addObject:model3];
                }
            }
        }
    }

    ReportView *reportView = [[ReportView alloc] initWithFrame:CGRectMake(0,0, kScreenSizeWidth, kScreenSizeHeight - 64 - 40)];

    reportView.dataArr = self.dataArr;
    [self.view addSubview:reportView];
    
    ExamExceptionsViewController *exceptions = [[ExamExceptionsViewController alloc] init];
    exceptions.dataArr = unusualDataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
