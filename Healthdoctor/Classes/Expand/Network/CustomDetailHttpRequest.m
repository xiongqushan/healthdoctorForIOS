//
//  CustomDetailHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "CustomDetailHttpRequest.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "MedicalReportModel.h"
#import "PhotoCasesModel.h"

@implementation CustomDetailHttpRequest

+ (void)requestReportList:(NSDictionary *)param completionBlock:(void (^)(NSMutableArray *, NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kGetReportListURL param:param completionBlock:^(id responseObject, NSError *error) {
        NSMutableArray *dataArr = [NSMutableArray array];
        if (error) {
            //失败
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(nil, responseObject[@"message"]);
                return ;
            }
            
            if ([responseObject[@"Data"] isKindOfClass:[NSNull class]]) {
                completion(nil, @"没有体检报告");
                return;
            }
            
            NSArray *data = responseObject[@"Data"];
            for (NSDictionary *dict in data) {
                MedicalReportModel *model = [[MedicalReportModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
//                model.gender = self.genderLabel.text;
//                model.age = self.ageLabel.text;
                model.company = @"暂无";
                [dataArr addObject:model];
            }
            completion(dataArr, nil);
        }
    }];
}

+ (void)requestPhotoCasesList:(NSDictionary *)param completionBlock:(void (^)(NSMutableArray *, NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kReportPhotoListURL param:param completionBlock:^(id responseObject, NSError *error) {
        NSMutableArray *photoCase = [NSMutableArray array];
        if(error) {
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(nil,responseObject[@"message"]);
                return ;
            }
            
            if ([responseObject[@"Data"] isKindOfClass:[NSNull class]]) {
                completion(nil,@"没有照片病例");
                return;
            }
            
            for (NSDictionary *dict in responseObject[@"Data"]) {
                PhotoCasesModel *model = [[PhotoCasesModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                
                [photoCase addObject:model];
            }
            
            completion(photoCase,nil);
        }
    }];
}
@end
