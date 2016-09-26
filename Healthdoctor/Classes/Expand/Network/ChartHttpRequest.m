//
//  ChartHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ChartHttpRequest.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "ChartModel.h"
#import "HZUser.h"
#import "Config.h"
#import "HZUtils.h"

@implementation ChartHttpRequest

+ (void)requestData:(NSDictionary *)param completionBlock:(void (^)(NSMutableArray *, NSString *))completion {
    
    [[GKNetwork sharedInstance] GetUrl:kGetAskReplyURL param:param completionBlock:^(id responseObject, NSError *error) {
       
        NSMutableArray *dataArr = [NSMutableArray array];
        
        if (error) {
            //失败
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            NSString *message = responseObject[@"message"];
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(nil,message);
                return ;
            }
            
            NSArray *data = responseObject[@"Data"];
            if (data.count == 0) {
                completion(nil,@"全部加载完成");
                return;
            }
            for (NSDictionary *dict in data) {
                ChartModel *model = [[ChartModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                if ([model.isDoctorReply integerValue] == 1) {
                    model.consultType = @"1";
                }
                [dataArr addObject:model];
            }
            completion(dataArr,nil);

        }
    }];
}

+ (void)requestChartCusInfo:(NSDictionary *)param completionBlock:(void (^)(CusInfoModel *, NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kGetCusInfoURL param:param completionBlock:^(id responseObject, NSError *error) {
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
            CusInfoModel *model = [[CusInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:data];
            // model.commitOn = self.commitOn;
            completion(model,nil);
            
        }
    }];
}

+ (void)replyMessage:(NSDictionary *)param completionBlock:(void (^)(ChartModel *, NSString *))completion {
    HZUser *user = [Config getProfile];
    [[GKNetwork sharedInstance] postUrl:kAddDoctorReplyURL param:param completionBlock:^(id responseObject, NSError *error) {
        if (error) {
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(nil,responseObject[@"message"]);
                return ;
            }
            
            ChartModel *model = [[ChartModel alloc] init];
            model.consultType = @"1";
            model.isDoctorReply = @"1";
            model.content = param[@"ReplyContent"];
            model.photoUrl = user.photoUrl;
            model.commitOn = [HZUtils getDateWithDate:[NSDate date]];
            completion(model,nil);
        }
    }];
}
@end
