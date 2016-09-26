//
//  GroupListHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "GroupListHttpRequest.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "HomeDetailModel.h"

@implementation GroupListHttpRequest

+ (instancetype)getInstatce {
    return [[GroupListHttpRequest alloc] init];
}

- (void)requestNewData:(NSDictionary *)param completionBlock:(void (^)(NSMutableArray *, NSString *))completion {
    
    [[GKNetwork sharedInstance] GetUrl:kGroupCustInfoListURL param:param completionBlock:^(id responseObject, NSError *error) {
        NSMutableArray *arr = [NSMutableArray array];
        
        if (error) {
            //失败
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
            return ;
        }
        
        NSDictionary *data = responseObject[@"Data"];
        NSString *message = responseObject[@"message"];
        
        if ([responseObject[@"state"] integerValue] == 1) {
            
            NSInteger count2 = [data[@"Count"] integerValue];
            if (count2 == 0) {
                
                completion(arr,@"没有该客户");
        
            }else {
                
                NSArray *dataArr = data[@"Data"];
                for (NSDictionary *dict in dataArr) {
                    HomeDetailModel *model = [[HomeDetailModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [arr addObject:model];
                }

                completion(arr,nil);
            }
        }else {
            completion(nil,message);
        }
        
    }];
}

- (void)requestMoreData:(NSDictionary *)param completionBlock:(void (^)(NSMutableArray *, NSString * ))completion {

    [[GKNetwork sharedInstance] GetUrl:kGroupCustInfoListURL param:param completionBlock:^(id responseObject, NSError *error) {
        NSMutableArray *arr = [NSMutableArray array];
        
        if (error) {
            //失败
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
            return ;
        }
        
        NSDictionary *data = responseObject[@"Data"];
        NSString *message = responseObject[@"message"];
        
        if ([responseObject[@"state"] integerValue] == 1) {
                
            NSArray *dataArr = data[@"Data"];
            for (NSDictionary *dict in dataArr) {
                HomeDetailModel *model = [[HomeDetailModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [arr addObject:model];
            }
            
            if (arr.count < 10) {
                completion(arr,nil);
            }else {
                completion(arr,nil);
            }
            
        }else {
            completion(nil,message);
        }
    }];
}

@end
