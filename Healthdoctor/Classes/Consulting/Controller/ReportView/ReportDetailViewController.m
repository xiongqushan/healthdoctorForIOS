//
//  ReportDetailViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportDetailViewController.h"
#import "ReportView.h"
#import "Define.h"
#import "GKSliderView.h"
#import "BasicInfoViewController.h"
#import "ExamDetailViewController.h"
#import "ExamSummaryViewController.h"
#import "ExamExceptionsViewController.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "HZUtils.h"
#import "DepartmentModel.h"
#import "SummarysModel.h"
#import "ResultModel.h"
#import "ReportInfoModel.h"

@interface ReportDetailViewController ()
@property (nonatomic ,strong)NSMutableArray *detailDataArr;
@property (nonatomic, strong)NSMutableArray *summaryDataArr;
@property (nonatomic, strong)NSMutableArray *unusualDataArr;
@property (nonatomic, strong)ReportInfoModel *infoModel;

@property (nonatomic, copy)NSString *masterDoctor;
@end

@implementation ReportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailDataArr = [NSMutableArray array];
    self.summaryDataArr = [NSMutableArray array];
    self.unusualDataArr = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"体检报告";
    [self loadReportDetailData];

    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)setUpBaseUI {
    NSArray *titleArr = @[@"基本信息",@"体检汇总",@"体检异常",@"体检详情"];
    
    BasicInfoViewController *basicInfo = [[BasicInfoViewController alloc] init];
    basicInfo.infoModel = self.infoModel;
    
    ExamSummaryViewController *summary = [[ExamSummaryViewController alloc] init];
    summary.masterDoctor = self.masterDoctor;
    summary.dataArr = self.summaryDataArr;
    
    ExamExceptionsViewController *exceptions = [[ExamExceptionsViewController alloc] init];
    exceptions.dataArr = self.unusualDataArr;
    
    ExamDetailViewController *detail = [[ExamDetailViewController alloc] init];
    detail.dataArr = self.detailDataArr;
    
    GKSliderView *slider = [[GKSliderView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) titleArr:titleArr controllerNameArr:@[basicInfo,summary,exceptions,detail]];
    slider.titleFont = [UIFont systemFontOfSize:16];
    [self.view addSubview:slider];
}

- (void)loadReportDetailData {
    // AppendInfo = "6616032768;66";
    // AppendInfo = "6616032768;66";
    NSDictionary *param = @{@"customerId":self.custId,@"checkCode":self.checkCode,@"workNo":self.workNum};
    [[GKNetwork sharedInstance] GetUrl:kGetHealthReportURL param:param completionBlockSuccess:^(id responseObject) {
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:responseObject[@"message"]];
            return ;
        }
        
        NSDictionary *data = responseObject[@"Data"];
        NSArray *arr = data[@"DepartmentCheck"];
        // 解析体检详情数据
        for (NSDictionary *dict in arr) {
            DepartmentModel *model = [[DepartmentModel alloc] initWithDict:dict];
            NSMutableArray *dataArray = [model getUnusualDataArr];
            for (ResultModel *model in dataArray) {
                [self.unusualDataArr addObject:model];
            }
            [self.detailDataArr addObject:model];
        }
        
        //解析体检汇总数据
        NSArray *summary = data[@"GeneralSummarys"];
        for (NSString *content in summary) {
            SummarysModel *model = [[SummarysModel alloc] init];
            model.content = content;
            [self.summaryDataArr addObject:model];
        }
        self.masterDoctor = data[@"MasterDotor"];
        
        //解析客户基本信息数据
        NSDictionary *reportInfo = data[@"ReportInfoVM"];
        ReportInfoModel *infoModel = [[ReportInfoModel alloc] init];
        [infoModel setValuesForKeysWithDictionary:reportInfo];
        self.infoModel = infoModel;
        
        [self setUpBaseUI];
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
