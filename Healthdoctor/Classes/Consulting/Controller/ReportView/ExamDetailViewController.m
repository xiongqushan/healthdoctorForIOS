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
            NSLog(@"________checkItemName:%@",model2.checkItemName);
            for (ResultModel *model3 in model2.checkResults) {
                NSLog(@"_______checkIndexName:%@\n_______resultValue:%@\n_______TextRef:%@\n______unit:%@",model3.checkIndexName,model3.resultValue,model3.textRef,model3.unit);
                if ([model3.resultFlagID integerValue] != 1) {
                    [unusualDataArr addObject:model3];
                }
                
            }
            NSLog(@"********************************************");
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
