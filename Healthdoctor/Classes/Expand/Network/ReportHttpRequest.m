


//
//  ReportHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportHttpRequest.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "DepartmentModel.h"
#import "ResultModel.h"
#import "SummarysModel.h"
#import "ReportInfoModel.h"

@implementation ReportHttpRequest

+ (void)requestReport:(NSDictionary *)param completionBlock:(void (^)(NSDictionary *, NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kGetHealthReportURL param:param completionBlock:^(id responseObject, NSError *error) {
        NSMutableArray *detailDataArr = [NSMutableArray array];
//        NSMutableArray *unusualDataArr = [NSMutableArray array];
        NSMutableArray *summaryDataArr = [NSMutableArray array];
        
        if (error) {
            //失败
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(nil,responseObject[@"message"]);
                return ;
            }
            
            NSDictionary *data = responseObject[@"Data"];
            NSArray *arr = data[@"DepartmentCheck"];
            // 解析体检详情数据
            for (NSDictionary *dict in arr) {
                DepartmentModel *model = [[DepartmentModel alloc] initWithDict:dict];
                [detailDataArr addObject:model];
            }
            
            //解析体检异常项数据
            NSArray *unUsuals = data[@"AnomalyCheckResult"];
            NSMutableArray *unusualDataArr = [[ResultModel alloc] parseDataWithArr:unUsuals];
            
            //解析体检汇总数据
            NSArray *summary = data[@"GeneralSummarysForApp"];
            for (NSDictionary *content in summary) {
                
                SummarysModel *model = [[SummarysModel alloc] init];
                model.title = content[@"SummaryName"];
                model.content = content[@"SummaryDescription"];
                
                [summaryDataArr addObject:model];
            }
            NSString *masterDoctor = data[@"MasterDotor"];
            
            //解析客户基本信息数据
            NSDictionary *reportInfo = data[@"ReportInfoVM"];
            ReportInfoModel *infoModel = [[ReportInfoModel alloc] init];
            [infoModel setValuesForKeysWithDictionary:reportInfo];
            
            NSDictionary *dicts = @{@"reportInfo":infoModel,@"summary":summaryDataArr,@"unusual":unusualDataArr,@"medicalDetail":detailDataArr,@"masterDoctor":masterDoctor};
            completion(dicts,nil);
        }
    }];
}
@end
